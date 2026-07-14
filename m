Return-Path: <dmaengine+bounces-12508-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /XGgF0SQVmpT9QAAu9opvQ
	(envelope-from <dmaengine+bounces-12508-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 21:38:44 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A633D7585D4
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 21:38:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=xuHNfL26;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12508-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12508-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4F6C1317C179
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 19:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CE6442BEBA;
	Tue, 14 Jul 2026 19:29:34 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011057.outbound.protection.outlook.com [40.107.130.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39FD742901D;
	Tue, 14 Jul 2026 19:29:30 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784057374; cv=fail; b=KC7FR6uW6iwnMN8RwYp+J5FuMBjEt9iUR+tux0OmZEqIMy0dNnu1affU/lE+cP+ZxPERhmsWvosYByl4ziL50ptlT6xfpUdVM8loK+3E3qZu6m3BQIstz2bLSPw0TLUnW4JCaXoms12uQLuhTEd/KYhdeig/W3nYbz86oSRqM14=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784057374; c=relaxed/simple;
	bh=x93ZX/8FakThYfy1R5Y9RLDa9AnLZYGyJTpUJTAj8jQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DBt1V6X5u+vMfm+JgViDf0PI4nNTalXwft1pZtofkB18YM84VmdsKyAm3T9eu5fj+SnOLSMNz8tEA0TNmaScQ6uGeYaSLY65pR8gcmG+9X3JurlYDGH7E/lW7L/232srROhB7UMnYqrJyn+2nXoluKO0aV0smqdy5hpbXc2khVQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=xuHNfL26; arc=fail smtp.client-ip=40.107.130.57
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H2dOiDiNDbZqC0A+ur+Ow0Gl9Gp2MjVQpEzWT43TAS+UbLXoKV1hjFplRdYcXlJhstMeSkNVrrilgSzOIdB+Ok+iae5mYHMh6ZP6B6wK+EwDL8eak3WgbvQiZH6sr5Nxffnmgqecy53ZS0vqVfERPvhxNufsRxMmwYSj0UWVuhs7amoBO2RWPJGQew/fDjI/eopnMd1Cyqr2F5iLeZ1BnRvLlIMR6bbM/tHa2X51R5c+cl124Z1oTKJ5PFIe7mmNE7KLxcjvYtrGIzHhMVm1mWVEZG+V7yECvaiErhNn9H2TeZR2M2O4f4jYb4krfzBB9G+u8QnL/3ws5+26GDS5qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O5gEE32lXiVA0BUtC1ZpX4cegZMZv4OzHXaOnmEk2qs=;
 b=smgVMNgYP3djXBjFwk49ug/QoqJePTw2RZGOcLzz5RmcWKfvoOLnqGSI3XLAdfN8gh5QcWb6skim17GXevmub6/5sRu3DCu3S5IOs0np2+2Tcmo7g14DjKaTyUjtJfj5geQr+h1/bxwZfebmDfVpuoyLnP4cd2/M05LAeIqAQ3fiVBWuFxfk308BWMLFsHS2+nR1qfSixA6pr0NTwy23ojw4T90D+zIV8e65tyhfkNALsqXev4TT8/qWIP6F2ZPNBe9XRt+OqJ+3jUypIcqPt741UROoNVv7lirR7Tbr1u5E897YeJB3QobpZL6w9E3GN/6eQKhnPNa3+MS6IlwSYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O5gEE32lXiVA0BUtC1ZpX4cegZMZv4OzHXaOnmEk2qs=;
 b=xuHNfL26q8aukelXxgTE5BxGYd/FrTVtUsRFEJwgQ8sTn400Iq3GzUQWQ/3P/SqB6S21esVflYj/lBfk9TOYiPwQGdVKjYCzJlgf8Rrt7vcTwhWr2D7gcGsDsVgN6plLj1K2v8xAB0K+BgKWH3KaOVyol2D+L+e3ot4A563zePirmJQhrLFzPwbumkUbuctganeQupAyCaAbg/sYng2ieYCvZ8XzTcnEId8UtMFSGefmFPZFkaWaB2u+emfk11SneuCbx9f2vDZhcpOwasWAHZxjICLpPnIiLOFqBz5qhMrKbHGltiRB1Ecwsn/BWSepaUFCLywt6A0poLf+IBcc2g==
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by DU2PR04MB9131.eurprd04.prod.outlook.com (2603:10a6:10:2f6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.23; Tue, 14 Jul
 2026 19:29:27 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0202.018; Tue, 14 Jul 2026
 19:29:26 +0000
Date: Tue, 14 Jul 2026 15:29:19 -0400
From: Frank Li <Frank.li@oss.nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 05/14] dmaengine: dw-edma: Add partial channel
 ownership mode
Message-ID: <alaODwnZQ7YDpUx4@lizhi-Precision-Tower-5810>
References: <20260710081518.2394357-1-den@valinux.co.jp>
 <20260710081518.2394357-6-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710081518.2394357-6-den@valinux.co.jp>
X-ClientProxiedBy: PH5P222CA0006.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:510:34b::6) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|DU2PR04MB9131:EE_
X-MS-Office365-Filtering-Correlation-Id: 187e39f8-1ef8-41db-e559-08dee1de379c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|19092799006|23010399003|11063799006|4143699003|56012099006|6133799003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	7lBtfKk52bsI6u5w9qPefZmwy2FkJqBP5XJEwMjSM3qIjOfhCNS8yDdpb6FWKuotRFY5rWkeSsmtqtNXMsHyr3QPBrvd3exE8ESf6dOSQ6JCVBOX4WrvLpo/hU46y9SJW7VLH8S3lhc49I1whwrNV1oIABCmZ2h7/onwv04VG645X4fRZ/LlJKGHNiVczjeLlN3zZqbAM+0Y1ch8a2NpjdYy7lcsTWGEXYN7R7YE/cD5a/khchUm4WXH8a9R/WInz6fr2N3MCukZHXj1HPcFdSg51nPzafg9EukMDes7GYuTzvE/fF0QdcBkxlbJAtn3MN2sltL87yGV5cG+vO0lBm1bvRGqeC0jcex5R90oiUjiK1lpq4h3DfuNFzw4k1ikMfdWi+2spDu1KObbsnh6VXo9RACst9W7Ckz6C8I8BdWSqICLJyu4KCChUsQNa2v8Qd+xefAGBkTmZPzeXOlIZQOPcOV2e+0BxgQ6XZkQHvWHv0C2pYumkQ9ClSQYw2DGO9cTMNdCbz7gjY0m6VUNsKl9GEe2ro4ai0Y0vROJUqKPl5GdMezveoFIZSV7uFkGQSt3tHZwV4BUpPW0DMebSjSheulfG3TfU10En/KhSfYuVeb3oRDP9bjWovr6+6UufjPcQqkzQ9NsHg649njY/u1lJLD2/ojDQDpWcF+O0zQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(19092799006)(23010399003)(11063799006)(4143699003)(56012099006)(6133799003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fj7yVEzD31HAZLBUqMan+GpceqWXJQP/tEudTZuxPTrDylfOyburN5tr4f8L?=
 =?us-ascii?Q?rQ9fptlWggWBpb3KG+uXJq2B4hkg/u4sVcXsstzaGwjMLYUSVcz+tQqdWkdt?=
 =?us-ascii?Q?qECyZHc77h1GYtEx0GFtFxvQO8zst0bgEobjud6vkUmJvlwxClkk24r5ew49?=
 =?us-ascii?Q?MXokpWZEPv5N2WHZqz/mSpqrAXhgbyxe3MTnf5KKQCwQu6ZoZir9WUNzsdS4?=
 =?us-ascii?Q?GwwDnimCv/eaqyeoiytYFz+kackG8Ao5syUaEL6VL3h5STQ8cQXG91E8IJVX?=
 =?us-ascii?Q?1piKdDzEla7RV+N0obyRO3/svUe+YOTHQRPEf+pVXqM8iJ+MHOBwOmU5spzS?=
 =?us-ascii?Q?ElwhjueatRWnAL1mn/qQeyo4mivlhniDmrUaFFuUKRqXdR0N/j9WncL75Aw3?=
 =?us-ascii?Q?DajgO0pIs/V1jDQPwxgAx8v784OHm/wSNzPXpuJcEbFiOxbY80D8NZhWyPG3?=
 =?us-ascii?Q?qX56ITEY9x3V1xodTBHtrlgMNVn3WXdBycgRDYh3baCVADzdir9O91Wh7qO7?=
 =?us-ascii?Q?sidh3W/E+Kj78gmA5Rlc8sLU+6LrML7Xs/RgLPaUNtmRc6wBNcmwkrDSG9M9?=
 =?us-ascii?Q?3XKbd3RCB77HzNhMY5hUIJMr9UrA9bSiRronLIDKkPmSjjAet25q9N42Bh8S?=
 =?us-ascii?Q?XVz2eiuo3SfJqMvTF0UMaTKN/vCyHUHFykRhFi7oWcNuvFBuGVFpH7tUvuk4?=
 =?us-ascii?Q?jwOFX5svx5stLe19WDHEyHaOb7xX+Da5Gqwf6aOHYNfB1J1dAsMoLpwl2vjd?=
 =?us-ascii?Q?1eUveCREkYOjB7q2XZsxbAcyKFVRWj0kEMHvZdftbH70lCuuiSnBzmHLU1JW?=
 =?us-ascii?Q?0ks8btef+ZrIElLRZK/vlkNPd5ZZ0d+xG04FcnTQSF7ro5BEyQE7bRA576st?=
 =?us-ascii?Q?xx17R575zAL4GB8s8XO3eEdTIdqk8BznD7q7whm1FCmBh1A8uf4F2qtR7HxR?=
 =?us-ascii?Q?TTWwPtbPafgIftOT2pBtXs1BNignoRu4ztgN0IXiBvm7/cjYFGMclojInzxd?=
 =?us-ascii?Q?fpy/5Fv669Mpi1k+v+BMAJqSXnquIoPuwpxmtc+jLkW6p8256D171HXuucSt?=
 =?us-ascii?Q?TM35lk3l+q/CSsFKFBh/DaUO5foZOgmXTnfP4A8/1t20e+oD2vqF2lXirXEc?=
 =?us-ascii?Q?b0om7vel5mGltyi7Bsh2k+zNqMrLYmWJJJkOuzUP4N6/ybxfhLtWISelu53R?=
 =?us-ascii?Q?eJoE/DO8RQlcz70DjrvJDHN7NbzQMCLZC7ym5NQOPl0azRktV4ZDQzmYES2m?=
 =?us-ascii?Q?14Oq+4ZuOfnY14yYJwRKuquIx6OXkkLu1heOiGbN3lD+zqXkoKNHX0L0jorj?=
 =?us-ascii?Q?41bumGFYvUup0Pt1lVNVBChXAr88M0P3PzkSjzsckf3F9SEI6mH+LLHFjsta?=
 =?us-ascii?Q?E0VzPf1F2FcscfRQludDmOSekBHSxeYu50WSfZEMxRZl9z6xPcHI66UT/PlH?=
 =?us-ascii?Q?u59Updb2pXLhUPYeYlzFlKX5p34OCT0UjVxqcepam7o6jSmDFP3whpzfxx7c?=
 =?us-ascii?Q?9jiIt2CFYkY3GYcAN3elhAy/ra6336Or6lmjgYXmp4EPTK0Whil4yPqlgIZY?=
 =?us-ascii?Q?Z6JRHGcN2rBZXJdcFmo8auXiHLRLKWFzoTTwITx+obd1hNVJXw9OU6ZbNPnE?=
 =?us-ascii?Q?ygSc6HjWyV9R3YpOjpauJO+KDH/igrH6yQ/WU9GZjkSC65IFea9pwJV0y7l3?=
 =?us-ascii?Q?YU6O6yk5zIX2nMXQq1rRi0EILqnwlXiE/ZJv48ZY7Nr5qlY2bnCwrRnkhIN3?=
 =?us-ascii?Q?aH2fP3bHI0SPLxxVdK4OoWJc5SUrKOIvTrqZdnNobHd04ozU6fy8?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 187e39f8-1ef8-41db-e559-08dee1de379c
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 19:29:26.8374
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D++PGmL4wZmqU9GcJoohjvGcBvcUQUoc42IqW3gY+44UKijZ0gbp+hsjNJPKbFtf3amegHBWXX57FYBs8fKaTJj2LRnmUl1jwppcpCCQ6Im9DBz79EcF8BGnI/ckah7f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9131
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-12508-lists,dmaengine=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:den@valinux.co.jp,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:mani@kernel.org,m:marek.vasut+renesas@mailbox.org,m:yoshihiro.shimoda.uh@renesas.com,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:marek.vasut@mailbox.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[Frank.li@oss.nxp.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@oss.nxp.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lizhi-Precision-Tower-5810:mid,valinux.co.jp:email,oss.nxp.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A633D7585D4

On Fri, Jul 10, 2026 at 05:15:09PM +0900, Koichiro Den wrote:
> A DesignWare eDMA instance may represent only a subset of channels that
> is also initialized by another OS instance, such as an endpoint-side OS.
> Add a partial ownership flag for instances that must preserve
> controller-wide state owned by that peer.
>
> In partial ownership mode, dw-edma skips the initial core reset and uses
> the limited quiesce path in probe() and remove() instead of the full
> core-off path. The flag also makes the driver validate the ownership
> granularity required by each register layout before registering
> channels.
>
> Partial instances also skip interrupt-emulation doorbell allocation: the
> emulated doorbell is a controller-level resource, and a partial owner
> must not claim it on behalf of the whole block.
>
> For EDMA_MF_EDMA_UNROLL and EDMA_MF_HDMA_COMPAT, the driver programs
> per-direction registers, such as DMA_{WRITE,READ}_INT_MASK_OFF and
> DMA_{WRITE,READ}_INT_CLEAR_OFF. These register layouts have at most
> EDMA_MAX_{WR,RD}_CH channels per direction, so the capped hardware
> channel count still represents the whole direction. A partial instance
> can therefore expose write or read channels only if it owns every
> channel in that direction; otherwise two OS instances could update the
> same direction-wide registers without a shared locking protocol.
>
> In contrast, HDMA native uses per-channel registers, so it can be owned
> at channel granularity.
>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---
> Changes in v4:
>   - Fix and revise commit message. (Frank)
>   - Move partial-ownership validation into dw_edma_check_partial().
>     (Frank)
>   - While at it, add a small source comment that explains why local
>     variables hw_{wr,rd}_ch_cnt are introduced separately.
>   - Quiesce represented resources during partial probe as well as
>     remove, draining stale channel state from a previous owner without
>     resetting controller-wide state.
>
>  drivers/dma/dw-edma/dw-edma-core.c | 75 ++++++++++++++++++++++++++----
>  include/linux/dma/edma.h           |  7 +++
>  2 files changed, 72 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> index fb17074917df..0d38de4480a0 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-core.c
> @@ -831,6 +831,9 @@ static int dw_edma_emul_irq_alloc(struct dw_edma *dw)
>  	chip->db_irq = 0;
>  	chip->db_offset = ~0;
>
> +	if (chip->flags & DW_EDMA_CHIP_PARTIAL)
> +		return 0;
> +
>  	/*
>  	 * Only meaningful when the core provides the deassert sequence
>  	 * for interrupt emulation.
> @@ -1188,10 +1191,33 @@ static int dw_edma_irq_request(struct dw_edma *dw,
>  	return err;
>  }
>
> +static int dw_edma_check_partial(struct dw_edma_chip *chip,
> +				 u16 hw_wr_ch_cnt, u16 hw_rd_ch_cnt)
> +{
> +	if (!(chip->flags & DW_EDMA_CHIP_PARTIAL))
> +		return 0;
> +
> +	if (chip->mf != EDMA_MF_EDMA_UNROLL &&
> +	    chip->mf != EDMA_MF_HDMA_COMPAT)
> +		return 0;
> +
> +	/*
> +	 * Direction-wide registers are shared by all channels in that
> +	 * direction, so a direction must have a single owner.
> +	 */
> +	if ((chip->ll_wr_cnt && chip->ll_wr_cnt != hw_wr_ch_cnt) ||
> +	    (chip->ll_rd_cnt && chip->ll_rd_cnt != hw_rd_ch_cnt))
> +		return -EOPNOTSUPP;
> +
> +	return 0;
> +}
> +
>  int dw_edma_probe(struct dw_edma_chip *chip)
>  {
>  	struct device *dev;
>  	struct dw_edma *dw;
> +	u16 hw_wr_ch_cnt;
> +	u16 hw_rd_ch_cnt;
>  	u32 wr_alloc = 0;
>  	u32 rd_alloc = 0;
>  	int i, err;
> @@ -1203,6 +1229,17 @@ int dw_edma_probe(struct dw_edma_chip *chip)
>  	if (!dev || !chip->ops)
>  		return -EINVAL;
>
> +	if (chip->flags & DW_EDMA_CHIP_PARTIAL) {
> +		switch (chip->mf) {
> +		case EDMA_MF_EDMA_UNROLL:
> +		case EDMA_MF_HDMA_COMPAT:
> +		case EDMA_MF_HDMA_NATIVE:
> +			break;
> +		default:
> +			return -EOPNOTSUPP;
> +		}
> +	}
> +
>  	dw = devm_kzalloc(dev, sizeof(*dw), GFP_KERNEL);
>  	if (!dw)
>  		return -ENOMEM;
> @@ -1216,13 +1253,21 @@ int dw_edma_probe(struct dw_edma_chip *chip)
>
>  	raw_spin_lock_init(&dw->lock);
>
> -	dw->wr_ch_cnt = min_t(u16, chip->ll_wr_cnt,
> -			      dw_edma_core_ch_count(dw, EDMA_DIR_WRITE));
> -	dw->wr_ch_cnt = min_t(u16, dw->wr_ch_cnt, EDMA_MAX_WR_CH);
> +	/*
> +	 * chip->ll_*_cnt describes the channels exposed by this instance. Keep
> +	 * the usable hardware counts separate for partial ownership checks.
> +	 */
> +	hw_wr_ch_cnt = min_t(u16, dw_edma_core_ch_count(dw, EDMA_DIR_WRITE),
> +			     EDMA_MAX_WR_CH);
> +	hw_rd_ch_cnt = min_t(u16, dw_edma_core_ch_count(dw, EDMA_DIR_READ),
> +			     EDMA_MAX_RD_CH);

If need respin patch,  now it is safe to use min()

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> +
> +	err = dw_edma_check_partial(chip, hw_wr_ch_cnt, hw_rd_ch_cnt);
> +	if (err)
> +		return err;
>
> -	dw->rd_ch_cnt = min_t(u16, chip->ll_rd_cnt,
> -			      dw_edma_core_ch_count(dw, EDMA_DIR_READ));
> -	dw->rd_ch_cnt = min_t(u16, dw->rd_ch_cnt, EDMA_MAX_RD_CH);
> +	dw->wr_ch_cnt = min_t(u16, chip->ll_wr_cnt, hw_wr_ch_cnt);
> +	dw->rd_ch_cnt = min_t(u16, chip->ll_rd_cnt, hw_rd_ch_cnt);
>
>  	if (!dw->wr_ch_cnt && !dw->rd_ch_cnt)
>  		return -EINVAL;
> @@ -1239,8 +1284,16 @@ int dw_edma_probe(struct dw_edma_chip *chip)
>  	snprintf(dw->name, sizeof(dw->name), "dw-edma-core:%s",
>  		 dev_name(chip->dev));
>
> -	/* Disable eDMA, only to establish the ideal initial conditions */
> -	dw_edma_core_off(dw);
> +	if (chip->flags & DW_EDMA_CHIP_PARTIAL) {
> +		/*
> +		 * Do not reset the shared controller, but drain stale state
> +		 * from resources represented by this instance.
> +		 */
> +		dw_edma_core_quiesce(dw);
> +	} else {
> +		/* Disable eDMA only when this instance owns the controller. */
> +		dw_edma_core_off(dw);
> +	}
>
>  	/*
>  	 * Deferred IRQ works are queued from the hard IRQ handlers, so the
> @@ -1296,8 +1349,10 @@ int dw_edma_remove(struct dw_edma_chip *chip)
>  	if (!dw)
>  		return -ENODEV;
>
> -	/* Disable eDMA */
> -	dw_edma_core_off(dw);
> +	if (chip->flags & DW_EDMA_CHIP_PARTIAL)
> +		dw_edma_core_quiesce(dw);
> +	else
> +		dw_edma_core_off(dw);
>
>  	/* Free irqs */
>  	for (i = (dw->nr_irqs - 1); i >= 0; i--)
> diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
> index 1007122d4123..3c33d12d1cdb 100644
> --- a/include/linux/dma/edma.h
> +++ b/include/linux/dma/edma.h
> @@ -55,9 +55,16 @@ enum dw_edma_map_format {
>  /**
>   * enum dw_edma_chip_flags - Flags specific to an eDMA chip
>   * @DW_EDMA_CHIP_LOCAL:		eDMA is used locally by an endpoint
> + * @DW_EDMA_CHIP_PARTIAL:	Only channels described by this instance are
> + *				owned by this driver. Controller-wide state
> + *				must be preserved, and layouts with shared
> + *				direction-wide registers must only be shared at
> + *				direction granularity. Layouts with per-channel
> + *				registers may be shared at channel granularity.
>   */
>  enum dw_edma_chip_flags {
>  	DW_EDMA_CHIP_LOCAL	= BIT(0),
> +	DW_EDMA_CHIP_PARTIAL	= BIT(1),
>  };
>
>  /**
> --
> 2.51.0
>

