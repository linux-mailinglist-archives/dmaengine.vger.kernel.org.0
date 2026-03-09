Return-Path: <dmaengine+bounces-9352-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KBwWAB7drmm/JQIAu9opvQ
	(envelope-from <dmaengine+bounces-9352-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 09 Mar 2026 15:45:50 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E03323ACD5
	for <lists+dmaengine@lfdr.de>; Mon, 09 Mar 2026 15:45:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B46C4302294A
	for <lists+dmaengine@lfdr.de>; Mon,  9 Mar 2026 14:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46980346E55;
	Mon,  9 Mar 2026 14:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="nbnXOE5/"
X-Original-To: dmaengine@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013030.outbound.protection.outlook.com [40.107.162.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4002A39A7FF;
	Mon,  9 Mar 2026 14:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773067386; cv=fail; b=FVnu95GMdyie7jmXf6yM8MpfuFsrLFALFp8a/NUNyKQiqXM3BGN+Tnn/clXsYhtKVcHHyGrYr7g/51iR2rxN7Jb9GIvH/MIG/1kx24e/Kt9O6YBhvWyb6ALXBm7YiRUk+FulZ6RHGNJIOQ46Dv1efpyIrqYd8vIkpPoc7L4KsDI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773067386; c=relaxed/simple;
	bh=XYbpFbfmsnRwiKWE+vHOm1ux5YGidMg50oGQHJh63ZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dTNBqVTxt0FlJ28xmPIAPOX8pKAlrgtfUNzvggFZ4vktWnfel1PiBzIIREJPPCAuFUXaQJi+PGtTxlos9oI00s25osLhmHSKgaHvWnqbIc+nPfDMXm5+9wy7b76cwHTObEL//tyF58gfkWxqfa0CL7bjGW7UAQWAVvQXmsymp0I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=nbnXOE5/; arc=fail smtp.client-ip=40.107.162.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tYm5HTL2NuBEYs88TDtzIYw8P7DH3KufdD5BXu/y5ddHW+uA8TGlezwf45h++sN3cCQWS4/xCvw1kt9Q9Uz5RzKWy3jqJHBbD9YhavMUHjAutL1tUoG0WnnuNZdus2ZfjhWlNAHAWJsqxyeXBerQCni30JT341cwMNwBhqIMsd4PYCB91rFg4bWKmC3PBT54Sbyf/MjTLLVN1bUlhfMRYxUuyEvztsmAfjMzH0P0HVib652niyStZGwZuUZtq8C9W6/f9mcGSsJrUEysXRGJKb3KxiMZNogLlXajOodAZ2NslEwbpa+WKLdwcDRXsZmpYLKVj5VA3Yngn5eyMsWDeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KWVo1TJT3MQBKOWl7Pad2WNZ0erW4Q2tJQx83FA9H48=;
 b=tXkJAt9A1yA28uYEVbcATrfh6LhyBccQqbhMhA1cWeFbmXkrO3Rj4Qs/c7KtfnFvhHPu92/exkwyKIotEs+3RUu18iQNxhz0kpdEXhZ68D/vMGWt7wMGj+p9rzLyLBdXospS4Txvt/3FW7bCrxXjVrYnYybSCasDi1y0FXpcHV5k/8Wd3LxoEK4alUFYv1bfPOrkFkXWPp//GAEWd/I4cmJc44Kv/mTWzvTUccnJnuU9dzPomogGid8Cjcl6aUS60YNGmT8IMI6gSV985S7l8a19OWUCbz7KhRY/4MVauk7ky3YzaBgANzuGcstFwzuaTQHlexR4lf+defL6NTRtaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KWVo1TJT3MQBKOWl7Pad2WNZ0erW4Q2tJQx83FA9H48=;
 b=nbnXOE5//q3a92bTity49kCPTAiX5PE7MFoypZNgaILYdeM4jfXourHVpUEI6neQeFXCrot62XJBt1UHc0knV8B/+hvUDi98vnPN4tMVAx8W5M876SicpIXOLldGfpVFpi9+F9O9WqbmWb+vuncGLJHZGziiMr0vZnLFKiOlfu/R4uyvnxMa9Qi4u9hsd1D4tM2uTyBpLLITjGjj51Jfs6PymyTHnK+jdcaCE0956411M7a7BrnFE+3fiGcgSyX2cpCk1jxD1aBqlTBoEj+cHEgyieOjjyUJOXyk8MtiQvsLGV+CO4NH7HFDDhRMTZloOFefZZLdIb52yn2rs2G8Jw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by PAXPR04MB8224.eurprd04.prod.outlook.com (2603:10a6:102:1cb::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Mon, 9 Mar
 2026 14:43:00 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9678.017; Mon, 9 Mar 2026
 14:43:00 +0000
Date: Mon, 9 Mar 2026 10:42:52 -0400
From: Frank Li <Frank.li@nxp.com>
To: Vinod Koul <vkoul@kernel.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Koichiro Den <den@valinux.co.jp>, Niklas Cassel <cassel@kernel.org>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org,
	mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
	linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev
Subject: Re: [PATCH v2 1/8] dmaengine: Add API to combine configuration and
 preparation (sg and single)
Message-ID: <aa7cbL-B5sbjZr_l@lizhi-Precision-Tower-5810>
References: <20251218-dma_prep_config-v2-0-c07079836128@nxp.com>
 <20251218-dma_prep_config-v2-1-c07079836128@nxp.com>
 <aa6pW-zpxnrZnfPn@vaman>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa6pW-zpxnrZnfPn@vaman>
X-ClientProxiedBy: SA1P222CA0198.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c4::22) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|PAXPR04MB8224:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e6767a0-972c-4821-8eff-08de7dea299d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|19092799006|7416014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	V1l9+RLgAt4QNl9Zr7CUsnJca0tKXBRkHdPDxpCVmlz89obACBzBJDYu6wk8pPp7diSOrsQZY1ZcW5dHsdFbLKV6r5XVQ7wjkvR42OHJ0FdhbMc6jzeuqNN9paAFp+7oKNWY9XHhmiJM66K/ODHRZkQmOUY4VVkuP7tOFICJb5Gy6Eog5RKy7tT2UHCFwQUZLvNP4BMStMSuU/mzQYpLKcdCd8MxGjyJ8b5Ja+I8Fg2DgPuJPkeydmdLGAoecLIkXf6QIPu7CNoNqv+d+RIL9jJepXk1HZn0VO7afEjwFO4HBt8YCHZoH0S5gdvDgj2sPUe7Tsx6duaJ5O7JnbckMd4pMh2rRZTYdw5ovCzxEY0H/W5bcYYtLaWYuWUk/OyO1O8bYDgw9HfJ8Xth6Whf8PptC5VJBn1YFnrGS4RqXBALyzfcsOjuSEe1WjtTS3RRDFpsGh+BYEowj74azk8kcfl0u4JmwVMCqy/lxeU0CzEbDxERPGqm3Lr70CNcLF3e99g4+yQFKad8r9XdJ6Cne03MyK72JxTaPd3G1qQ/H01WcOTGaGv6faxQASzK7V4JRJE7WXV12ftGhVxdJ/jEisx+djBh8jn+bXDtRHOrMkvttbCcwgnugrZ2uxHhou3U55q820EpE8qBVj2CFvcuXbgBKpk4LkgaLKKwSQSMPGXVK45abczIrI/JoOUW+nTfBCruwonaT4buE7lb1XVUTf8hsETzbAEmrRpM+FIuoiMfqgMRwGiUwKhBUkCgL6jTo4xEEvKrec35eBINWIENDkeSX7huetH0WPVYQFaOVN8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(19092799006)(7416014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iRqe6L41q7/vDif2IY/UuKhjxPa/xZv6FCNtekgGGxeei007XYHQ9F3u8zFI?=
 =?us-ascii?Q?fzMF37kcttjy8nOYWk4n3OpdzCoIsqxePhBRvjsz33drinQJMMo29H0pLn5T?=
 =?us-ascii?Q?BxrmycaLs4J6BlourMaqY3TTUu7B5bUoHkwQYH3oyDyEExSRGzlkO14x18CZ?=
 =?us-ascii?Q?VR/0nkmZxiR6J+Q9FTAyRxwpEwibqJljG3La7KP1rBxSKNS/tswhurUllHmw?=
 =?us-ascii?Q?UIm4EFHzLvtGxmJ49sbMlk3TZy5YezXeTQ3pBIu041CEtkW8GRmwvwRMt+vN?=
 =?us-ascii?Q?lHAiwABr4lbH8Mf3i1HZOFSSnoHBf+kXdgIECalT0SHkby5BcgpmxhSaPlVK?=
 =?us-ascii?Q?bPQG2ETLd5JMjXImCUaG5WNUSIhD9vstTzrYuLnui1UPtSYHzrIksbIeyUvx?=
 =?us-ascii?Q?VqFXNYnroOXkkTm2GEl7xIo7v8Jut4ByBArEKTES+llRyhUrCXxaCP4IH4r+?=
 =?us-ascii?Q?Xqo3ZvB3SFyQn6W5F9AZFeFl/Q9hqG06uU7gEBqE3fQAgnBM8IRhzDTnZDen?=
 =?us-ascii?Q?VJ+UypV3hz8bJ2BinVDEWnCiwn2vc3zr1I6n+KoJvAeK1tbaI3dsV4O5n4WK?=
 =?us-ascii?Q?Vm2KzUXnIj3BS5KiVZmKCr4NgXQDoGo8M2Hw2dhxb6s/424mNmZHw5PUAoUh?=
 =?us-ascii?Q?m/ARYGSqHohV6anRy0ymAntkXaA9nEVVi1cXZroumC+6TEywpf7n7i0+MpRD?=
 =?us-ascii?Q?n3+3AFFxx8oeKi9d3HTZHHEB7g8Ihn1svwn8IPA631cu7y48sXoJf3MVWwSS?=
 =?us-ascii?Q?kwwCLCU4Hv2WqnHbuRJCUq7Cl0lOG2FNQYK4OwihNbEK7O9WtdvUyLG6O5ay?=
 =?us-ascii?Q?rAyBkTpETb/U/aL8udQuhz1hYRRi0bp5G88N4GdNSRieeQpE2hW1hLMqQf/M?=
 =?us-ascii?Q?YWVQ69c9SUedGhBZwpKcH5xf40jNEjXmoGpUMQt235K3a2KTZ2oRVdOVqIiT?=
 =?us-ascii?Q?lyfVe7QuqHRJkVZlvMzoinCO70237H+Av6B07g7f1tY+IeN7wdcQjicpVrCr?=
 =?us-ascii?Q?hJkXw98oUAWJ9CCrhzhPnQKzRWfMBBGpIAKAKipqZL3V8CW55PpnzZBgGsfm?=
 =?us-ascii?Q?11ljrPs5rwa+j64EBBvrx0f5vljpD42fBGLQO1ZQ1WM62qakJ27D/EgS8sP+?=
 =?us-ascii?Q?9rdyxug/yuzs/Gf8ZH4bp1leRhN9Mn7pVarFmHdAP2vwRbOtqM3t/hg9+qot?=
 =?us-ascii?Q?GtLWg8nPvb2tKZqNWH3H/qmGyJ+LQNthOm8w7oIlz5GV7kEUg3V7jF7rI3Hz?=
 =?us-ascii?Q?L0J2FbB8f7fmPGsFZ+FvlchAZT1FPYQuTNHnDYNFcNhizS8affWoDbuQKKXj?=
 =?us-ascii?Q?SXeQ4I0kEkhRMOHEveoroAuCT/zUDk4yOLvuvNWbBdPH4UVGD3Vj+jrYyd/W?=
 =?us-ascii?Q?XiEVbCTtGlFbYmKNngetnZeSved1uWSiy+AiewGLrcOAEfxo0XXlLYWA2UwW?=
 =?us-ascii?Q?U6vYwcCtQc9eJloGhsRIH4pKgdx131y+yR8I2w7NrtXij7rBgwCmbqVoVH5s?=
 =?us-ascii?Q?nyY+AirguVh4bZP4d+eXOCaIRFH00P+a95KmPfEsDqr396KB/bE2q98pVXwD?=
 =?us-ascii?Q?ricUyWBpn/qih5VgRy3EUnlilyUUpHHZUdayGmAMieop3Nc7UgMR2mqbwErX?=
 =?us-ascii?Q?L+exHN0/V9OVnNy+YSxL4S71rBYfYVRATKFy3l0mEZNq49opt70Dix1Y0TwX?=
 =?us-ascii?Q?OKXUSfjezOAcKIY3alx4MSY+PXexrhtQVqP2F1Xo/5ANyJMr?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e6767a0-972c-4821-8eff-08de7dea299d
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 14:43:00.8722
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HjcwjvZBgxJ0sKInHt1n4heS9jEHl1MPWd51WcjppvW3QtL2H4iXCkGjdfm0rqSns8usOovErA/lT63f5HS0sQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8224
X-Rspamd-Queue-Id: 4E03323ACD5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9352-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[24];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	NEURAL_HAM(-0.00)[-0.949];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nxp.com:dkim]
X-Rspamd-Action: no action

On Mon, Mar 09, 2026 at 12:04:59PM +0100, Vinod Koul wrote:
> On 18-12-25, 10:56, Frank Li wrote:
> > Previously, configuration and preparation required two separate calls. This
> > works well when configuration is done only once during initialization.
> >
> > However, in cases where the burst length or source/destination address must
> > be adjusted for each transfer, calling two functions is verbose and
> > requires additional locking to ensure both steps complete atomically.
> >
> > Add a new API dmaengine_prep_config_single() and dmaengine_prep_config_sg()
> > and callback device_prep_config_sg() that combines configuration and
> > preparation into a single operation. If the configuration argument is
> > passed as NULL, fall back to the existing implementation.
> >
> > Add a new API dmaengine_prep_config_single_safe() and
> > dmaengine_prep_config_sg_safe() for re-entrancy, which require driver
> > implement callback device_prep_config_sg().
>
> Okay to add API
>
> > +	struct dma_async_tx_descriptor *(*device_prep_config_sg)(
> > +		struct dma_chan *chan, struct scatterlist *sgl,
> > +		unsigned int sg_len, enum dma_transfer_direction direction,
> > +		unsigned long flags, struct dma_slave_config *config,
> > +		void *context);
>
> Do we want to have drivers implement one more callback. It does not make
> sense to me. Why not handle this in framework and have it call the
> respective lower level APIs.

To avoid use addtional lock! suppose each API is re-entriable.

thread 1:  call dmaengine_prep_config_sg_safe()
thread 2:  call dmaengine_prep_config_sg_safe()

If DMA engine driver implement device_prep_config_sg, thread 1 and thread 2
can run parallel.

If driver have not implement this callback, it have to use mutex make sure
config and prep atomic.

https://lore.kernel.org/dmaengine/20260109-edma_dymatic-v1-0-9a98c9c98536@nxp.com/
show finial opitimziation result, which depend on this. If can't call
prep() function parallel, which will kill performace.

>
> Drivers should implement simple apis and collectively the functionality
> can come from the framework.
>
> Would you consider revising as such. Bonus all existing drivers can
> start using this API, no change required for drivers in that case'

Not that simple, some devices just call config at probe, especial fix
FIFO address and burst length.

Call config and prep only need for the case, which need adjust src/dst
address, burst length or other parameter for each transfer.

Frank

>
>
> --
> ~Vinod

