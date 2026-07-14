Return-Path: <dmaengine+bounces-12509-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id U4DKAPKQVmqZ9QAAu9opvQ
	(envelope-from <dmaengine+bounces-12509-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 21:41:38 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 868DB75862D
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 21:41:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=OwCooyQ1;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12509-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="dmaengine+bounces-12509-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 886BB3120C57
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 19:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD13A424D40;
	Tue, 14 Jul 2026 19:32:14 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011070.outbound.protection.outlook.com [40.107.130.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98EF41F36A;
	Tue, 14 Jul 2026 19:32:12 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784057534; cv=fail; b=eFOJhLjoLNu5E9zi96n6yILlMA7h4IQn8odY0RN1wEvT/UB19eNeH3al9EffXfNCq00KdvKxMtmPo67wCfyZh4JLOC9rFKJTQq1YqT/hkyxNCUAm1AwCDGxL/rAngtDo0bUCAHCFJsM8P4VRwQjwhmsoRsmXoyvneEF8d4X61OQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784057534; c=relaxed/simple;
	bh=TUFt22xtrutSUbiv5BaNw9rqSwkKIWsHtJczO0Q7eDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Z2gNqLtNp9hMuwhsOjQAySw/yj24oCvc4dV9YAMsTGfanUPQ3E66E6t1+UVEijQKtAnPJThEtOSDmIv3BCfJCWlqDSUWZj20771DwhiFOWI4a4e0yFPDDPuGW+tt59BR/XiLwf2xeRnFcJalVetx+1o5AUH9mei3dMD50ijvlWM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=OwCooyQ1; arc=fail smtp.client-ip=40.107.130.70
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ydhBdZK7jXSrIu7Z3FKo1of4jWZ1GTevKrYbw7t3dnVwhLXbBtm1nUxsGhYw+jOELxlpNsXs+1mVUm3dAosyc5716Q0kDeTll7LpbaBRsmQPtpgXCOJE/7OE7liti2nkx2B199AwwToVPS56ACilN8dR08JxMiJSXed37JaynUrh8uRmshXL5Mv9MWLZk4GACWpC7k3i+f7RnBOql1AwgqVzwREKcDBLPQIbxwKXIw1NaXQxRNtyaIcllDRLbzAl3DuYxo3/Q/o98U/4V8ts+SoraZI+UPJJ6UTGeT0VnemKAMU8DpzEkXokkUxCPZl/UjT+ZccIMF1f43VYp54DAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UhxbOmgRUmLZIpAKPDiJH2EB1uokyijSOQRliTBsQa4=;
 b=NhAzDinAasjryw8sLOHeZTaCn/axqH/qXubAYndi+rZZSsRPQkDt6Gt854R9NYJLXdKD1GpB5FQbJliszjkABEhyahzcb+ZW/r0h7xBcWTLdp0QfnDBMLnGtxV6hQI3jQssOu4fbBafHNJGsgD51zDk31UJksNYOvQXNsJ8AWu8VnFkxVyDY+GItC6lX4g0az+VUGdG9eH1PAs78yhNs1HHZ3WSnWlm4LmjCgXzFkeLEzLHitKe8OMS+CSDV6AD5SwN+9CEYyShbIl8x+YAG8MDQ2WfdgEMjuiv4LBlCXPFqMepq5oSDZJT1j/bwDCw73AdubeYZk5ryjfbFS+nycg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UhxbOmgRUmLZIpAKPDiJH2EB1uokyijSOQRliTBsQa4=;
 b=OwCooyQ1069VTFvrh2sKGroKBTDUugXSP0s4SrUy/bjk+2cR8viM/lXGAHAN51SOO65uudgaqTEqoPV7YCzQW2M1naYkLzfDHdy5GHj68kcuAfT4nISZa8YM11hfM7ckriSV/PP2i3+OjkcGAZk+bOed8uDO12k8MR4MZtvk2+e2zrepEYdguuCFreOgRxdixfWwcNbG7oDczzdyiYbl/j3XRZA5g/3a2SNlwbtgzgLfgVbAX/Eq2nfr3XkejmTTUumEonxrTaZZB1TuimJnxTUwtS1X+upO8kyLID61zMpKODk7ELRZcTkQNbbjVtXw7PabDCpCqUe3cjAtQ1n/dQ==
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by DU2PR04MB9131.eurprd04.prod.outlook.com (2603:10a6:10:2f6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.23; Tue, 14 Jul
 2026 19:32:10 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0202.018; Tue, 14 Jul 2026
 19:32:10 +0000
Date: Tue, 14 Jul 2026 15:32:02 -0400
From: Frank Li <Frank.li@oss.nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 14/14] dmaengine: dw-edma: Program endpoint function
 numbers
Message-ID: <alaOsiVrmMMLBfco@lizhi-Precision-Tower-5810>
References: <20260710081518.2394357-1-den@valinux.co.jp>
 <20260710081518.2394357-15-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710081518.2394357-15-den@valinux.co.jp>
X-ClientProxiedBy: PH8PR07CA0048.namprd07.prod.outlook.com
 (2603:10b6:510:2cf::19) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|DU2PR04MB9131:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b9ef47b-1ee3-48b3-3de5-08dee1de98fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|19092799006|11063799006|5023799004|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	+u1BCFOpWy88cyzZSDmJv4jn8QUCMN7PsLeTohkkhfjCDIV7PLPD1EyiCc5MAiU4wQqLsDQaGQJ8eCzRdwO2r1P9ijWBEc14dixnmyXsB6nLga5dAqxoQa41k9/NcRH2unSzw1Nsr5MRag5F1T8CjM1Hk6XFtb/kZZheKFBhghGuZWhrhp+LCsIyx9KrcEpjigiLCexEOiNpPdyu5gLnlzmvhkrroWFErS/KwCqzp/H7S0Stbd6zWU4y0AafcvFNzOH22QIuB9AQ3dzsti705UO2uminPKXD6moFOz8YMBISGpxKItCot6l1fXoHkAP7lm6P5OSNeer1Rn2xK87zs1zcubqNYgHJv4UcO0e3trO86L9vTONimt9YjywQCs/mfyo/8B/viqXo7l+c3ulynyUQZLyMZuS1BmTfE0uYcq98bIPWAu5fpXHgSqeJqcZ9iG8PmIBkzQ0nTgSxBZTIlHSJJaRNy5cOsNTts4GOEJKEHcxRkg7U1rbnJV3ZCtLkXy9qXqyDm8PE9C5AABcmW+DGt5e6UEUiDV5cE3z+i4mKB+zPAuZ75g71MvunOWa6xgCiQDTgENleVc4oIdXdXs2mk5VvURUyvcw+93kd6a6cOWyOhQh8e1O/+4McFvVc/9fx9JrabdZ1sVL1fIWo3xlLUkSlDInj/sX4cbwbYMs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(19092799006)(11063799006)(5023799004)(4143699003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ECWx5BO9Jp1o/JfGBb6RMNaW5fC1ObChIf1u6UeUusyI2Vq/EaU6A7cRRSyk?=
 =?us-ascii?Q?RYkEzJcAiVyPNzmFrXv5bTIiq249lVBnvZ5AsaAIRDuegRaHrNdWVHv43xOi?=
 =?us-ascii?Q?J/1L39AHZATVwm611nD+G90mo8BrUuXUE8MI3oj5wJVExVKQ7j1IjEk77sc6?=
 =?us-ascii?Q?KhxakwJ1u02qp82Z0+tIqM70EPwi3BE+TQZRh+evVipe57LKfdvsNlQGUtWh?=
 =?us-ascii?Q?uD4x7dx5/HYe93glLKzIjgbw9w61OSz6v4/RCjNbplb0awXnQcvMQnfDrlp3?=
 =?us-ascii?Q?5SJaGVgBAf2husDwWlEaSj+XzNcUDApmnm/pMNvf0ios/JedRBuUo/CTSM3m?=
 =?us-ascii?Q?inTM6ZK/8DFFjWn6QR+bfWUJdrT3ybNys4aZFSvc4rXJCs5NyxdLjJTIj/PJ?=
 =?us-ascii?Q?T0LADXqVqm9ivjOnwM1Ahs94PlfFyG0PEW1T6z2Skn/DLA3ZgDFsM5S4PsXP?=
 =?us-ascii?Q?mlCjj8fBsa5ft9rS9M2FZGldcQWgniBXu5N38lNQA0LGjTScVFaG8UJBvlNE?=
 =?us-ascii?Q?Mhs8a9rulp8vIx4c9h5jav2zLyDOA7AD8XSvIOTjaegVL8Bbfble2qbZQz6P?=
 =?us-ascii?Q?jqx/oCDh2lEniz6di6rog2j0ofhKXrCZ3bQmbqGKTI3BhUZj4y4drixrbS5U?=
 =?us-ascii?Q?IfgYpVovl1vXAEwWsaNqtAaP53HxIG/ZDQOg7eyo0N1KpdFWDjWxs5l/7nd9?=
 =?us-ascii?Q?Gt89+4AZzT9ifCv0+HmB7dv4/wsKrWmZ+jxm8e+qdjJXUgIYCKDWERAZaI37?=
 =?us-ascii?Q?P44bPFfKWh4wi+rAZulNfkohIxg9rQp/X3LYSKBIAy4BEENECPiaFwdr1jEL?=
 =?us-ascii?Q?5UwKdRRvxiB3IVM2P4/rZNo//7vabT98FMiq0UUbcyLpW7fvMcBbrYgtNcqD?=
 =?us-ascii?Q?uDxeSqUFqpRsd4wwG/ujM50TMsRv5i20bxQeyZjRT/fpIeeaWObIiK6WraA0?=
 =?us-ascii?Q?B8It9mNOv5ab/OcERsR1g3hri68om7PbFt3YtlOCwJPnSsUeS79LFWHbBZwU?=
 =?us-ascii?Q?dH4t25bBzT2vXZGttpf9uEJUdMsg4EvM/dkM0ydfRTVtbWF4H0QNrIstvB0Q?=
 =?us-ascii?Q?Fe7nO3p6oHmNaT35wW1Dxw0KyCN4fHqCoKB5uzr60ap2bNP4WsnaAnyXtvxX?=
 =?us-ascii?Q?+NZ19QIwLoSPwC70qrmnIwiM6aUCGbelXo6xoRSs9kawt90Izj2S3IUYyXU3?=
 =?us-ascii?Q?psI/n1d96iEB18ndMvLgiCoB2JkT9AZM054rL0grGQ3F7TEKrrN/kvpRM166?=
 =?us-ascii?Q?LyZU/1yDH317W0aZ23LdYxvrp0UAXXkC+MDxDXlZd9P9RjcZWTcyzgIynnS1?=
 =?us-ascii?Q?Y48Q+QqlYO6Wsf50H/gSCiMdLXL+2cN/Bt1bpAQLObd4DX0nFrZDpquRH+Bq?=
 =?us-ascii?Q?0OmBZCYWh3tvZkKj3Y06WfznFAOSVlmNxRELUwnHT36hvGhksciodBQKmy78?=
 =?us-ascii?Q?SZcT4emkdktJTMbgfn5pNQzjU4gcezMqlVoGqKqoyjHCKTSVgzZSVqc6Sn3P?=
 =?us-ascii?Q?fcY0znz1UzacahrQF59lkRwwo2h1SqO6d2/WiLCmUO+Kr6Z8H4rlDtdigbBI?=
 =?us-ascii?Q?+xQX/96kYyrwNONEcheakBTIIJZz0Ha43yTXgNBje5e8EKuovLSPeH7Bb52N?=
 =?us-ascii?Q?6YrznCiS/+vXrXXmJlSPXR2Q1PoVSnszsqTsHH34i7BX1SkGO74eCDtXet4d?=
 =?us-ascii?Q?PpwVULZCu8ExfBEBA+jMi2XfZNr3MrnUbWMCMKi3K1hBGLEK8f3Q+q7JOMw9?=
 =?us-ascii?Q?en/Pl2EX+ABm+YEMtXCsvxwsCif567hvFjHw/te6CQAwxes/4VW+?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b9ef47b-1ee3-48b3-3de5-08dee1de98fc
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 19:32:10.0789
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZtXiyLZ0Xg11zbWldKPnYDqQ0h47ERb/PveD6v7miITT/921+YhDogO5tYVwB/VqzPZ3RueoNr2yxZbnjqajSdl6Uhp7SaFOt5GSFCJQbczMnq3gMCr39kS4kgTN3PzZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9131
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-12509-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,lizhi-Precision-Tower-5810:mid,valinux.co.jp:email,vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,oss.nxp.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 868DB75862D

On Fri, Jul 10, 2026 at 05:15:18PM +0900, Koichiro Den wrote:
> The eDMA/HDMA transfers the driver issues carry a requester function
> number in their TLPs, but nothing ever programs it: eDMA v0 leaves the
> FUNC_NUM field of the channel control word zero and HDMA leaves the
> per-channel func_num register at its reset value, so every transfer is
> attributed to function 0. That is invisible in single-function setups,
> but once the DMA block serves a non-zero endpoint function, its
> requests must carry that function's number for the host to attribute
> and translate them correctly.
>
> Record the function number in the chip data (PCI_FUNC() of the probing
> device for dw-edma-pcie) and program it per channel.
>
> Endpoint-local chip instances keep func_no at 0, so transfers issued by
> the endpoint-side driver remain PF0-attributed. Delegated channels are
> programmed by the host-side dw-edma-pcie instance when it takes over the
> channel, using that instance's PCI_FUNC().
>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> Changes in v4:
>   - New patch in v4.
>
>  drivers/dma/dw-edma/dw-edma-core.c    |  1 +
>  drivers/dma/dw-edma/dw-edma-core.h    |  1 +
>  drivers/dma/dw-edma/dw-edma-pcie.c    |  1 +
>  drivers/dma/dw-edma/dw-edma-v0-core.c | 10 +++++++++-
>  drivers/dma/dw-edma/dw-hdma-v0-core.c |  3 +++
>  drivers/dma/dw-edma/dw-hdma-v0-regs.h |  1 +
>  include/linux/dma/edma.h              |  2 ++
>  7 files changed, 18 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> index 0d38de4480a0..d1af44124075 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-core.c
> @@ -1016,6 +1016,7 @@ static int dw_edma_channel_setup(struct dw_edma *dw, u32 wr_alloc, u32 rd_alloc)
>  		chan = &dw->chan[i];
>
>  		chan->dw = dw;
> +		chan->func_no = chip->func_no;
>
>  		if (i < dw->wr_ch_cnt) {
>  			chan->id = i;
> diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
> index 8657275d2484..1cf95ab27071 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.h
> +++ b/drivers/dma/dw-edma/dw-edma-core.h
> @@ -78,6 +78,7 @@ struct dw_edma_chan {
>  	struct dw_edma			*dw;
>  	int				id;
>  	enum dw_edma_dir		dir;
> +	u8				func_no;
>
>  	u32				ll_max;
>
> diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
> index c1585c8ce11f..bb477dc0fb03 100644
> --- a/drivers/dma/dw-edma/dw-edma-pcie.c
> +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
> @@ -473,6 +473,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>
>  	chip->mf = dma_data->mf;
>  	chip->flags = match->chip_flags;
> +	chip->func_no = PCI_FUNC(pdev->devfn);
>  	chip->nr_irqs = nr_irqs;
>  	chip->ops = match->plat_ops;
>  	chip->cfg_non_ll = dma_data->cfg_non_ll;
> diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
> index 32df5d13ba8b..441fa8f67d5a 100644
> --- a/drivers/dma/dw-edma/dw-edma-v0-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
> @@ -25,6 +25,8 @@ enum dw_edma_control {
>  	DW_EDMA_V0_LLE					= BIT(9),
>  };
>
> +#define EDMA_V0_FUNC_NUM_MASK				GENMASK(16, 12)
> +
>  static inline struct dw_edma_v0_regs __iomem *__dw_regs(struct dw_edma *dw)
>  {
>  	return dw->chip->reg_base;
> @@ -159,6 +161,11 @@ static inline u32 readl_ch(struct dw_edma *dw, enum dw_edma_dir dir, u16 ch,
>  #define GET_CH_32(dw, dir, ch, name) \
>  	readl_ch(dw, dir, ch, &(__dw_ch_regs(dw, dir, ch)->name))
>
> +static u32 dw_edma_v0_func_num(struct dw_edma_chan *chan)
> +{
> +	return FIELD_PREP(EDMA_V0_FUNC_NUM_MASK, chan->func_no);
> +}
> +
>  /* eDMA management callbacks */
>  static void dw_edma_v0_core_dir_off(struct dw_edma *dw, enum dw_edma_dir dir)
>  {
> @@ -474,7 +481,8 @@ static void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
>
>  		/* Channel control */
>  		SET_CH_32(dw, chan->dir, chan->id, ch_control1,
> -			  (DW_EDMA_V0_CCS | DW_EDMA_V0_LLE));
> +			  DW_EDMA_V0_CCS | DW_EDMA_V0_LLE |
> +			  dw_edma_v0_func_num(chan));
>  		/* Linked list */
>  		/* llp is not aligned on 64bit -> keep 32bit accesses */
>  		SET_CH_32(dw, chan->dir, chan->id, llp.lsb,
> diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
> index be22f9f811ca..ea9f18c8d707 100644
> --- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
> +++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
> @@ -375,6 +375,9 @@ static void dw_hdma_v0_core_ch_config(struct dw_edma_chan *chan)
>  	SET_CH_32(dw, chan->dir, chan->id, msi_abort.msb, chan->msi.address_hi);
>  	/* config MSI data */
>  	SET_CH_32(dw, chan->dir, chan->id, msi_msgdata, chan->msi.data);
> +	/* Configure the requester function number used by outbound TLPs. */
> +	SET_CH_32(dw, chan->dir, chan->id, func_num,
> +		  FIELD_PREP(HDMA_V0_FUNC_NUM_PF_MASK, chan->func_no));
>  }
>
>  /* HDMA debugfs callbacks */
> diff --git a/drivers/dma/dw-edma/dw-hdma-v0-regs.h b/drivers/dma/dw-edma/dw-hdma-v0-regs.h
> index 7759ba9b4850..2bbcc7fabb0a 100644
> --- a/drivers/dma/dw-edma/dw-hdma-v0-regs.h
> +++ b/drivers/dma/dw-edma/dw-hdma-v0-regs.h
> @@ -24,6 +24,7 @@
>  #define HDMA_V0_CONSUMER_CYCLE_BIT		BIT(0)
>  #define HDMA_V0_DOORBELL_START			BIT(0)
>  #define HDMA_V0_CH_STATUS_MASK			GENMASK(1, 0)
> +#define HDMA_V0_FUNC_NUM_PF_MASK		GENMASK(7, 0)
>
>  struct dw_hdma_v0_ch_regs {
>  	u32 ch_en;				/* 0x0000 */
> diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
> index 3c33d12d1cdb..64044451d182 100644
> --- a/include/linux/dma/edma.h
> +++ b/include/linux/dma/edma.h
> @@ -116,6 +116,7 @@ enum dw_edma_ch_irq_mode {
>   * @db_irq:		 Virtual IRQ dedicated to interrupt emulation
>   * @db_offset:		 Offset from DMA register base
>   * @mf:			 DMA register map format
> + * @func_no:		 PCI endpoint function number used by DMA TLPs
>   * @dw:			 struct dw_edma that is filled by dw_edma_probe()
>   */
>  struct dw_edma_chip {
> @@ -141,6 +142,7 @@ struct dw_edma_chip {
>  	resource_size_t		db_offset;
>
>  	enum dw_edma_map_format	mf;
> +	u8			func_no;
>
>  	struct dw_edma		*dw;
>  	bool			cfg_non_ll;
> --
> 2.51.0
>

