Return-Path: <dmaengine+bounces-372-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B1278044DA
	for <lists+dmaengine@lfdr.de>; Tue,  5 Dec 2023 03:27:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 890C3B20C4D
	for <lists+dmaengine@lfdr.de>; Tue,  5 Dec 2023 02:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22A3179C5;
	Tue,  5 Dec 2023 02:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PHy9zCzE"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FA8130D0;
	Mon,  4 Dec 2023 18:27:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701743226; x=1733279226;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kOpRCM/Alytm6Ynqn23OIlROnY/GAJM/+vJVGPgtI58=;
  b=PHy9zCzEY6L4VlLz9TDVuY9apzg7jdcwqxJzKYoOye53zw4QhGRAx6ar
   tGpppxa4Msf/+Ic7PAgylu2LROYRQjsr3fC3lpq/fcp+NIkecVbT0zwLG
   lo4Vo1tVkJ1wKfK6/vz4bBdCTwbp24W/oTyop3VXleGm9GDaX8FsyD9hh
   L0MERMCigohU54IXkIQdwLvxjehKfSmQuHTSTS7ru67TxfFgrXIbgjQce
   mnKVqKqzEvPUKbhaV+wr6xX2BHhotXnP+Nita3LvGkW0sUm5JKq0B/haY
   Q44vM0U8nvcvCsuA25K7v3dc0JDEUAw/KtGgdC6c+gV4TARIknpOwLj1C
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="706160"
X-IronPort-AV: E=Sophos;i="6.04,251,1695711600"; 
   d="scan'208";a="706160"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 18:27:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="770756219"
X-IronPort-AV: E=Sophos;i="6.04,251,1695711600"; 
   d="scan'208";a="770756219"
Received: from rex-z390-aorus-pro.sh.intel.com ([10.239.161.21])
  by orsmga002.jf.intel.com with ESMTP; 04 Dec 2023 18:26:57 -0800
From: Rex Zhang <rex.zhang@intel.com>
To: tom.zanussi@linux.intel.com
Cc: dave.jiang@intel.com,
	davem@davemloft.net,
	dmaengine@vger.kernel.org,
	fenghua.yu@intel.com,
	giovanni.cabiddu@intel.com,
	herbert@gondor.apana.org.au,
	james.guilford@intel.com,
	kanchana.p.sridhar@intel.com,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pavel@ucw.cz,
	rex.zhang@intel.com,
	tony.luck@intel.com,
	vinodh.gopal@intel.com,
	vkoul@kernel.org,
	wajdi.k.feghali@intel.com
Subject: Re: [PATCH v11 11/14] crypto: iaa - Add support for deflate-iaa compression algorithm
Date: Tue,  5 Dec 2023 10:26:55 +0800
Message-Id: <20231205022655.3616965-1-rex.zhang@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <1a44f8396c6b7014de9b9bde4d5f5a4dbf0ef7a1.camel@linux.intel.com>
References: <1a44f8396c6b7014de9b9bde4d5f5a4dbf0ef7a1.camel@linux.intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Tom,

On 2023-12-04 at 15:41:46 -0600, Tom Zanussi wrote:
> Hi Rex,
> 
> On Mon, 2023-12-04 at 23:00 +0800, Rex Zhang wrote:
> > Hi, Tom,
> > 
> > On 2023-12-01 at 14:10:32 -0600, Tom Zanussi wrote:
> > 
> > [snip]
> > 
> > > +static int iaa_wq_put(struct idxd_wq *wq)
> > > +{
> > > +       struct idxd_device *idxd = wq->idxd;
> > > +       struct iaa_wq *iaa_wq;
> > > +       bool free = false;
> > > +       int ret = 0;
> > > +
> > > +       spin_lock(&idxd->dev_lock);
> > > +       iaa_wq = idxd_wq_get_private(wq);
> > > +       if (iaa_wq) {
> > > +               iaa_wq->ref--;
> > > +               if (iaa_wq->ref == 0 && iaa_wq->remove) {
> > > +                       __free_iaa_wq(iaa_wq);
> > > +                       idxd_wq_set_private(wq, NULL);
> > > +                       free = true;
> > > +               }
> > > +               idxd_wq_put(wq);
> > > +       } else {
> > > +               ret = -ENODEV;
> > > +       }
> > > +       spin_unlock(&idxd->dev_lock);
> > __free_iaa_wq() may cause schedule, whether it should be move out of
> > the
> > context between spin_lock() and spin_unlock()?
> 
> Yeah, I suppose it makes more sense to have it below anyway, will move
> it there.
> 
> > > +       if (free)
> > > +               kfree(iaa_wq);
> > > +
> > > +       return ret;
> > > +}
> > 
> > [snip]
> > 
> > > @@ -800,12 +1762,38 @@ static void iaa_crypto_remove(struct
> > > idxd_dev *idxd_dev)
> > >  
> > >         remove_iaa_wq(wq);
> > >  
> > > +       spin_lock(&idxd->dev_lock);
> > > +       iaa_wq = idxd_wq_get_private(wq);
> > > +       if (!iaa_wq) {
> > > +               spin_unlock(&idxd->dev_lock);
> > > +               pr_err("%s: no iaa_wq available to remove\n",
> > > __func__);
> > > +               goto out;
> > > +       }
> > > +
> > > +       if (iaa_wq->ref) {
> > > +               iaa_wq->remove = true;
> > > +       } else {
> > > +               wq = iaa_wq->wq;
> > > +               __free_iaa_wq(iaa_wq);
> > > +               idxd_wq_set_private(wq, NULL);
> > > +               free = true;
> > > +       }
> > > +       spin_unlock(&idxd->dev_lock);
> > __free_iaa_wq() may cause schedule, whether it should be move out of
> > the
> > context between spin_lock() and spin_unlock()?
> 
> Same.
> 
> > > +
> > > +       if (free)
> > > +               kfree(iaa_wq);
> > > +
> > >         idxd_drv_disable_wq(wq);
> > >         rebalance_wq_table();
> > >  
> > > -       if (nr_iaa == 0)
> > > +       if (nr_iaa == 0) {
> > > +               iaa_crypto_enabled = false;
> > Is it necessary to add iaa_unregister_compression_device() here?
> > All iaa devices are disabled cause the variable first_wq will be
> > true,
> > if enable wq, iaa_register_compression_device() will fail due to the
> > algorithm is existed.
> 
> No, this is required by review input from a previous version - the
> compression device can only be unregistered on module exit.
Do it mean disabling all WQs followed by enabling WQ is unacceptable?
User must do "rmmod iaa_crypto" before enabling WQ in this case.

Thanks.
> 
> Thanks,
> 
> Tom
> 
> > >                 free_wq_table();
> > > +               module_put(THIS_MODULE);
> > >  
> > > +               pr_info("iaa_crypto now DISABLED\n");
> > > +       }
> > > +out:
> > >         mutex_unlock(&iaa_devices_lock);
> > >         mutex_unlock(&wq->wq_lock);
> > >  }
> > 
> > [snip]
> > 
> > Thanks,
> > Rex Zhang
> > > -- 
> > > 2.34.1
> > > 
> 

