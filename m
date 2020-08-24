Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71E8824F33B
	for <lists+dmaengine@lfdr.de>; Mon, 24 Aug 2020 09:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725947AbgHXHmJ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 24 Aug 2020 03:42:09 -0400
Received: from mail-bn8nam12on2058.outbound.protection.outlook.com ([40.107.237.58]:13793
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725926AbgHXHmI (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 24 Aug 2020 03:42:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kqW9yisrQtcoDYtZaAo3CJjXF2sgdjJNoREq1MwGCT59OJzhknGDQ9r0nVES/xmdQFPr1NCqSGpRcALByMFe5KVdar/6V6mE5BZ10OZeUWy7TGtuzZhFjH+XEirGxAcSTySCV6FDQ9/g7NibdaNByyNFSSJeRE36Ev7WbspDpk5rJ+HyvIE7Ag9i1jJk6+szXlHMlnObj8D1GB+3wtjzb3rvDmnd9oxbUtys/I7FxAvQR+uPnZh0/ffo5LNaBuOymjy8ZuDOj7UB7q2y+v9gVpexMwe0O9Y89asFKomtbGMDukbuD3sk6izFzR6AA7O65YHHHypSkUUiOVmTVBXOBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F7RWiyLL8fXt/HQlN2iuDVOP9NF/umiGAyERJDffOC0=;
 b=N98hkNU1hKbwtiQaN6cfX1iqx4f5+NF0mb347uL3gkrxRrwjY/HkhjQA7KS/UGqtFYir9AvuMnbeBql1nojTsCjX7xMx5u37WmYDklxRV9YSkTWPJzi+AL7oZs+T4kXGaIWpdsEQIDC3o2ef8QWIX0MBQuEmkfTYbLw0AKHfnoEkBSqc7f1Y3ob5MWRWsUoeDMns4e/m2W7YlbrJLANq1p8Xzfh4wWGbaUjenQEtX72R1wce83qZetXPRleeY3zyU1kuk6hJ+LeqzrCzQSa3o3fhjCEgh55S5IyIZRf/KwdUmLMtLdF4S8NPllpvtJ23etBC2LEow9qPsw0AxTxlyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F7RWiyLL8fXt/HQlN2iuDVOP9NF/umiGAyERJDffOC0=;
 b=ZDjnWbW1rXM2ibsx3Lu6R1GidBDNUMa1GZiaNnabTbLptIpTT3e1SNp8oj1CZBOd0oEXgiExSQL7q7H/Drl1Bu2P6Q16u0RhlXDZTXrCf6KZZCoMH70aY7ihnCoM0mR6vhDex4A3lBhQMl8VOffLJ2Xd0Yn0v7qL7wLLc8dFiDg=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3540.namprd12.prod.outlook.com (2603:10b6:408:6c::33)
 by BN6PR1201MB0082.namprd12.prod.outlook.com (2603:10b6:405:53::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25; Mon, 24 Aug
 2020 07:42:04 +0000
Received: from BN8PR12MB3540.namprd12.prod.outlook.com
 ([fe80::b5a6:78c7:bdd1:543]) by BN8PR12MB3540.namprd12.prod.outlook.com
 ([fe80::b5a6:78c7:bdd1:543%7]) with mapi id 15.20.3305.026; Mon, 24 Aug 2020
 07:42:04 +0000
Subject: Re: [PATCH v5 1/3] dmaengine: ptdma: Initial driver for the AMD PTDMA
 controller
To:     Vinod Koul <vkoul@kernel.org>, Sanjay R Mehta <Sanju.Mehta@amd.com>
Cc:     gregkh@linuxfoundation.org, dan.j.williams@intel.com,
        Thomas.Lendacky@amd.com, Shyam-sundar.S-k@amd.com,
        Nehal-bakulchandra.Shah@amd.com, robh@kernel.org,
        mchehab+samsung@kernel.org, davem@davemloft.net,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
References: <1592356288-42064-1-git-send-email-Sanju.Mehta@amd.com>
 <1592356288-42064-2-git-send-email-Sanju.Mehta@amd.com>
 <20200703071841.GJ273932@vkoul-mobl>
From:   Sanjay R Mehta <sanmehta@amd.com>
Message-ID: <19b20b55-0748-fb3c-755d-87ee6bdccf48@amd.com>
Date:   Mon, 24 Aug 2020 13:11:33 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200703071841.GJ273932@vkoul-mobl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1PR0101CA0060.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:19::22) To BN8PR12MB3540.namprd12.prod.outlook.com
 (2603:10b6:408:6c::33)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by BM1PR0101CA0060.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:19::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24 via Frontend Transport; Mon, 24 Aug 2020 07:42:00 +0000
X-Originating-IP: [165.204.159.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c0168afc-36a3-44f0-651e-08d8480131b1
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0082:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR1201MB008279BEFBE9214F87CBDA11E5560@BN6PR1201MB0082.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GAimI94vhV8EMAEnJi6AISzT6VfpG6izsMv4bba+Iz9CuP9iXCGnMwbtgUn6LLfO9TlAnCwCvgZLv0eYCn9EA2pTwZZ6MvaOUSwZu+1GqZblvH/LUmnZXTTKMUJ3oMWrQI319EzmNn+Fm4KJZeqIlYn/YGBQPYKZE/9fhmEAo5AC2wNjT/sENKHqQZV42fTp7U/u3x/pfYvXoyHVbdoCXia173VzD7FgzkqbeO6MNO82Db/FjTzrHmmfA0wyVXUQuqK8CNA9wNSWoI8+R5vmubobdy0BmTHqYBnhBEEPMbH8mNI72PoRiiX5/qgJmZphfJu2ex78rUtuKINZNiX6J96R1x6eUjxBCOTJoCQgDW+HZe5R35fzYwqAnVwfEtDX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3540.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(376002)(39860400002)(396003)(136003)(83380400001)(4326008)(110136005)(478600001)(2906002)(66556008)(66946007)(66476007)(8936002)(31686004)(16576012)(316002)(8676002)(6666004)(36756003)(6636002)(31696002)(53546011)(26005)(2616005)(186003)(6486002)(5660300002)(956004)(52116002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: /h6Htr4jSmhH33y+e3v5ay5/Uv9NDS0pS6++YySuORJ/3PS82r1GUlRr5vUVgP3sxAeYmMeFBW7rYFAzvwqL3jqPONJ40U5qNZ/RWINpDL3Vspv5mlK1t9PP3mJ0/O/RTSpI1G0DwEzYt4g1hDU+axKGC9nVFWlfMNDw4XwBuB8r15OBPWXTyuHGq06QpEHhuLwsW5dydMlrIFTSeKpYB8KeFfH386hclGmLZxKLlMWYm2JvkUrqi3nXkHnnMB4kEsaYcUM+cYiTfwuHs8i5JA7jonmW/ZZFxOHGjE4UU/6RJ2gKH9n+0xfceuarICHhC7sgO90sLOEIstQbwIhnERN1BfD4I35Cmy/IzAEhJMqGqtupqQtt3dggqayz2Gs2SSTvEFAsclezS1S+BkUN71eH4eRgq00AC6fyFTuNpE3C2vYkdLEFO/mT6TykyaNHBtw6sonAE7TplKItl0E3islIHtx5G2bnZM3OZC16c41V2PoruSJBv/2s5j2xJ2WjAZW16I8hbLKyDXqUkNiJEV6vQVSliF8tWQAhqcf8Qp0fAAZNn1Y924KDgkySejPo0jj2VhSMsf21/81eRrXp3tCwTMQEYcEZGVFpdnUtOrTpLj1UYGRyeFtJPq2SDcMLowkGz4AXbo/iBlDEp3O8ag==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0168afc-36a3-44f0-651e-08d8480131b1
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3540.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2020 07:42:04.2839
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P9OTRGdwyDZeHJUR2NX49S/DSZ+0UfDa3rzzS0/ClvfqBv/NycTerK+iWM6snyssOe7RL2TTDcRc/qbo3BH4Jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0082
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Apologies for my delayed response.

On 7/3/2020 12:48 PM, Vinod Koul wrote:
> [CAUTION: External Email]
> 
> On 16-06-20, 20:11, Sanjay R Mehta wrote:
> 
>> +static int pt_core_execute_cmd(struct ptdma_desc *desc,
>> +                            struct pt_cmd_queue *cmd_q)
>> +{
>> +     __le32 *mp;
>> +     u32 *dp;
>> +     u32 tail;
>> +     int     i;
> 
> no tabs, spaces pls
Sure, will fix in the next version of patch.
> 
>> +     int ret = 0;
> 
> ret is initialized to 0
>> +
>> +     if (desc->dw0.soc) {
>> +             desc->dw0.ioc = 1;
>> +             desc->dw0.soc = 0;
>> +     }
>> +     mutex_lock(&cmd_q->q_mutex);
>> +
>> +     mp = (__le32 *)&cmd_q->qbase[cmd_q->qidx];
>> +     dp = (u32 *)desc;
>> +     for (i = 0; i < 8; i++)
>> +             mp[i] = cpu_to_le32(dp[i]); /* handle endianness */
>> +
>> +     cmd_q->qidx = (cmd_q->qidx + 1) % CMD_Q_LEN;
>> +
>> +     /* The data used by this command must be flushed to memory */
>> +     wmb();
>> +
>> +     /* Write the new tail address back to the queue register */
>> +     tail = lower_32_bits(cmd_q->qdma_tail + cmd_q->qidx * Q_DESC_SIZE);
>> +     iowrite32(tail, cmd_q->reg_tail_lo);
>> +
>> +     /* Turn the queue back on using our cached control register */
>> +     pt_start_queue(cmd_q);
>> +     mutex_unlock(&cmd_q->q_mutex);
>> +
>> +     return ret;
> 
> and returned here!, why not return 0, or even do void return here
> 
Sure, will fix in the next version of patch.

>> +int pt_core_perform_passthru(struct pt_cmd_queue *cmd_q,
>> +                          struct pt_passthru_engine *pt_engine)
>> +{
>> +     struct ptdma_desc desc;
>> +
>> +     cmd_q->cmd_error = 0;
>> +
>> +     memset(&desc, 0, Q_DESC_SIZE);
> 
> why not sizeof(desc) insteadof Q_DESC_SIZE, this makes code harder to
> look to check what this is defined to
> 
Sure, will fix in the next version of patch.
>> +int pt_core_init(struct pt_device *pt)
>> +{
>> +     struct device *dev = pt->dev;
>> +     struct pt_cmd_queue *cmd_q = &pt->cmd_q;
>> +     struct dma_pool *dma_pool;
>> +     char dma_pool_name[MAX_DMAPOOL_NAME_LEN];
>> +     int ret;
>> +     u32 dma_addr_lo, dma_addr_hi;
> 
> reverse christmas tree please
> 
Sure, will fix in the next version of patch.
>> +
>> +     /* Allocate a dma pool for the queue */
>> +     snprintf(dma_pool_name, sizeof(dma_pool_name), "%s_q", pt->name);
>> +
>> +     dma_pool = dma_pool_create(dma_pool_name, dev,
>> +                                PT_DMAPOOL_MAX_SIZE,
>> +                                PT_DMAPOOL_ALIGN, 0);
>> +     if (!dma_pool) {
>> +             dev_err(dev, "unable to allocate dma pool\n");
>> +             ret = -ENOMEM;
>> +             return ret;
>> +     }
>> +
>> +     /* ptdma core initialisation */
>> +     iowrite32(CMD_CONFIG_VHB_EN, pt->io_regs + CMD_CONFIG_OFFSET);
>> +     iowrite32(CMD_QUEUE_PRIO, pt->io_regs + CMD_QUEUE_PRIO_OFFSET);
>> +     iowrite32(CMD_TIMEOUT_DISABLE, pt->io_regs + CMD_TIMEOUT_OFFSET);
>> +     iowrite32(CMD_CLK_GATE_CONFIG, pt->io_regs + CMD_CLK_GATE_CTL_OFFSET);
>> +     iowrite32(CMD_CONFIG_REQID, pt->io_regs + CMD_REQID_CONFIG_OFFSET);
>> +
>> +     cmd_q->pt = pt;
>> +     cmd_q->dma_pool = dma_pool;
>> +     mutex_init(&cmd_q->q_mutex);
>> +
>> +     /* Page alignment satisfies our needs for N <= 128 */
>> +     cmd_q->qsize = Q_SIZE(Q_DESC_SIZE);
>> +     cmd_q->qbase = dma_alloc_coherent(dev, cmd_q->qsize,
>> +                                       &cmd_q->qbase_dma,
>> +                                        GFP_KERNEL);
> 
> last line seems misaligned, please run checkpatch with --strict options
> to find these.
> 
Sure, will fix in the next version of patch.
>> +     if (!cmd_q->qbase) {
>> +             dev_err(dev, "unable to allocate command queue\n");
>> +             ret = -ENOMEM;
>> +             goto e_dma_alloc;
>> +     }
>> +
>> +     cmd_q->qidx = 0;
>> +
>> +     /* Preset some register values */
>> +     cmd_q->reg_control = pt->io_regs + CMD_Q_STATUS_INCR;
>> +     pt_init_cmdq_regs(cmd_q);
>> +
>> +     dev_dbg(dev, "queue available\n");
> 
> debug artifacts, pls remove this and others
> 
Sure, will fix in the next version of patch.
>> +static int pt_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>> +{
>> +     struct pt_device *pt;
>> +     struct pt_msix *pt_msix;
>> +     struct device *dev = &pdev->dev;
>> +     void __iomem * const *iomap_table;
>> +     int bar_mask;
>> +     int ret = -ENOMEM;
>> +
>> +     pt = pt_alloc_struct(dev);
>> +     if (!pt)
>> +             goto e_err;
>> +
>> +     pt_msix = devm_kzalloc(dev, sizeof(*pt_msix), GFP_KERNEL);
>> +     if (!pt_msix)
>> +             goto e_err;
>> +
>> +     pt->pt_msix = pt_msix;
>> +     pt->dev_vdata = (struct pt_dev_vdata *)id->driver_data;
>> +     if (!pt->dev_vdata) {
>> +             ret = -ENODEV;
>> +             dev_err(dev, "missing driver data\n");
>> +             goto e_err;
>> +     }
>> +
>> +     ret = pcim_enable_device(pdev);
>> +     if (ret) {
>> +             dev_err(dev, "pcim_enable_device failed (%d)\n", ret);
>> +             goto e_err;
>> +     }
>> +
>> +     bar_mask = pci_select_bars(pdev, IORESOURCE_MEM);
>> +     ret = pcim_iomap_regions(pdev, bar_mask, "ptdma");
>> +     if (ret) {
>> +             dev_err(dev, "pcim_iomap_regions failed (%d)\n", ret);
>> +             goto e_err;
>> +     }
>> +
>> +     iomap_table = pcim_iomap_table(pdev);
>> +     if (!iomap_table) {
>> +             dev_err(dev, "pcim_iomap_table failed\n");
>> +             ret = -ENOMEM;
>> +             goto e_err;
>> +     }
>> +
>> +     pt->io_regs = iomap_table[pt->dev_vdata->bar];
>> +     if (!pt->io_regs) {
>> +             dev_err(dev, "ioremap failed\n");
>> +             ret = -ENOMEM;
>> +             goto e_err;
>> +     }
>> +
>> +     ret = pt_get_irqs(pt);
>> +     if (ret)
>> +             goto e_err;
>> +
>> +     pci_set_master(pdev);
>> +
>> +     ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(48));
>> +     if (ret) {
>> +             ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
>> +             if (ret) {
>> +                     dev_err(dev, "dma_set_mask_and_coherent failed (%d)\n",
>> +                             ret);
>> +                     goto e_err;
>> +             }
>> +     }
>> +
>> +     dev_set_drvdata(dev, pt);
>> +
>> +     if (pt->dev_vdata)
>> +             ret = pt_core_init(pt);
>> +
>> +     if (ret) {
>> +             dev_notice(dev, "PTDMA initialization failed\n");
>> +             goto e_err;
>> +     }
>> +
>> +     dev_notice(dev, "PTDMA enabled\n");
> 
> dev_dbg?
> 
Sure, will fix in the next version of patch.
>> +
>> +     return 0;
>> +
>> +e_err:
>> +     dev_notice(dev, "initialization failed\n");
> 
> dev_err? Also no rollback?
> 
Sure, will fix in the next version of patch.
>> +     return ret;
>> +}
>> +
>> +static void pt_pci_remove(struct pci_dev *pdev)
>> +{
>> +     struct device *dev = &pdev->dev;
>> +     struct pt_device *pt = dev_get_drvdata(dev);
>> +
>> +     if (!pt)
>> +             return;
>> +
>> +     if (pt->dev_vdata)
>> +             pt_core_destroy(pt);
>> +
>> +     pt_free_irqs(pt);
>> +}
>> +
>> +static const struct pt_dev_vdata dev_vdata[] = {
>> +     {
>> +             .bar = 2,
> 
> Is this PCI bars?
> 
Yes, this is PCI bar.

>> +             .version = PT_VERSION(5, 0),
> 
> Hw doesn't tell that?
> 
Reading version from hardware was removed in the last version of patch as it was not being used in the code.
Since version check is not in use now, will remove this.
> --
> ~Vinod
> 
