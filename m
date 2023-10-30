Return-Path: <dmaengine+bounces-9-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D304D7DBD15
	for <lists+dmaengine@lfdr.de>; Mon, 30 Oct 2023 16:58:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BD432814F5
	for <lists+dmaengine@lfdr.de>; Mon, 30 Oct 2023 15:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1776918C09;
	Mon, 30 Oct 2023 15:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KBMnn5mu"
X-Original-To: dmaengine@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04A218C08
	for <dmaengine@vger.kernel.org>; Mon, 30 Oct 2023 15:58:31 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8123AC5;
	Mon, 30 Oct 2023 08:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698681511; x=1730217511;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5N/vhM+ZygCmGCFUK6LDimH28dftQq6FBMFjZKf+GYw=;
  b=KBMnn5mutxwbB65l6YA4Vmam9v7TjmtRkV7a1msurgGuHYeaP4L4I7Mb
   kPcr4Fqq5LiMMTea/vDS5XlJpPuOaig0voV2ABSdmHDCcu6cZ6qoiOk8u
   TM1DMOwdg8AHF5Q2gqXUvLy05d4wiYA3JfO5Ekb5yOanfDthQlrfiAVOF
   BMQpHPWkfgKHmVjDs++tADtZTe4sbCAShsSl2ZS9I2x3HayPgKK1wT/tw
   mBNlqDqEnhj8c3xpT9ZLgl6UzJBENORYYYSmCUJ4tI9Dji//72udQ6mX4
   poBOgv5g0RJPqrIzGwmTPu1HXjbacx2hWcVEL33LEBkCp0fVOYW/aoQ5u
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="974437"
X-IronPort-AV: E=Sophos;i="6.03,263,1694761200"; 
   d="scan'208";a="974437"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2023 08:58:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="710134542"
X-IronPort-AV: E=Sophos;i="6.03,263,1694761200"; 
   d="scan'208";a="710134542"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Oct 2023 08:58:30 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 30 Oct 2023 08:58:29 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 30 Oct 2023 08:58:28 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 30 Oct 2023 08:58:28 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 30 Oct 2023 08:58:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jl+oXMOna563Qmjs2RhJStMyDVdUm0rN9PdvOtzb5wfJDCPGZe1LdJclVBQ7+9B79gZ3V3NZB+hGPKXJIrWU6kKziISiqsddZGPZx8sYj6o4eAEONFM+4u0IwuAEgTJ5xTKFKnNeAicUOPOYwAuMEhmmmusbuL+w/dp7L7EdYTV3mwOaC0kkfWVgmXSGvXPWMjn1ndi/E9Exmadn7Iyv73tXYHFfNYaXe4J5J55RXVpZrMpEeNOv3yWA5BllkjMb+Cz63ifP+jJBiK0rs3f1j9jwenrDjqOuFvbrMNk4lZHfsp9u3KR1TmbOMevEv4jZ/Eo3wP1cPWAR0hw9WAb9cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F4Pu1tojtlPPMIP7XQ68JierBw0TPfpc1obSr7jdnyE=;
 b=LUkLMYY5SZfEJOYxyMtwGnDioH6EarlqDk035CkHlPtatzFWHW6byrvgVlCXujHfjazVyk7qFlvO7zs7kc3skfpgg8Ua4eem4VwQ2ZMQMQ5SHj4zMO2as+97WGz/E31U8sGUsbrnaVrKq3RZsGNRfwJVL2M4o4yq18+dAralapjVHt3IMqJq0r0YuWJmNMSRKwHUOaHaXmDgsyXQo0EsatFRxUxS1vmt1D1JbwQcEhHnXcq2eMd4kUVbS038kmM7uPFYol3obMcyqU928I4h1eRMr7hPtSsa9oxiZZBl7wtX1DJprvFlfSQqmTHtF8JpGAb3pogIwKSh4uTzBDcCEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by CY8PR11MB6938.namprd11.prod.outlook.com (2603:10b6:930:5a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.28; Mon, 30 Oct
 2023 15:58:27 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::a353:a16f:7f8a:86aa]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::a353:a16f:7f8a:86aa%6]) with mapi id 15.20.6933.024; Mon, 30 Oct 2023
 15:58:26 +0000
Message-ID: <f5562bd4-b278-4070-af79-3dc4a2ef6fc9@intel.com>
Date: Mon, 30 Oct 2023 08:58:21 -0700
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH v1 1/2] dmaengine: idxd: Protect int_handle field in hw
 descriptor
To: 'Guanjun' <guanjun@linux.alibaba.com>, <dmaengine@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <vkoul@kernel.org>, <tony.luck@intel.com>,
	<fenghua.yu@intel.com>
CC: <jing.lin@intel.com>, <ashok.raj@intel.com>, <sanjay.k.kumar@intel.com>,
	<megha.dey@intel.com>, <jacob.jun.pan@intel.com>, <yi.l.liu@intel.com>,
	<tglx@linutronix.de>
References: <20231029080049.1482701-1-guanjun@linux.alibaba.com>
 <20231029080049.1482701-2-guanjun@linux.alibaba.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20231029080049.1482701-2-guanjun@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0007.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::12) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|CY8PR11MB6938:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a144196-d1f9-4363-6163-08dbd9610d60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ctaAC9L+UNmrCCGJWRUmojWfPhY2XhQcVYyqELw8FgcqdxvauuwbyEFqL91yg8nK0bEl7Qnrh07UbMvjCNEGkmtsnKzu/hklroM0kSxDnE+C+QV4Zj5LTmVvtLCgur/E3Y4TeXBcRZU2us51revG1FUKSMprLcvYC4+l5vUVCNnLoIPMkBUnnAvXGPgOociMVJjkM/Zh0Eb4tlR9p6Q1PHu4ssRThbP7KA15Ty6bRNunRoKf5EQyf9bJFm1HNe/Ita2ELX3PT5viZ+CDmrX8n5mEEpV7XwqwghmDr8Vj9/DaAQPBi0f+CsygsXStjDkK9Cqa9uxkkrceiPPyEIeXSxWvclVkiZ/BL+QQdRRN5ypqLLcEXkW7eBODmW1gYgWJkZ49w5Fp3B4ktMW8EpOogpej5yPM46qnm1hYf6ec3ZKepBsDga3RPT8DDpQEYsRmrGwPpaxp3nZqUoqb8/B9u2t5I7MKoSoQ2tuSHtOTRpzvC5BqKwHw+RAy15Ba8QZrCj+504dvb02nF/722ITVZWSaf/kc9QDVuty8sOCa8Y8EMwSa808L6RH0sKhtEtMf9nIlCNxY+jlT6Qx3frm6ya3Y3L7yeQs7cWNHbpMoSce4Dqyz5NKaY2APQiUhaahu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(376002)(396003)(39860400002)(346002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(6512007)(6666004)(6506007)(38100700002)(31686004)(478600001)(6486002)(36756003)(26005)(66946007)(2616005)(82960400001)(83380400001)(53546011)(66556008)(66476007)(6636002)(316002)(8936002)(8676002)(4326008)(5660300002)(31696002)(86362001)(2906002)(41300700001)(44832011)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WkIyaEQ1eXdBYmVPWHpPbFhqbmc4dE1HNEhBaytYemsyMEpWNjJ2RnQ2NG9D?=
 =?utf-8?B?Z044cjhJMmZtcnl5Y1dyWVljV2FLT0F2Y2hJUVdsRThQV2ZMa1oyNHB5Zm5x?=
 =?utf-8?B?UHN1cUd1N1pzKzhzWVBqQkZnclRML0Vmc2VRb1htVzlkOWtzbUZlZlY1NVVr?=
 =?utf-8?B?azdvRjQyU1NZbWI2K2EzLzhyWkUvOW84SjNrTUswTTk5czR0WnZJeG9qY3FL?=
 =?utf-8?B?MU44ZDc3RjN0S3QzT2x5S0Zxc1RKT2tQU0Q1RXRqeXZxUElmZjUyUXY2R0p2?=
 =?utf-8?B?a0hSamtoWldQQm5LN1U1aWJQVFpFUHgwQnltcVlSOE1TRDlYYlB4bFRaZEYv?=
 =?utf-8?B?V0p5VDV5Z092SFJneVR1bkRpcHhxeFFzc0VSV2IvUXlEeWFsaVA2V1NUNmR4?=
 =?utf-8?B?S3ZBRWhLOWtyWXhDYWZQYUtHek9PelY0QTNwRWFzb1dHVzROaHZEekM2Vk52?=
 =?utf-8?B?U0lTZzAyTWNKWk94NlA4bHFYWURWZHlZNHVRMkxGcVZWOGZobXdsbmd6RmU4?=
 =?utf-8?B?Y0JycHlob1VzbGxKdEQwVU9JM1BGNi9sdERVbGw1S2VjYi9ZdmtIYlZYTE8x?=
 =?utf-8?B?K2FQSEtOTHRDWkVsOFdpWVF4R0hIaUk2Y0x2dHUzSTFNcVp5SUtNRXB4T2s2?=
 =?utf-8?B?NjZlZWVSL1RNdzVNaUVrSEIzcnJ4VDV4RTNrQTR5Y0tJMjRDZVFkWnlnZkdE?=
 =?utf-8?B?SnVXaTdwYW9RM09jcUR2amt3Sndkb0YvcWVzOVFEUHRKLzl1L2NqRjNXSHVR?=
 =?utf-8?B?YlFuTE82UTdEME80YTdvZWN5MmpEZGpURXduYzZlY2pxamJsR0ZBS3FRTVRh?=
 =?utf-8?B?UVBHdndvZTAxMTl4M1NhQVU0TlUrRmpmZHJPTzNLa1NxbTFPb1JjSmM2b1NI?=
 =?utf-8?B?QVE2blk3bDFEdmRKQm5QUmtySTRDU2NjeG1tUVpHWGpyWnZndnd0Nytnb0xO?=
 =?utf-8?B?cVZvOEQxUmlPVS9wYldkT0haSjk0NHR4TUZQRWdLK1ZUcEZtNWZBTUJjbURp?=
 =?utf-8?B?ejlMbE9CeXFPODF6c1BRRUNLc3R1RWZoTVM2VHhram5jUFYxT3ozSzBiTWww?=
 =?utf-8?B?eDU4M3JHY1lianMwZWhNN2pad21RTDFENG8weFJGcnhndTdlZmZaSzNSQWZL?=
 =?utf-8?B?NzYvRFJIT1YxNVJLT21jNzlYb2JQaDNla0liRTRpTDNUZlhZV1ZpWXVTYUpy?=
 =?utf-8?B?b1FsWDA5am9qRk42NG1YTEZCamQ1czZkS3NCeHB1K1QyQjN4LzhPOTVvZVN2?=
 =?utf-8?B?WEhtck1yVUxBZ0ZvUXRQWVVEUUJOR1ViOG5oV3NYK1FHdzhlSGpPTkUzdXJJ?=
 =?utf-8?B?RGJJSEF6ZGJQT2ttWFJNeFhBQjlpY0FXTVRpQkpMLzJ6VVIwWG9IMmRnSTk4?=
 =?utf-8?B?dzhTZ201WTlTNXZxbllsTzVGTU05NUJBaXNLWG5KWk9SMUg5S0llQ2VKRURW?=
 =?utf-8?B?V1RlalZiZ1pOZmVPN0V0K3lWcERPcktUdkcxQ0UyVFl5cG1DZlhsU3FJVmlI?=
 =?utf-8?B?NnBxbFc2cnJMVWNsMFZiRSs1VFhxeGQ0WjFLcmZaK1JXYU81ZExNZVdjQVJC?=
 =?utf-8?B?MTdPY05EVzY5cHBlNm1ybXdkamg3OU9QRnlPZ1RLcDZkZFM3TWpUR2lCZkRr?=
 =?utf-8?B?MU54ZVZHZ056enJqMVphN1ZON1QrQWtaR0wzSURPbVFHcGc0R2QzR2djWEdm?=
 =?utf-8?B?VHFkeDFodUd0RTh0MTlHSzJYTFZqL2gvUHVGTk5yRXUwUnJZMlBsMTJybFky?=
 =?utf-8?B?bkd4ZUk0QVM1TkJQSFJjb09WcHBOZkZTVUVsV3lacGtEQXcyb1dwanJTekVL?=
 =?utf-8?B?S0Y4VTRHSllEd0NJemhkY2VaNUtQL2luOFhHdjl6UXYrRDRKeEFSRkd6S2hK?=
 =?utf-8?B?TzVIb1pyOGJlSTZqamlqYzdlT3J4Sy9ZaHdNVmVQeU9MM2piRUk1MDBTdlU4?=
 =?utf-8?B?MVJLdmVEUzNRdm1vV05ORm1QTkRRemdyZDU3b0ZXNDcxS1llUkt3dU5VazZu?=
 =?utf-8?B?dDJQM1R3dFh5WThpbFI5M0gvdVp6VzZ0L04wSUpDbC9iaG5lVmxMRGp0UmZO?=
 =?utf-8?B?TzVPd2dYbCt4dE5NclNiVVlFUjJXaFFaZFQzUnh5dzlMZzhuSHRvSmVMNk1F?=
 =?utf-8?Q?oJ1Eitusium36tMsbRR+LpdDo?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a144196-d1f9-4363-6163-08dbd9610d60
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2023 15:58:26.6176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DW7R76e0d3tm5oFVIdIuEzrbGskmL7RF+RXGO8WfXpOKPcsEnj+u0OTGGXQIhl3+08Iim9fGjco8i0igW44OWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6938
X-OriginatorOrg: intel.com



On 10/29/23 01:00, 'Guanjun' wrote:
> From: Guanjun <guanjun@linux.alibaba.com>
> 
> The int_handle field in hw descriptor should also be protected
> by wmb() before possibly triggering a DMA read.
> 
> Signed-off-by: Guanjun <guanjun@linux.alibaba.com>

Can you please provide a Fix tag? Otherwise
Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/dma/idxd/submit.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/dma/idxd/submit.c b/drivers/dma/idxd/submit.c
> index c01db23e3333..3f922518e3a5 100644
> --- a/drivers/dma/idxd/submit.c
> +++ b/drivers/dma/idxd/submit.c
> @@ -182,13 +182,6 @@ int idxd_submit_desc(struct idxd_wq *wq, struct idxd_desc *desc)
>  
>  	portal = idxd_wq_portal_addr(wq);
>  
> -	/*
> -	 * The wmb() flushes writes to coherent DMA data before
> -	 * possibly triggering a DMA read. The wmb() is necessary
> -	 * even on UP because the recipient is a device.
> -	 */
> -	wmb();
> -
>  	/*
>  	 * Pending the descriptor to the lockless list for the irq_entry
>  	 * that we designated the descriptor to.
> @@ -199,6 +192,13 @@ int idxd_submit_desc(struct idxd_wq *wq, struct idxd_desc *desc)
>  		llist_add(&desc->llnode, &ie->pending_llist);
>  	}
>  
> +	/*
> +	 * The wmb() flushes writes to coherent DMA data before
> +	 * possibly triggering a DMA read. The wmb() is necessary
> +	 * even on UP because the recipient is a device.
> +	 */
> +	wmb();
> +
>  	if (wq_dedicated(wq)) {
>  		iosubmit_cmds512(portal, desc->hw, 1);
>  	} else {

