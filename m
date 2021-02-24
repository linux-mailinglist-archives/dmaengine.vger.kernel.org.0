Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05CE3324336
	for <lists+dmaengine@lfdr.de>; Wed, 24 Feb 2021 18:33:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbhBXRc5 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 24 Feb 2021 12:32:57 -0500
Received: from mga03.intel.com ([134.134.136.65]:37918 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235558AbhBXRcy (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 24 Feb 2021 12:32:54 -0500
IronPort-SDR: mOwnlxIHwIrbMXqs3Rv9WgEn7zIqwB4rSHv/Re77ZZQz67zNji3+86MNCOvsFDB4IHaDJK0ILl
 PiWHM7nDqrog==
X-IronPort-AV: E=McAfee;i="6000,8403,9905"; a="185302036"
X-IronPort-AV: E=Sophos;i="5.81,203,1610438400"; 
   d="scan'208";a="185302036"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2021 09:32:08 -0800
IronPort-SDR: 7A0t3Dg7zRRlPdwT8m/I8GSxg/wPGVXyhs2bJ0GvhG5jmZMM3g+nGDRWe7Z6lbQj0GclXsy2GE
 M7mEDdeC0FdA==
X-IronPort-AV: E=Sophos;i="5.81,203,1610438400"; 
   d="scan'208";a="403813674"
Received: from djiang5-mobl1.amr.corp.intel.com (HELO [10.212.198.74]) ([10.212.198.74])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2021 09:32:07 -0800
Subject: Re: [PATCH v2] dmaengine: idxd: Do not use devm for 'struct device'
 object allocation
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Vinod Koul <vkoul@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
        dmaengine@vger.kernel.org
References: <161418136625.1883632.9123020856542653686.stgit@djiang5-desk3.ch.intel.com>
 <CAPcyv4igM0O2U2+vqJRPL+Rh_pLydwdYpTorxhPa2MaDz-naJQ@mail.gmail.com>
From:   Dave Jiang <dave.jiang@intel.com>
Message-ID: <ed5dd7c1-76be-468c-6453-3a3dc645d2a4@intel.com>
Date:   Wed, 24 Feb 2021 10:32:07 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CAPcyv4igM0O2U2+vqJRPL+Rh_pLydwdYpTorxhPa2MaDz-naJQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 2/24/2021 10:07 AM, Dan Williams wrote:
> On Wed, Feb 24, 2021 at 7:44 AM Dave Jiang <dave.jiang@intel.com> wrote:
>> Remove devm_* allocation of memory of 'struct device' objects.
>> The devm_* lifetime is incompatible with device->release() lifetime.
>> Address issues flagged by CONFIG_DEBUG_KOBJECT_RELEASE. Add release
>> functions for each component in order to free the allocated memory at
>> the appropriate time. Each component such as wq, engine, and group now
>> needs to be allocated individually in order to setup the lifetime properly.
>>
>> Reported-by: Jason Gunthorpe <jgg@nvidia.com>
>> Fixes: bfe1d56091c1 ("dmaengine: idxd: Init and probe for Intel data accelerators")
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
>> ---
>>
>> v2:
>> - Remove all devm_* alloc for idxd_device (Jason)
>> - Add kref dep for dma_dev (Jason)
>>
>>   drivers/dma/idxd/device.c |   24 +++--
>>   drivers/dma/idxd/dma.c    |   13 +++
>>   drivers/dma/idxd/idxd.h   |    6 +
>>   drivers/dma/idxd/init.c   |  212 +++++++++++++++++++++++++++++++++++++--------
>>   drivers/dma/idxd/irq.c    |    6 +
>>   drivers/dma/idxd/sysfs.c  |   79 ++++++++++++-----
>>   6 files changed, 260 insertions(+), 80 deletions(-)
>>
>> diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
>> index 205156afeb54..39cb311ad333 100644
>> --- a/drivers/dma/idxd/device.c
>> +++ b/drivers/dma/idxd/device.c
>> @@ -541,7 +541,7 @@ void idxd_device_wqs_clear_state(struct idxd_device *idxd)
>>          lockdep_assert_held(&idxd->dev_lock);
>>
>>          for (i = 0; i < idxd->max_wqs; i++) {
>> -               struct idxd_wq *wq = &idxd->wqs[i];
>> +               struct idxd_wq *wq = idxd->wqs[i];
>>
>>                  if (wq->state == IDXD_WQ_ENABLED) {
>>                          idxd_wq_disable_cleanup(wq);
>> @@ -721,7 +721,7 @@ static int idxd_groups_config_write(struct idxd_device *idxd)
>>                  ioread32(idxd->reg_base + IDXD_GENCFG_OFFSET));
>>
>>          for (i = 0; i < idxd->max_groups; i++) {
>> -               struct idxd_group *group = &idxd->groups[i];
>> +               struct idxd_group *group = idxd->groups[i];
>>
>>                  idxd_group_config_write(group);
>>          }
>> @@ -793,7 +793,7 @@ static int idxd_wqs_config_write(struct idxd_device *idxd)
>>          int i, rc;
>>
>>          for (i = 0; i < idxd->max_wqs; i++) {
>> -               struct idxd_wq *wq = &idxd->wqs[i];
>> +               struct idxd_wq *wq = idxd->wqs[i];
>>
>>                  rc = idxd_wq_config_write(wq);
>>                  if (rc < 0)
>> @@ -809,7 +809,7 @@ static void idxd_group_flags_setup(struct idxd_device *idxd)
>>
>>          /* TC-A 0 and TC-B 1 should be defaults */
>>          for (i = 0; i < idxd->max_groups; i++) {
>> -               struct idxd_group *group = &idxd->groups[i];
>> +               struct idxd_group *group = idxd->groups[i];
>>
>>                  if (group->tc_a == -1)
>>                          group->tc_a = group->grpcfg.flags.tc_a = 0;
>> @@ -836,12 +836,12 @@ static int idxd_engines_setup(struct idxd_device *idxd)
>>          struct idxd_group *group;
>>
>>          for (i = 0; i < idxd->max_groups; i++) {
>> -               group = &idxd->groups[i];
>> +               group = idxd->groups[i];
>>                  group->grpcfg.engines = 0;
>>          }
>>
>>          for (i = 0; i < idxd->max_engines; i++) {
>> -               eng = &idxd->engines[i];
>> +               eng = idxd->engines[i];
>>                  group = eng->group;
>>
>>                  if (!group)
>> @@ -865,13 +865,13 @@ static int idxd_wqs_setup(struct idxd_device *idxd)
>>          struct device *dev = &idxd->pdev->dev;
>>
>>          for (i = 0; i < idxd->max_groups; i++) {
>> -               group = &idxd->groups[i];
>> +               group = idxd->groups[i];
>>                  for (j = 0; j < 4; j++)
>>                          group->grpcfg.wqs[j] = 0;
>>          }
>>
>>          for (i = 0; i < idxd->max_wqs; i++) {
>> -               wq = &idxd->wqs[i];
>> +               wq = idxd->wqs[i];
>>                  group = wq->group;
>>
>>                  if (!wq->group)
>> @@ -982,7 +982,7 @@ static void idxd_group_load_config(struct idxd_group *group)
>>
>>                          /* Set group assignment for wq if wq bit is set */
>>                          if (group->grpcfg.wqs[i] & BIT(j)) {
>> -                               wq = &idxd->wqs[id];
>> +                               wq = idxd->wqs[id];
>>                                  wq->group = group;
>>                          }
>>                  }
>> @@ -999,7 +999,7 @@ static void idxd_group_load_config(struct idxd_group *group)
>>                          break;
>>
>>                  if (group->grpcfg.engines & BIT(i)) {
>> -                       struct idxd_engine *engine = &idxd->engines[i];
>> +                       struct idxd_engine *engine = idxd->engines[i];
>>
>>                          engine->group = group;
>>                  }
>> @@ -1020,13 +1020,13 @@ int idxd_device_load_config(struct idxd_device *idxd)
>>          idxd->token_limit = reg.token_limit;
>>
>>          for (i = 0; i < idxd->max_groups; i++) {
>> -               struct idxd_group *group = &idxd->groups[i];
>> +               struct idxd_group *group = idxd->groups[i];
>>
>>                  idxd_group_load_config(group);
>>          }
>>
>>          for (i = 0; i < idxd->max_wqs; i++) {
>> -               struct idxd_wq *wq = &idxd->wqs[i];
>> +               struct idxd_wq *wq = idxd->wqs[i];
>>
>>                  rc = idxd_wq_load_config(wq);
>>                  if (rc < 0)
>> diff --git a/drivers/dma/idxd/dma.c b/drivers/dma/idxd/dma.c
>> index a15e50126434..dd834764852c 100644
>> --- a/drivers/dma/idxd/dma.c
>> +++ b/drivers/dma/idxd/dma.c
>> @@ -156,11 +156,15 @@ dma_cookie_t idxd_dma_tx_submit(struct dma_async_tx_descriptor *tx)
>>
>>   static void idxd_dma_release(struct dma_device *device)
>>   {
>> +       struct idxd_device *idxd = container_of(device, struct idxd_device, dma_dev);
>> +
>> +       put_device(&idxd->conf_dev);
>>   }
>>
>>   int idxd_register_dma_device(struct idxd_device *idxd)
>>   {
>>          struct dma_device *dma = &idxd->dma_dev;
>> +       int rc;
>>
>>          INIT_LIST_HEAD(&dma->channels);
>>          dma->dev = &idxd->pdev->dev;
>> @@ -178,8 +182,15 @@ int idxd_register_dma_device(struct idxd_device *idxd)
>>          dma->device_issue_pending = idxd_dma_issue_pending;
>>          dma->device_alloc_chan_resources = idxd_dma_alloc_chan_resources;
>>          dma->device_free_chan_resources = idxd_dma_free_chan_resources;
>> +       get_device(&idxd->conf_dev);
>>
>> -       return dma_async_device_register(&idxd->dma_dev);
>> +       rc = dma_async_device_register(&idxd->dma_dev);
>> +       if (rc < 0) {
>> +               put_device(&idxd->conf_dev);
>> +               return rc;
>> +       }
>> +
>> +       return 0;
>>   }
>>
>>   void idxd_unregister_dma_device(struct idxd_device *idxd)
>> diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
>> index a9386a66ab72..c2e89b3e3828 100644
>> --- a/drivers/dma/idxd/idxd.h
>> +++ b/drivers/dma/idxd/idxd.h
>> @@ -181,9 +181,9 @@ struct idxd_device {
>>
>>          spinlock_t dev_lock;    /* spinlock for device */
>>          struct completion *cmd_done;
>> -       struct idxd_group *groups;
>> -       struct idxd_wq *wqs;
>> -       struct idxd_engine *engines;
>> +       struct idxd_group **groups;
>> +       struct idxd_wq **wqs;
>> +       struct idxd_engine **engines;
>>
>>          struct iommu_sva *sva;
>>          unsigned int pasid;
>> diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
>> index 0bd7b33b436a..e87112a6617e 100644
>> --- a/drivers/dma/idxd/init.c
>> +++ b/drivers/dma/idxd/init.c
>> @@ -73,8 +73,8 @@ static int idxd_setup_interrupts(struct idxd_device *idxd)
>>                  goto err_no_irq;
>>          }
>>
>> -       idxd->msix_entries = devm_kzalloc(dev, sizeof(struct msix_entry) *
>> -                       msixcnt, GFP_KERNEL);
>> +       idxd->msix_entries = kzalloc_node(sizeof(struct msix_entry) * msixcnt, GFP_KERNEL,
>> +                                         dev_to_node(dev));
>>          if (!idxd->msix_entries) {
>>                  rc = -ENOMEM;
>>                  goto err_no_irq;
>> @@ -94,9 +94,8 @@ static int idxd_setup_interrupts(struct idxd_device *idxd)
>>           * We implement 1 completion list per MSI-X entry except for
>>           * entry 0, which is for errors and others.
>>           */
>> -       idxd->irq_entries = devm_kcalloc(dev, msixcnt,
>> -                                        sizeof(struct idxd_irq_entry),
>> -                                        GFP_KERNEL);
>> +       idxd->irq_entries = kcalloc_node(msixcnt, sizeof(struct idxd_irq_entry),
>> +                                        GFP_KERNEL, dev_to_node(dev));
>>          if (!idxd->irq_entries) {
>>                  rc = -ENOMEM;
>>                  goto err_no_irq;
>> @@ -178,43 +177,132 @@ static int idxd_setup_interrupts(struct idxd_device *idxd)
>>          return rc;
>>   }
>>
>> +static int idxd_allocate_wqs(struct idxd_device *idxd)
>> +{
>> +       struct device *dev = &idxd->pdev->dev;
>> +       struct idxd_wq *wq;
>> +       int i, rc;
>> +
>> +       idxd->wqs = kcalloc_node(idxd->max_wqs, sizeof(struct idxd_wq *),
>> +                                GFP_KERNEL, dev_to_node(dev));
>> +       if (!idxd->wqs)
>> +               return -ENOMEM;
>> +
>> +       for (i = 0; i < idxd->max_wqs; i++) {
>> +               wq = kzalloc_node(sizeof(*wq), GFP_KERNEL, dev_to_node(dev));
>> +               if (!wq) {
>> +                       rc = -ENOMEM;
>> +                       goto err;
>> +               }
>> +
>> +               idxd->wqs[i] = wq;
>> +       }
>> +
>> +       return 0;
>> +
>> + err:
>> +       while (--i)
>> +               kfree(idxd->wqs[i]);
>> +       kfree(idxd->wqs);
>> +       idxd->wqs = NULL;
>> +       return rc;
>> +}
>> +
>> +static int idxd_allocate_engines(struct idxd_device *idxd)
>> +{
>> +       struct idxd_engine *engine;
>> +       struct device *dev = &idxd->pdev->dev;
>> +       int i, rc;
>> +
>> +       idxd->engines = kcalloc_node(idxd->max_engines, sizeof(struct idxd_engine *),
>> +                                    GFP_KERNEL, dev_to_node(dev));
>> +       if (!idxd->engines)
>> +               return -ENOMEM;
>> +
>> +       for (i = 0; i < idxd->max_engines; i++) {
>> +               engine = kzalloc_node(sizeof(*engine), GFP_KERNEL, dev_to_node(dev));
>> +               if (!engine) {
>> +                       rc = -ENOMEM;
>> +                       goto err;
>> +               }
>> +
>> +               idxd->engines[i] = engine;
>> +       }
>> +
>> +       return 0;
>> +
>> + err:
>> +       while (--i)
>> +               kfree(idxd->engines[i]);
>> +       kfree(idxd->engines);
>> +       idxd->engines = NULL;
>> +       return rc;
>> +}
>> +
>> +static int idxd_allocate_groups(struct idxd_device *idxd)
>> +{
>> +       struct device *dev = &idxd->pdev->dev;
>> +       struct idxd_group *group;
>> +       int i, rc;
>> +
>> +       idxd->groups = kcalloc_node(idxd->max_groups, sizeof(struct idxd_group *),
>> +                                   GFP_KERNEL, dev_to_node(dev));
>> +       if (!idxd->groups)
>> +               return -ENOMEM;
>> +
>> +       for (i = 0; i < idxd->max_groups; i++) {
>> +               group = kzalloc_node(sizeof(*group), GFP_KERNEL, dev_to_node(dev));
>> +               if (!group) {
>> +                       rc = -ENOMEM;
>> +                       goto err;
>> +               }
>> +
>> +               idxd->groups[i] = group;
>> +       }
>> +
>> +       return 0;
>> +
>> + err:
>> +       while (--i)
>> +               kfree(idxd->groups[i]);
>> +       kfree(idxd->groups);
>> +       idxd->groups = NULL;
>> +       return rc;
>> +}
>> +
>>   static int idxd_setup_internals(struct idxd_device *idxd)
>>   {
>>          struct device *dev = &idxd->pdev->dev;
>> -       int i;
>> +       int i, rc;
>>
>>          init_waitqueue_head(&idxd->cmd_waitq);
>>
>>          if (idxd->hw.cmd_cap & BIT(IDXD_CMD_REQUEST_INT_HANDLE)) {
>> -               idxd->int_handles = devm_kcalloc(dev, idxd->max_wqs, sizeof(int), GFP_KERNEL);
>> +               idxd->int_handles = kcalloc_node(idxd->max_wqs, sizeof(int), GFP_KERNEL,
>> +                                                dev_to_node(dev));
>>                  if (!idxd->int_handles)
>>                          return -ENOMEM;
>>          }
>>
>> -       idxd->groups = devm_kcalloc(dev, idxd->max_groups,
>> -                                   sizeof(struct idxd_group), GFP_KERNEL);
>> -       if (!idxd->groups)
>> -               return -ENOMEM;
>> +       rc = idxd_allocate_groups(idxd);
>> +       if (rc < 0)
>> +               return rc;
>>
>>          for (i = 0; i < idxd->max_groups; i++) {
>> -               idxd->groups[i].idxd = idxd;
>> -               idxd->groups[i].id = i;
>> -               idxd->groups[i].tc_a = -1;
>> -               idxd->groups[i].tc_b = -1;
>> -       }
>> +               struct idxd_group *group = idxd->groups[i];
>>
>> -       idxd->wqs = devm_kcalloc(dev, idxd->max_wqs, sizeof(struct idxd_wq),
>> -                                GFP_KERNEL);
>> -       if (!idxd->wqs)
>> -               return -ENOMEM;
>> +               group->idxd = idxd;
>> +               group->id = i;
>> +               group->tc_a = -1;
>> +               group->tc_b = -1;
>> +       }
>>
>> -       idxd->engines = devm_kcalloc(dev, idxd->max_engines,
>> -                                    sizeof(struct idxd_engine), GFP_KERNEL);
>> -       if (!idxd->engines)
>> -               return -ENOMEM;
>> +       rc = idxd_allocate_wqs(idxd);
>> +       if (rc < 0)
>> +               return rc;
>>
>>          for (i = 0; i < idxd->max_wqs; i++) {
>> -               struct idxd_wq *wq = &idxd->wqs[i];
>> +               struct idxd_wq *wq = idxd->wqs[i];
>>
>>                  wq->id = i;
>>                  wq->idxd = idxd;
>> @@ -222,15 +310,21 @@ static int idxd_setup_internals(struct idxd_device *idxd)
>>                  wq->idxd_cdev.minor = -1;
>>                  wq->max_xfer_bytes = idxd->max_xfer_bytes;
>>                  wq->max_batch_size = idxd->max_batch_size;
>> -               wq->wqcfg = devm_kzalloc(dev, idxd->wqcfg_size, GFP_KERNEL);
>> +               wq->wqcfg = kzalloc_node(idxd->wqcfg_size, GFP_KERNEL, dev_to_node(dev));
>>                  if (!wq->wqcfg)
>>                          return -ENOMEM;
>>                  init_completion(&wq->wq_dead);
>>          }
>>
>> +       rc = idxd_allocate_engines(idxd);
>> +       if (rc < 0)
>> +               return rc;
>> +
>>          for (i = 0; i < idxd->max_engines; i++) {
>> -               idxd->engines[i].idxd = idxd;
>> -               idxd->engines[i].id = i;
>> +               struct idxd_engine *engine = idxd->engines[i];
>> +
>> +               engine->idxd = idxd;
>> +               engine->id = i;
>>          }
>>
>>          idxd->wq = create_workqueue(dev_name(dev));
>> @@ -318,7 +412,7 @@ static struct idxd_device *idxd_alloc(struct pci_dev *pdev)
>>          struct device *dev = &pdev->dev;
>>          struct idxd_device *idxd;
>>
>> -       idxd = devm_kzalloc(dev, sizeof(struct idxd_device), GFP_KERNEL);
>> +       idxd = kzalloc_node(sizeof(*idxd), GFP_KERNEL, dev_to_node(dev));
>>          if (!idxd)
>>                  return NULL;
>>
>> @@ -436,6 +530,36 @@ static void idxd_type_init(struct idxd_device *idxd)
>>                  idxd->compl_size = sizeof(struct iax_completion_record);
>>   }
>>
>> +static void idxd_free(struct idxd_device *idxd)
>> +{
>> +       int i;
>> +
>> +       if (idxd->wqs) {
>> +               for (i = 0; i < idxd->max_wqs; i++) {
>> +                       kfree(idxd->wqs[i]->wqcfg);
>> +                       kfree(idxd->wqs[i]);
>> +               }
>> +               kfree(idxd->wqs);
>> +       }
>> +
>> +       if (idxd->engines) {
>> +               for (i = 0; i < idxd->max_engines; i++)
>> +                       kfree(idxd->engines[i]);
>> +               kfree(idxd->engines);
>> +       }
>> +
>> +       if (idxd->groups) {
>> +               for (i = 0; i < idxd->max_groups; i++)
>> +                       kfree(idxd->groups[i]);
>> +               kfree(idxd->groups);
>> +       }
>> +
>> +       kfree(idxd->int_handles);
>> +       kfree(idxd->msix_entries);
>> +       kfree(idxd->irq_entries);
>> +       kfree(idxd);
>> +}
>> +
>>   static int idxd_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>>   {
>>          struct device *dev = &pdev->dev;
>> @@ -453,21 +577,23 @@ static int idxd_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>>
>>          dev_dbg(dev, "Mapping BARs\n");
>>          idxd->reg_base = pcim_iomap(pdev, IDXD_MMIO_BAR, 0);
>> -       if (!idxd->reg_base)
>> -               return -ENOMEM;
>> +       if (!idxd->reg_base) {
>> +               rc = -ENOMEM;
>> +               goto err;
>> +       }
>>
>>          dev_dbg(dev, "Set DMA masks\n");
>>          rc = pci_set_dma_mask(pdev, DMA_BIT_MASK(64));
>>          if (rc)
>>                  rc = pci_set_dma_mask(pdev, DMA_BIT_MASK(32));
>>          if (rc)
>> -               return rc;
>> +               goto err;
>>
>>          rc = pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(64));
>>          if (rc)
>>                  rc = pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(32));
>>          if (rc)
>> -               return rc;
>> +               goto err;
>>
>>          idxd_set_type(idxd);
>>
>> @@ -481,13 +607,15 @@ static int idxd_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>>          rc = idxd_probe(idxd);
>>          if (rc) {
>>                  dev_err(dev, "Intel(R) IDXD DMA Engine init failed\n");
>> -               return -ENODEV;
>> +               rc = -ENODEV;
>> +               goto err;
>>          }
>>
>>          rc = idxd_setup_sysfs(idxd);
>>          if (rc) {
>>                  dev_err(dev, "IDXD sysfs setup failed\n");
>> -               return -ENODEV;
>> +               rc = -ENODEV;
>> +               goto err;
>>          }
>>
>>          idxd->state = IDXD_DEV_CONF_READY;
>> @@ -496,6 +624,10 @@ static int idxd_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>>                   idxd->hw.version);
>>
>>          return 0;
>> +
>> + err:
>> +       idxd_free(idxd);
>> +       return rc;
>>   }
>>
>>   static void idxd_flush_pending_llist(struct idxd_irq_entry *ie)
>> @@ -530,7 +662,7 @@ static void idxd_wqs_quiesce(struct idxd_device *idxd)
>>          int i;
>>
>>          for (i = 0; i < idxd->max_wqs; i++) {
>> -               wq = &idxd->wqs[i];
>> +               wq = idxd->wqs[i];
>>                  if (wq->state == IDXD_WQ_ENABLED && wq->type == IDXD_WQT_KERNEL)
>>                          idxd_wq_quiesce(wq);
>>          }
>> @@ -586,15 +718,19 @@ static void idxd_shutdown(struct pci_dev *pdev)
>>   static void idxd_remove(struct pci_dev *pdev)
>>   {
>>          struct idxd_device *idxd = pci_get_drvdata(pdev);
>> +       int id = idxd->id;
>> +       enum idxd_type type = idxd->type;
>>
>>          dev_dbg(&pdev->dev, "%s called\n", __func__);
>> -       idxd_cleanup_sysfs(idxd);
>>          idxd_shutdown(pdev);
>>          if (device_pasid_enabled(idxd))
>>                  idxd_disable_system_pasid(idxd);
>> +       idxd_cleanup_sysfs(idxd);
>>          mutex_lock(&idxd_idr_lock);
>> -       idr_remove(&idxd_idrs[idxd->type], idxd->id);
>> +       idr_remove(&idxd_idrs[type], id);
>>          mutex_unlock(&idxd_idr_lock);
>> +       /* Release to free everything */
>> +       put_device(&idxd->conf_dev);
>>   }
>>
>>   static struct pci_driver idxd_pci_driver = {
>> diff --git a/drivers/dma/idxd/irq.c b/drivers/dma/idxd/irq.c
>> index f1463fc58112..7b0181532f77 100644
>> --- a/drivers/dma/idxd/irq.c
>> +++ b/drivers/dma/idxd/irq.c
>> @@ -45,7 +45,7 @@ static void idxd_device_reinit(struct work_struct *work)
>>                  goto out;
>>
>>          for (i = 0; i < idxd->max_wqs; i++) {
>> -               struct idxd_wq *wq = &idxd->wqs[i];
>> +               struct idxd_wq *wq = idxd->wqs[i];
>>
>>                  if (wq->state == IDXD_WQ_ENABLED) {
>>                          rc = idxd_wq_enable(wq);
>> @@ -130,7 +130,7 @@ static int process_misc_interrupts(struct idxd_device *idxd, u32 cause)
>>
>>                  if (idxd->sw_err.valid && idxd->sw_err.wq_idx_valid) {
>>                          int id = idxd->sw_err.wq_idx;
>> -                       struct idxd_wq *wq = &idxd->wqs[id];
>> +                       struct idxd_wq *wq = idxd->wqs[id];
>>
>>                          if (wq->type == IDXD_WQT_USER)
>>                                  wake_up_interruptible(&wq->idxd_cdev.err_queue);
>> @@ -138,7 +138,7 @@ static int process_misc_interrupts(struct idxd_device *idxd, u32 cause)
>>                          int i;
>>
>>                          for (i = 0; i < idxd->max_wqs; i++) {
>> -                               struct idxd_wq *wq = &idxd->wqs[i];
>> +                               struct idxd_wq *wq = idxd->wqs[i];
>>
>>                                  if (wq->type == IDXD_WQT_USER)
>>                                          wake_up_interruptible(&wq->idxd_cdev.err_queue);
>> diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
>> index 6bf27529464c..c9546e5ef16c 100644
>> --- a/drivers/dma/idxd/sysfs.c
>> +++ b/drivers/dma/idxd/sysfs.c
>> @@ -16,26 +16,56 @@ static char *idxd_wq_type_names[] = {
>>          [IDXD_WQT_USER]         = "user",
>>   };
>>
>> -static void idxd_conf_device_release(struct device *dev)
>> +static void idxd_conf_group_release(struct device *dev)
>>   {
>> -       dev_dbg(dev, "%s for %s\n", __func__, dev_name(dev));
>> +       struct idxd_group *group = container_of(dev, struct idxd_group, conf_dev);
>> +
>> +       kfree(group);
>>   }
>>
>>   static struct device_type idxd_group_device_type = {
>>          .name = "group",
>> -       .release = idxd_conf_device_release,
>> +       .release = idxd_conf_group_release,
>>   };
>>
>> +static void idxd_conf_wq_release(struct device *dev)
>> +{
>> +       struct idxd_wq *wq = container_of(dev, struct idxd_wq, conf_dev);
>> +
>> +       kfree(wq->wqcfg);
>> +       kfree(wq);
>> +}
>> +
>>   static struct device_type idxd_wq_device_type = {
>>          .name = "wq",
>> -       .release = idxd_conf_device_release,
>> +       .release = idxd_conf_wq_release,
>>   };
>>
>> +static void idxd_conf_engine_release(struct device *dev)
>> +{
>> +       struct idxd_engine *engine = container_of(dev, struct idxd_engine, conf_dev);
>> +
>> +       kfree(engine);
>> +}
>> +
>>   static struct device_type idxd_engine_device_type = {
>>          .name = "engine",
>> -       .release = idxd_conf_device_release,
>> +       .release = idxd_conf_engine_release,
>>   };
>>
>> +static void idxd_conf_device_release(struct device *dev)
>> +{
>> +       struct idxd_device *idxd = container_of(dev, struct idxd_device, conf_dev);
>> +
>> +       kfree(idxd->groups);
>> +       kfree(idxd->wqs);
>> +       kfree(idxd->engines);
> Why do you need arrays of groups, wqs, and engines? Can't this be
> handled by iterating the children of idxd? In other words, child
> devices are already tracked on a list underneath their parent, do you
> need these arrays?
>
> I.e. use device_for_each_child() or device_find_child() for these
> lookups. Then it's also fully dynamic.

Given that the max number of those sub-components are known and small, 
we can access specific component directly and quickly rather than all 
the overhead of device_find_child(). I can take a look follow on and see 
if the code really need the direct indexing for any critical paths.


>
> I'd say this is follow-on work post bug-fix for the current lifetime violation.
>
>> +       kfree(idxd->msix_entries);
>> +       kfree(idxd->irq_entries);
>> +       kfree(idxd->int_handles);
> These seem tied to the lifetime of the driver bind to the pci_device
> not the conf_dev, or are those lines blurred here?

Jason asked those to be not allocated by devm_* so there wouldn't be any 
inter-mixing of allocation methods and causing a mess.


>> +       kfree(idxd);
