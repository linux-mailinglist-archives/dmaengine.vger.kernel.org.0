Return-Path: <dmaengine+bounces-9307-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sNGCKE0Vq2lzZwEAu9opvQ
	(envelope-from <dmaengine+bounces-9307-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 06 Mar 2026 18:56:29 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1141D226801
	for <lists+dmaengine@lfdr.de>; Fri, 06 Mar 2026 18:56:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 78BC0300F5B8
	for <lists+dmaengine@lfdr.de>; Fri,  6 Mar 2026 17:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28FAC1607A4;
	Fri,  6 Mar 2026 17:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="aISSQ2fB"
X-Original-To: dmaengine@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013013.outbound.protection.outlook.com [40.107.159.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1FF32D5C8E
	for <dmaengine@vger.kernel.org>; Fri,  6 Mar 2026 17:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772819786; cv=fail; b=dYWkC9iGUsc1vOb0kAeSnhm+5EOZkNq7dCT1acxY+uYtY8uqICyUjYUn402F4jwo3yrJc/IFWbFq66mp/iWuPJ3dRYwIcErpP9i3gCLBKYK7GvTVAZOYnjw+mRSBOc+3L1GXjR27UcxCO6vLFu+j8rOKgKUfzwa//G8Eoyct6f8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772819786; c=relaxed/simple;
	bh=aIJfc8MpLd1oBMzMbFXNIP2NdE9Sq8dlLtbPEED0CzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KXYHUekdzyeau4QoFZiBKs62ijUBoXG77qrTN0XN2W91UXEMOvPk4X2cioNDtSDEGUtWH0WNkNo0XPfQOuuW1iOX2uWDvlewdDVFjkOFSK4ZDERQ5CAFCWZaEPfyXosju8IBMcMuEv9CuEDiF+QRAtUZwalhmoDavpOyi43eYI4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=aISSQ2fB; arc=fail smtp.client-ip=40.107.159.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yKvkqOxrjKvx9qtDwJAsGyG8swyTTjtDsDjwal4s+n/+qTOR1C77xOOmxAuewa0PCu+avKR3ogzh055te72ikM7A1cJMxGZbpYumrGPRHCIfVmDBFmsN9dn2a5CteVNYu6RA60EfjTSVru0TJacrHZyOdxarzMci/kFjWV/hgcLn4tDSN8SbrdPEaMywjqFL7iDc0UW2ybbLwMWBL03IJORmxR4kDXLh9Egw/D91+heHleAMBep5iAJfDU+RYbKhTftv48RzZcSWZJyY7ci72bJHwbUiz6DtnDDxuwLcUwSI9YGGj7Fkv2JXc9WTQcg0nLJKfUkmWUGrf7iuep0+HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jd9/xZgxOWPU7bTYy2NXrhSlyTUHCxva7QqbUb4nJqs=;
 b=vwwaFTNbdxoPhNxF0vPF3nnOwtwxM7s1De1jZ+nOehwHhAgxRRmpGCilr0EnY3GJ5277etsQ4nZQEroMvZoP/R0OaYW9Bm79hq8hx7dIPDOYQXUMVRFXCChFqFBMjyuhlnRJd+oqlvcO1LdQ1DofuC3tnFgFUd4LbLL1wqcu/ZhV6GFjYSI0enoE38SM6uXd8966xvfq4GU+BkyxyAe3My8gamgLiGvcnQss+7kaqEhqrZmw3W9ZNCEEJHByA6QTnixPLTc2T1J4ZBcnIMDNt+x31XelchJvdrlhqZbqoXZyPcMP21sT7Wx5TPfZOtJGy1hK43Ld/uDBG0jEoXvldQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jd9/xZgxOWPU7bTYy2NXrhSlyTUHCxva7QqbUb4nJqs=;
 b=aISSQ2fBAGhd34p7JBmhmCOO08c1HK2G6/ROIYfYEHPqcsKXZ5q66A52ZFM51nM9dhx/dsqnJCQbWaMQmSp+lPi+kujhBhtLaopoidaBBSwIdFdLzBNpmlXqa/0zcfueAPWwUU0ZpRbMUSg5RjbTL1OU3W5ngSY7HGG0WnM0Mp4S1GeukdAhB30bjVd1Ixisqd33VgZlMmgGU5gG70ah7Km29s/mDVCP3PZwEU8KSR+z0Y0i9tPiMggxUTpK0pLLLprYGBqtzTxa8IunbwbO+lQCYHbVLaYfjpf0TVhZ15nU7lHwEUXP5JpczlNQDITwbBin9a14VO92Zlm8qVBfMg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9372.eurprd04.prod.outlook.com (2603:10a6:10:35b::7)
 by GVXPR04MB10303.eurprd04.prod.outlook.com (2603:10a6:150:1ea::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Fri, 6 Mar
 2026 17:56:20 +0000
Received: from DU0PR04MB9372.eurprd04.prod.outlook.com
 ([fe80::4f6:1e57:c3b9:62b4]) by DU0PR04MB9372.eurprd04.prod.outlook.com
 ([fe80::4f6:1e57:c3b9:62b4%4]) with mapi id 15.20.9654.022; Fri, 6 Mar 2026
 17:56:19 +0000
Date: Fri, 6 Mar 2026 12:56:10 -0500
From: Frank Li <Frank.li@nxp.com>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: dmaengine@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
	Kelvin Cao <kelvin.cao@microchip.com>,
	George Ge <George.Ge@microchip.com>,
	Christoph Hellwig <hch@infradead.org>,
	Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v14 3/3] dmaengine: switchtec-dma: Implement descriptor
 submission
Message-ID: <aasVOnhLoUjG9aOK@lizhi-Precision-Tower-5810>
References: <20260302210419.3656-1-logang@deltatee.com>
 <20260302210419.3656-4-logang@deltatee.com>
 <aaheutOqxlP50v0U@lizhi-Precision-Tower-5810>
 <da2dd099-0851-478c-8ace-0cd78e5b4550@deltatee.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da2dd099-0851-478c-8ace-0cd78e5b4550@deltatee.com>
X-ClientProxiedBy: SA0PR13CA0009.namprd13.prod.outlook.com
 (2603:10b6:806:130::14) To DU0PR04MB9372.eurprd04.prod.outlook.com
 (2603:10a6:10:35b::7)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9372:EE_|GVXPR04MB10303:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a64ef01-5e04-4ac9-6a8c-08de7ba9ab3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|19092799006|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	HVnbDdENEkXqsVdJIZaU85Wcn1+U8U3N5T6I36RuJXdljcYOuK0dlelH1PQgbcu921LTw8HBOGCe+uTpFM4/Bt6NyWGjqARYqvnZHP5J94vbIDky8AiCoogx1Px2S+XblbgQOSlaiV/y44HZv0Rd7E4/EKq7EkCk94nw1P1GWgXRkwkGt1aXOy/kdGYSIeyfVFEDWnLVA1BsZPdZpWCYTNorox3sySbhyLZkjUYvH0vBdCnwKu80nETEh8vq8X06aEzjugQTPrcLcdl5nfHB/UOwnBay4SY40CD1T+Xdb16IfK00g8y84YwG8mH//SxhdeUuxi/2SuMajTGKjS2ZziYTs8NdKVdPLby0EeRb2A/FsmupgBRo2WDswtVaePZ0LquH/ZcKPCGNJCZBthTTO0saaTttj2POLtRFAkIw3uYSFLswLkgmCxMlkb8YfhbYs8GAGGVH9sG59/MjNKOtioys25FlmqjjX2nmFEEekGj47mInFGO9WeMgP3xMbWZE0WdP2XW4LmNN10aZudMqb3OKGyipc27khsGwU6G8PQzpnM6gEQD11mxigXWZupOuR1zEoHQuLnyLhFzGs7jglKH4+aUaY0wtZJHcmDC3Rx9XazNCQHGN/YJXESRif2Xmv8iChEZMAA5hDeYsHJTrDiFqcX7S/X+RpO4jtNHqZT9jPgX1P95xVVWGW4gsyGnX1/CrbKolTTbYir8HfP+geUzZOh6/kPqZU3KgjBenPlsG9dJ2yQJY6IMTzUjn+FcK4jLqCTJNFubqoizmhARBZORuF6hohSBKXMqmEymjEyQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9372.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(19092799006)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9lX59Fjetif2qm5ARAkgSYbWmLuRziHT2R9FRJZ3v+zsyXIYkrn/iyuaKdEs?=
 =?us-ascii?Q?7b9KGbtZ8yPh+HXiNvkxECLZPNlXZ4zNWxO6371UNU/91o7R7CDbdGMdK1Ik?=
 =?us-ascii?Q?rRYXeJ/hz3tjhsK86BBPnA9lHHlf6EVgYbW42rudfBnC60LtDVK1lx3Ve5a2?=
 =?us-ascii?Q?48Z1/NJ+f7ZVS5UKWR7zvnSaPDoKcbU0gDIyyt+oqLF7zSmSTaKVTTzODMIV?=
 =?us-ascii?Q?AEeED27IYjG8TAHXGTzErxleEDziwFdm9BehbQandib37pnn6orfUUqfL8zI?=
 =?us-ascii?Q?mz7+W0Q81COQCcmAuFGoU7tFiNDc7GWPnXdEiu9CTHZfy4yf2ACNYDJ50euh?=
 =?us-ascii?Q?P7mUD8WI5uWPTV5GaWjuBA3AbdQHaR8x13Eog/jESrj8B+v3pGUg58FA7Ual?=
 =?us-ascii?Q?H0Be9EKJoawGJ/3Vz6nNYMbp5+IbMzzRylYgTOp/cDoZGJxY9qrawCyJmvgm?=
 =?us-ascii?Q?F4kcdgjhSEs1XvDJz4ARMji9YbsSP0Kl1AnrLj2x5cfs6SAkd0Xwml89N5Ec?=
 =?us-ascii?Q?HTgo8wtoQ5rdTadkhqgzj3eV1tYXkxn8QusnyYexSYd0h9yPopFl5MKjoKLk?=
 =?us-ascii?Q?kiGkYAv8mj7cqRC8uF5xcf0mnmo5SBRixsX/Mq2Bbm8qUOI5Ifljj/Y+i2SV?=
 =?us-ascii?Q?PY3iJppiturA9JZjGjQwsMT4C6Jf/XuIKttksebFGvv6dFxd1usTT/b7YmgS?=
 =?us-ascii?Q?C4jyw+tfXZTdZlXlUURCol5bLwbnqnFg6s/NUOEQRLIYicwhSN3Vx2KzqBtQ?=
 =?us-ascii?Q?iHCbprPssnx8TBU3zE87Z3OtI1UsDSkPCd8Tmeq1i6h37r+ZTXiEa0uCxPQU?=
 =?us-ascii?Q?lxq/2RSa2wTyJY56cdv/umMX6iaYXSg4w8wtmGWW+ylnCV/HGykd7Hsvihk2?=
 =?us-ascii?Q?1fr9K85oj6z8R5FUxJtFvk3OFaPZKidrIgo9ZHN+SNLbeSTBmFLzTHfscCoY?=
 =?us-ascii?Q?XgF7Djba/CyhUovxc6mfJKU22tA9ckqGN1Bz0D24bpjmGAvAEiiC/nUKiwN1?=
 =?us-ascii?Q?oidqG4+DXtfiSN8Y1Q/65lLUKRjPO6XK+mENLgAPyzfwWBipNrF+SGjgMzUS?=
 =?us-ascii?Q?9DsoKThE8+AKV6ODvVzBJh4f6MSopmVp/ZG09kDB7kXJFHReIArAGl2eAlJP?=
 =?us-ascii?Q?J1pK3upxWNhMNYLKatyXALNmRwy3a/P/GWvQOOSZp4hbNqQNYNALClHEEjJt?=
 =?us-ascii?Q?xVgZqkaugQcLef8A1brLKQDF2nq9kTbO0EWF8tpu4t0iE3cizWf/5n3FuOvO?=
 =?us-ascii?Q?i0FpaQbp/TR4/6t8AqY3TnS1k/YyPmUf9vjbfnFnEX/QpECfQqOT9xzB5XM2?=
 =?us-ascii?Q?0jHFmcoNpz/0uhtcrhglJMkbtg1Yyawb1JqempqqNBDYcTqksWfVVOIhEIOv?=
 =?us-ascii?Q?eZbyRrydAhhwTozH8GwNklC4Szbvsr0a4zFh4Z/VR0j59AlsyeazSXrU3939?=
 =?us-ascii?Q?YT55Y7EW0jsPeDwJYsLaGBazkjWPrBYifz4HalgpB9gbX2lhAU4kVD+PLWmx?=
 =?us-ascii?Q?NumqOait7sIFsLrNgjhtshCktMj9kqOhMsNCGBzvEui+9jicxQeEy6KP04Gf?=
 =?us-ascii?Q?KWLeUe4arFqAhBIG5uJpIml8r02rGm6wduKYR53wj+QM+Im590ny/AurQIb5?=
 =?us-ascii?Q?vU0FCN8xCGizwXoSl03a7RL0mSeJeuLWCEYtIZnyODzD+WxbmDeX3sXpCFFC?=
 =?us-ascii?Q?klMDuUKbyQSUCW4vIKvVDAQVXodlOIfqZGon6p8eC58dnR5Z?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a64ef01-5e04-4ac9-6a8c-08de7ba9ab3f
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9372.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 17:56:19.7966
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LZ+04VYObuRr3CCCKDe6WdNuFjcAOWgHSgWob6yc15CB/xhoSGlRXE5ADUAyK2OpcwFPgZ12+FTUx2vOc62L7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10303
X-Rspamd-Queue-Id: 1141D226801
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,microchip.com,infradead.org,wanadoo.fr,lst.de];
	TAGGED_FROM(0.00)[bounces-9307-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[nxp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.983];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,nxp.com:dkim]
X-Rspamd-Action: no action

On Fri, Mar 06, 2026 at 09:52:35AM -0700, Logan Gunthorpe wrote:
>
>
> On 2026-03-04 09:32, Frank Li wrote:
> > On Mon, Mar 02, 2026 at 02:04:19PM -0700, Logan Gunthorpe wrote:
> >> +static struct dma_async_tx_descriptor *
> >> +switchtec_dma_prep_desc(struct dma_chan *c, u16 dst_fid, dma_addr_t dma_dst,
> >> +			u16 src_fid, dma_addr_t dma_src, u64 data,
> >> +			size_t len, unsigned long flags)
> >> +	__acquires(swdma_chan->submit_lock)
> >> +{
> >> +	struct switchtec_dma_chan *swdma_chan =
> >> +		container_of(c, struct switchtec_dma_chan, dma_chan);
> >> +	struct switchtec_dma_desc *desc;
> >> +	int head, tail;
> >> +
> >> +	spin_lock_bh(&swdma_chan->submit_lock);
> >
> > Actually this try to force prep_desc() and submit() call sequence.
> >
> > 1 tx1 = prep_desc()
> > 2 tx2 = prep_desc()
> >
> > submit(tx1)
> > submit(tx2)
> >
> > It will wait at 2.
> >
> > Most dma consumer is that prep_desc() then submit(). If mantainer vnod think
> > it is okay, I am fine.  But I thinks
>
> Yeah, dma engine is commonly used this way. Multiple drivers already
> take a lock in prep() and release it in submit(). This is required for

vinod can comment this, I think it is not original dma engine API initialize
usage mode.

I think prep and submit is quite common usage case. I have patch to combine
to one steps, welcome to feedback
https://lore.kernel.org/imx/20260130-dma_prep_submit-v1-1-2198f9e848fa@nxp.com/

Further, we provide prep and submit callback to dma driver to avoid lock.

Frank

> drivers that are filling a hardware queue and then informing hardware
> the descriptor is ready on submit. Another thread cannot also add to the
> hardware queue if there's something waiting to be submitted.
>
> It's wrong for consumers of the API to call prep twice before calling
> submit. If two threads are submitting there is no deadlock seeing
> there's only one lock.
>
> Logan

