Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4BA6DA916
	for <lists+dmaengine@lfdr.de>; Fri,  7 Apr 2023 08:49:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231962AbjDGGtV (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 7 Apr 2023 02:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjDGGtT (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 7 Apr 2023 02:49:19 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 198C36E94;
        Thu,  6 Apr 2023 23:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680850158; x=1712386158;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=3y9ox1+cNu3yU5CoEFzrupz4jc+/2jNbyZ56myzGb+g=;
  b=fsoxOg0oZacX4pHBJusFQ20ZxYvJbgeLe2hG1gR+5eaIT4iaK3ol+kxZ
   voyVvjEV66k++nZ8ik942X0o8g/+KQOv169NDwLCl33c2fn62SQeiPjzx
   8+Q5/60DJffo6ceFYW6iW3846QM/TbV4pvlGYTbbGICOZSpN9ERtrSG/U
   vKggnjAeZI6cSHE3q+g0YmLqNhPDiOPFVwFGb0yD8iz/K2N8XIaGES36x
   KZ1t12Q2v+CU2v51uE17xwo5OPCHU6MDWClrAXefyS6EgKVXJyWU2OY5O
   M1vPfdds6X6YIbtZMAvm2D3Pki9e6MqujsXSkbXaPXi72hWmFqb/BNvHa
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10672"; a="341689292"
X-IronPort-AV: E=Sophos;i="5.98,326,1673942400"; 
   d="scan'208";a="341689292"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2023 23:49:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10672"; a="756628457"
X-IronPort-AV: E=Sophos;i="5.98,326,1673942400"; 
   d="scan'208";a="756628457"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga004.fm.intel.com with ESMTP; 06 Apr 2023 23:49:17 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 6 Apr 2023 23:49:17 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 6 Apr 2023 23:49:17 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 6 Apr 2023 23:49:17 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.172)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Thu, 6 Apr 2023 23:49:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cb+jdqsCdSUJGN47xCc3Xo/8ydfNsespLGHsUdeQXtzHF1tuwFhuITyz7AmsFMHbnxmldDv1LIsM8rl1pJhvI1bGnZyTVvmSYZchqBOSpD4rMDCIFP1p804MYyZ6uakV6WptUeoRf++yAMgpsOSxg4EoCy5ZeP+GdtjJMgoZRBQeko0WkGuwNQ+f8hkLO8sVgVNcIm5wt1zaCyNLaTN6DwHN1beaYUE+UtwiUjO0S3lDbCXH63tQO6B0UwWF1wxyUng9tkuBHqd2JcVaarDQ471ZDLgbnzsC80HwjjOe55PUHeS/MX9A/HBBWRAEj/C/2dytTVRETMLCe7hHfw9lNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZV7dcOtmgiYxQr9Cb7N8SesNsLaxO0EmwR4D+zrUYeM=;
 b=DvA0ZezE1pwTTiRX+iQ3BUiFtX6FM5bBymkIus3Rjpg9NqFJUDZ+tjIesEMnc32Rgp3uLCIbjynzjMUb1clo9Ms88gAuhvivEwpdd+WXJeflQtr/IeRkRQa4b39AWPi87irG1HMRTj1EPUl307y4V8Sjj8H8/dnveGg+QWd00leqOcgKLjy2lOgxxX9QUOL6+oofvB8z8FA5o0vaxmwqkCVAtofRzFELwbKrayMVaSmdswFAA1mo2lwOgxSwfRyPi/BX7lf734202Px683/392vjeynt+fvdhOojaWAiSiznC5bT1pIRGUPrYyXtX493Ly2KnUGpEDrk6d+ZoQEIoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by CY8PR11MB6938.namprd11.prod.outlook.com (2603:10b6:930:5a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.30; Fri, 7 Apr
 2023 06:49:10 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::9bf2:9ab9:c6e0:1b2f]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::9bf2:9ab9:c6e0:1b2f%3]) with mapi id 15.20.6254.035; Fri, 7 Apr 2023
 06:49:10 +0000
Date:   Fri, 7 Apr 2023 14:48:56 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Libing Lei <libing.lei@jaguarmicro.com>
CC:     <Eugeniy.Paltsev@synopsys.com>, <vkoul@kernel.org>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V3] dmaengine: dw-axi-dmac: add spinlock for
 multi-channel DMA
Message-ID: <ZC+82NwoumBLYnml@chenyu5-mobl1>
References: <20230404153945.916-1-libing.lei@jaguarmicro.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230404153945.916-1-libing.lei@jaguarmicro.com>
X-ClientProxiedBy: SG2PR02CA0129.apcprd02.prod.outlook.com
 (2603:1096:4:188::19) To MN0PR11MB6206.namprd11.prod.outlook.com
 (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|CY8PR11MB6938:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f01ca43-a595-499f-425f-08db37343082
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v8c3+gsjXQks/hDbqydGdM1AargO6qI+hEkDVAcadnDlL5Ownnxx5GHolYPiB8g5Wcjl9CgfvPOBpVa0tFNoN+6wwmaQloKDp2PIEnErpnLuF1+llTm9RAGv1lyfNvk5524Vz0NjUutVdIrIGBT9AyYcMLp5dKd/BkoHZ0UDfzPEDc2+uBZ39r/1/AHTY76/3Yx24YL8oKwR6CDCXMXhtJI1nRoWCP+/DXWpcXx+LbFq4N5T0aoQrwe3AzmytPjVZQN7qGkUyKsO2KgXWGsrnRTViD/5QPSHaPA6ROkXVOCogZia+TkJffi2pgm1L9gHnFVuTr2NOKOujvaeoDHlq8qAJqcDU5L3D2kDDVTwGV4nqupd2nnQenSFFNxq57xXyEafMrCpYLEO5jQH1JIkIbqcgcXprVF90zf2ePa9zuEIlGeRZkOAacBxrio56P+/5RhwZl8K2V0yvr5OK6oFstjPMEwLJrTVnP2JoJ0Mhai3gZMcgIAjTrAFgYHhaQTtyZgezoq+IlTZ3rgXhBjujzAxNOp+4++8/4L3Vj9ZoUUhPY1xhbPy/okX0wk72IYI/DB6TTgODYn99muGwyCfuucjICxH4wvWiDLldPtWjcI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(346002)(376002)(366004)(39860400002)(136003)(396003)(451199021)(478600001)(6916009)(66476007)(66946007)(316002)(66556008)(4326008)(38100700002)(8936002)(41300700001)(8676002)(5660300002)(82960400001)(186003)(53546011)(6486002)(6512007)(83380400001)(26005)(9686003)(6506007)(6666004)(33716001)(2906002)(86362001)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2777uTal1KQ9wLsuuTOFybfRIYDGZjpS5Pvnm2eyasmApvxkhrqg4E2SCIUP?=
 =?us-ascii?Q?XtcKe1fjyOlJnBteiqo1fpg29dJMoZdh9O0aDiIDzwsq+DXLmIae5iosCVPa?=
 =?us-ascii?Q?oM/X9QK3emCCN2muPbPFdHFCtJOOYB6dIjdXo8W81oP1GfesIaYwPAQFzoqw?=
 =?us-ascii?Q?MpdcbRBfQ5bC94HqLXDmXr/6lWyn5o+k7Dh1A0EUco8yYG7ntLMpJUmF0QV6?=
 =?us-ascii?Q?eiPgSjC5gNnr463HoOL+Oew3Ed+CkfDVFkN2HyZ4VNpekRb218o27Uy1bwwO?=
 =?us-ascii?Q?9oRhkRguJrZQIQ/H9EWLojSfBH9btDF6GSvYMKML1pjImIstoKUc/O3Q+m61?=
 =?us-ascii?Q?mqcz9cfPkS8LZUneaA43tS5tTX7u1cClCotBVkgY0L1FNw8mKi3KPKBh9q87?=
 =?us-ascii?Q?FaUni9KGvHumVEVR/RUp3ZAtPIm7JxAMZAkFPB0ukV3zyniT/kCAh+51OZLM?=
 =?us-ascii?Q?CR/DMp5V4oL9dU2khzX58igGbhHEX8PR29qL8H8Y6xq2aBXlnU+365Iw0A7r?=
 =?us-ascii?Q?7Ry0efQWJTte4eDxbqHkDiUmsxzMgOJDBsWN+jjPbbSZkxXcsLjoB59LSvXk?=
 =?us-ascii?Q?+gFbhx4w8GAcA7smVRjwUUjqrdaendlMv6a/Mw+qH8+0ZReHZiLWeZiY/GtV?=
 =?us-ascii?Q?NcPaqp4xRqP3KVsDG7z1OymgS1HEDOnaXJhGAHeeeTBBAsQQEMr6pk9yvxBD?=
 =?us-ascii?Q?7Ukjpl7VZRkL/GbH1DJQDmuiGPv0s0JWvYapf6ZcTtFxTzWpjmFB5BbRI4hp?=
 =?us-ascii?Q?sR1+DHIPKwtvQrxZnEV9AOH2PJDjM3E/XUty4saaaaLLM3EvRmS3ihq56VfH?=
 =?us-ascii?Q?yfTQhj6xLenkmv8Zh1n8Lk0uKFo296W2b0kQdA1jT8E8gELZ7/UX+CiQVcM6?=
 =?us-ascii?Q?wNUNze94f7WiQsrMIfaC0HtZGyBbZjg6bsbpCxy/gKVj25aUyujinK9IVaaG?=
 =?us-ascii?Q?N1XuthVEDrKFvom08CSfbsvIFWw8Tgq7gk9JdbUydHq9Zh5luk/S8HWcb1e9?=
 =?us-ascii?Q?IPEtl4TgB9cF33MTzAZDopFWdiYXTdPQMrAh/xywIbwMJdC4PSbZ+ae1XDVs?=
 =?us-ascii?Q?Y8YnFENyTM+67MU2CZgHTkNMaiqNYJh3flyr9d1iKiFfHqVEYcAGdPLYO5/5?=
 =?us-ascii?Q?n+UiorM5gLnw2Sx9OuW6K6WXqw5/P9ms2dhylrN4PShFDU7LEuqdiFI9dkMa?=
 =?us-ascii?Q?SzPovSPRtOfeCWAwOI9nX11+w0WzJp5qimg9GpwlEBGmT/go8DBv9qAGxz6m?=
 =?us-ascii?Q?A3LoTmTwyRsinj+qg9TYUBKnoQvnI+KMtC1jeocY5q6H3NaSQ6EvLw2vkaC2?=
 =?us-ascii?Q?JvLuZU2TpYus72t4KFnT2WTGYfJIyZK9uxKeuPQHN5JR3xvQXlArP76WRPQw?=
 =?us-ascii?Q?M818zW1mVVW9NRUycShf95QqPf7zkg0euMeF/NbTleXSG8gWLpAX5bk304lD?=
 =?us-ascii?Q?3l4Cx2gTVRxnVq0UIj2EdxkN0NpIIlDw2rST1UpbRoyq58Gcvwa39IyS5L9w?=
 =?us-ascii?Q?cFvpvxSVfnvMUjrs40TVQ/AZZeW5R/9tMo6t9EIePqvBEELj9NtGLqnocxlK?=
 =?us-ascii?Q?mQbyEhJyjvxZ7/u06z1utBKeV9lrKYaFU5kGB1o2?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f01ca43-a595-499f-425f-08db37343082
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2023 06:49:09.6793
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /shSGRhFiAdtn0nVu0yg9X2ONdCN6yJkiOsVkO9SqzUKuZlr99pHTqUYgQU0MxIs2jksql12NKSS6+TXbTgJvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6938
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 2023-04-04 at 23:39:45 +0800, Libing Lei wrote:
> When multiple channels operate simultaneously, the common register shared
> by all channels could be set to an unexpected value due to race conditions
Does the channel mean the "chip" in the following patch? I mean, each channel
has 1 chip plugged in? I asked this question because I'm trying to figure out
the protection scope of the introduced spinlock.
> on SMP machines, resulting in a disaster that DMAC cannot work from then
> on:
> 
> cpu0                            cpu1
>  dw_axi_dma_interrupt()
>   axi_dma_irq_disable(chip)
>   ...
>                                 axi_chan_block_xfer_start()
>                                  axi_dma_enable()
>                                   val = axi_dma_ioread32(chip, DMAC_CFG)
>   axi_dma_irq_enable(chip)
>                                   axi_dma_iowrite32(chip, DMAC_CFG, val)
> 
> As a result, the global interrupt enable bit INT_EN in the DMAC_CFG
> register is eventually cleared and the DMAC will no longer generates
> interrupts.
> 
> The error scenario is as follows:
> 
> [ 63.483688] dmatest: dma0chan1-copy: result #18: 'test timed out' with
> src_off=0xc2 dst_off=0x27b len=0x3a54 (0)
> [ 63.483693] dmatest: dma0chan2-copy: result #18: 'test timed out' with
> src_off=0x239 dst_off=0xfc9 len=0x213a (0)
> [ 63.483696] dmatest: dma0chan0-copy: result #19: 'test timed out' with
> src_off=0x5d1 dst_off=0x231 len=0x395e (0)
> 
> a spinlock is added to fix it up.
>
Although it is unlikely to introduce ABBA lock, maybe enabling the
CONFIG_LOCKDEP to have a double check on this. 
> Signed-off-by: Libing Lei <libing.lei@jaguarmicro.com>
The patch looks good to me.

thanks,
Chenyu
 
