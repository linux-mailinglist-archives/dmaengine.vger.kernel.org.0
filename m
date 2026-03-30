Return-Path: <dmaengine+bounces-9731-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yGiVOWKXymla+QUAu9opvQ
	(envelope-from <dmaengine+bounces-9731-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 30 Mar 2026 17:31:46 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ECF6335DE60
	for <lists+dmaengine@lfdr.de>; Mon, 30 Mar 2026 17:31:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AC4B93021C0B
	for <lists+dmaengine@lfdr.de>; Mon, 30 Mar 2026 15:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5202F33F8D4;
	Mon, 30 Mar 2026 15:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="JlIvko4R"
X-Original-To: dmaengine@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013055.outbound.protection.outlook.com [52.101.72.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97EE13446A6;
	Mon, 30 Mar 2026 15:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774884284; cv=fail; b=mTWuVIpUS6ObvhthhrHnSZsYzxY6D93Mwlz5E2HSJMNHwJ2QP18UH1BzgsYLYCxUDZ2P5pG/bPeZPf1mBWAsWJPADPjws80G/D6b30eMcF4YxQeHzBUhtGHrhuMzCDMDzE/vIyEoS1lzH5GCN4fqZCPp0lcTWAMXGD2zFBRB5DI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774884284; c=relaxed/simple;
	bh=AmPsKjj6/+KG60iyJoDkKaeisSiugIbdSfd28jGIvfE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uTjjYVTyMC97K1gK3Oi9IZCZE1c0Xt6FJ4LxTuFd0NFNE8VtrPvFtjmnCcQ2WwF8ptv6s0D2D5sz4p7KeMHgklDQ7VZHjbjj12Jg1RT8P3EUwVaage3EgudHfZqKTc7zidtKO3cXOev4VPl1KcTDVpXxvPRxMJqXxCFpNIb6LpU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=fail (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=JlIvko4R reason="signature verification failed"; arc=fail smtp.client-ip=52.101.72.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s5c7D48Evu3xNi5tC0J/MpTQBaobhljYbsoAR2fNAIGQ/kR2Agzsb86dFHxeJQ29kchDFerzsSrW6U8Ow19L+hjXzoTidgWO4vHcEbTfr0l0knsNKb82nU0lBeYyumWOxx0HtCGsvimE6nEV+tJh6WUf2adalOBZde852dY7opp1OBvPwuoGTkHedBtZ1Yg6QjR6eribCpqBlUdM0q8MOyIIbpA0m9WX3uPkJnyHem+P/qneNXsnNSNz5QlcCzyOj/DSt16STnKf/0EtWgH/yPzeZNJeOpRpLPWAUbeCcO0h9ZFfwLBZY4pYWnnKkrCx0h/GwGD3fm6E0ksFFetegQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=baP+Jk1mFn/yK8SOg38kXr4LPPbUXFr2X8CR91Ckd3E=;
 b=azPzUyFLcmgLj+V5V0ZppzFWQoOaGky+qNVuCn6IPuMiilDrwQlxSN0rNAg64DSBNPbuiLDLdisRx8CvPg49uq/cuHJzbI1Zh/Qx3PZpqf0LJfyOlSKHYo4qVKgV8lckTTxPT8qA8t9/6nuCl0/Ywz83Y+6MM0xzWSDG9YAL1NJwSqv58ZGXpAOLp/ff78I/EAmN5OOVF54zCxnyUXbdtaA03jV6H0JKG1fM6/lHB1nEwKBCUV1DXP5f2JZXGZQPMb1j4xk47tRXLPP75xnMmkXNSD/kclr9UrKMzeDjO5Psg05FulD2eakgjj5dMX7DojNTLQFPl6cC1BBqPwlTwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=baP+Jk1mFn/yK8SOg38kXr4LPPbUXFr2X8CR91Ckd3E=;
 b=JlIvko4RVQKgkpro69F60HV7vxkEws6/RqWCrk2QxW0dL5ZK2dOKkZCaxPO+rrc8/TDbsAEvoyfwKCqg6W2eRvY+JX9wT4Tk2BgNRK2BBONPetAkiyN1WCQMeJo/V/jTXUGG4QpekSjUrTyJ6V/NiKz0j0fdwReFn37P/r3AxyK4KiQ7tJSrCQiey55BQSes33EeQ2spKxpUM7UQt6aG7ztPQ4NF5Q7v374S3Adk7/DiLbfs0os8Plf85BhIQqZR8aJoh3eEesc4zPo9A8qsm3cqqRKIJQocPQ0gtWeNwCs52M3sy5BglrKzsVEMkA/IABuF3mx7jLpb4aq3O37jsg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by PR3PR04MB7273.eurprd04.prod.outlook.com (2603:10a6:102:89::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Mon, 30 Mar
 2026 15:24:40 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9745.027; Mon, 30 Mar 2026
 15:24:40 +0000
Date: Mon, 30 Mar 2026 11:24:34 -0400
From: Frank Li <Frank.li@nxp.com>
To: Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>, Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Eliza Balas <eliza.balas@analog.com>
Subject: Re: [PATCH v2 4/4] dmaengine: dma-axi-dmac: Defer freeing DMA
 descriptors
Message-ID: <acqVsvQo87NvlqU7@lizhi-Precision-Tower-5810>
References: <20260327-dma-dmac-handle-vunmap-v2-0-021f95f0e87b@analog.com>
 <20260327-dma-dmac-handle-vunmap-v2-4-021f95f0e87b@analog.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260327-dma-dmac-handle-vunmap-v2-4-021f95f0e87b@analog.com>
X-ClientProxiedBy: SA1P222CA0173.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c3::16) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|PR3PR04MB7273:EE_
X-MS-Office365-Filtering-Correlation-Id: b4aa0738-ff61-41ad-c7c0-08de8e7075e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|19092799006|366016|38350700014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	ocEb55+NsBmgw6HGOZt9XsJYMJFHxtyU+WeeXPPmzTe82yMNZudbXJCAOTSEfuJPmX1gK5VGmDT/XltrsMoPi296sVjpjwvYdeV2kVu62ihhaBsyWJUpbGWW5M4CqiU/lhkUDLJe3lS4lYTTdGfy4VYRzpKCvpflrQsxQ9h5PNFXEbK19zvy/eEU8+VP33GmRw8OMNZ/OQrG06rMtNrk9r1p0R3OuWDiaQXqDW3s6P6vHoIwgcsjrVaIJNFr/Kn/80jccbRYzsnv4xpQfKpiSOTShhpChb6YKvk7wsMyqy9ofYUH2IvX+4vlqdk4JYv2MGzoatPLZJaMRNk39yA2P8+hTlUBGi27OJn+7FZ1t9mi6YIJhb88bvRHr2/3L0LcGCpWZcCl7JqLMOuSSQuEh7Q1oRXHNA1oCIk4sDzmhs5DNx0LuWFrHb0rYNtJ6DMEHo5hfKElAIhRXues9Z8hiAfXeNOizecNT1vOvqdWDaPAueRg4A6GyUTuYrVQCQ2LIpEohNljA3HwZe0H1uoulJmyiVOb9+HU9PjYTdKFrd8WiGnEKoNUDMDXtTnRncOvEwdSnvgvWNmJ7orpiyJSgD8tCNXLatWmjTItLjsU+KRgIWtGxPkcJf1IVUsk6nGKsarh5G7udKH9N5SGWHjIRiBMxqsevLt1QMUxQEWBtbTNLccpNXm+kx5xOoBPGvC8voXErD8smg41biCsfM5FbrWtDxOiG8h7ZkD1IrBGT1naqTQ9LHGOYZxFYIs052arK6KA0UEDGwCrmaNWwszWT+d6jZZUTuIWexVEKD+Kz5A=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(19092799006)(366016)(38350700014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?hFS0DP7dyayBenTjJM2WrUT7LJWdTK4rRkgybkqupTdLZ1yaMtv1Dy7U8/?=
 =?iso-8859-1?Q?1RKbyBwjH3fNWPBU4TcaPN5lJ5IFUsNS5zNeFnqHj8j4JOEjJY4L3krld5?=
 =?iso-8859-1?Q?VXY5gCAOtJhAzuSRHEgg4sE8cEOhexYw8ARC4ALchddDfG10V7faQUzF7t?=
 =?iso-8859-1?Q?WPX244XSBooUOqVmpnPG2bi4F06hi0g5ICpFvIlfl+CgxPx5pJAhvWuYM7?=
 =?iso-8859-1?Q?WjlSdnj/uCGXxoh3I+raakC+kpxzL6OsG6p47QpLcKifcvkqQJ5/HugtBK?=
 =?iso-8859-1?Q?iNPKYhDw4BExMWEMq1mzaiV9YB0CtMFlgNwfmflWEIYqH2q5jao2GTFHoL?=
 =?iso-8859-1?Q?ZvtTxYNThg+tsOB3c5Bw6JXLpWVnV5iFXPIYmUnIymfapdZKJCnEm3qQnf?=
 =?iso-8859-1?Q?DmiVtMjWiPaT0LWUuKuQqY2Gan2Zbph6BiaHHdd1cyYOFgT+XAopyYDG6h?=
 =?iso-8859-1?Q?MoPy9wse4eLg4A0No/ru5RzawZdZuiJuxND3eSIHPrlAW0ntNuS5Ruc+nJ?=
 =?iso-8859-1?Q?Iw5WMjIh+eERuiioDt5W/wwqlZ3piaYaIPtqMFkshMiDkQfqQMxyGInFjq?=
 =?iso-8859-1?Q?EOB29OiKKCHGSdNusdwqLoDVAY6Lh5efUlBpX9x4KagVRopnUTXHGTWb1h?=
 =?iso-8859-1?Q?mxV7savryyJLff1TeTDclJM3lFb82M6RuxPS9apnTWG8RN7/31ZBRBroby?=
 =?iso-8859-1?Q?Nsw5+hxfO+NmqIMh6mrYuWL0qfFyCEuT0fW24CDEemd29LQ4c69Xannod7?=
 =?iso-8859-1?Q?geB0HQMa9kkpYPH3IpcGL+xDMRp/tdsw5hWFD28ZsSg5fu9BuNtSnCi9/9?=
 =?iso-8859-1?Q?DWkM0QQ3MyQrTa4QxSiPUkbTy8gWnaGCGgjHI+WdlmppCsGAyOfqO7NFe9?=
 =?iso-8859-1?Q?3VnvI94C7XcWQoR5eUd39bVKxtyTZrHgySOsT8JZZqPBpukjui2hRdEFHC?=
 =?iso-8859-1?Q?LIjUCPZhI0xyNZ0DtpFc8azL4W62wq7zZ6Rj512P4GLLCtw4hk/2wKbpq6?=
 =?iso-8859-1?Q?Zaz1bNTdRblq3baJUjhjQ3OrT/uCD18ltCavCiQeYtxVwXIMte667CyFSN?=
 =?iso-8859-1?Q?oYrG9a8s4f9nev7LnPhL2DthMjqlBJOkDxlywP74w45APY6zljNRWviMH6?=
 =?iso-8859-1?Q?Wzo/Sq6JDIOisqTHNFuvD/XqbEVyCu8dUE/3aTCW5EKnGYOxsRHOsmRGPd?=
 =?iso-8859-1?Q?5qqADGvmDuTE9cidlSE2lii0FmK1FvJ0Zn8CJPuEuBals3sVoEwpafGFZX?=
 =?iso-8859-1?Q?xRi5iKJyBYHFeNLKy2cvm3UkM5DzaX/5o0hRfTxq67hutQtj7T+7fOM5eD?=
 =?iso-8859-1?Q?WXpk9bEwzmxTyovjTK9LE579qs3BuOnaI08Kp2EacAiLSwb7GibKBUbtkJ?=
 =?iso-8859-1?Q?3akoYFe9ntBhGqvFH9p/rvOm+e5jK0t2XADxut11h61Lwl+5C8Oqwf4IpJ?=
 =?iso-8859-1?Q?EmbGkgBS5k5D7lABbYTr6Ri0Vyu1a9JwlGsREUvFMXwBDSi8L/K8NVgpm5?=
 =?iso-8859-1?Q?anE6Fr6iUtn7ytggm/9gWYMgpW/U1iycMYd7fGIZKvFc+QbGpWGsPGely0?=
 =?iso-8859-1?Q?LV2TEN1A5ns1wT4oNPvuAuc1cRSbLyywyg8fQvj342otieUdtlBYmnBmy3?=
 =?iso-8859-1?Q?olfdxZG5ZeEh9JWlfCYIFOyJGojQa8m5kL4MTyIzo9nVJyGiobS77D2w+X?=
 =?iso-8859-1?Q?TP0eYbgR5LyLx2a+ZsK9p3jHJFbwv8jBDwX5d7bXOo3WOiOcppgRauEMYK?=
 =?iso-8859-1?Q?2zqT7Jih3KnMoJShIKKAswSKNWjyLup4rR6BlhiqK3sibFoUdG90N/mBrf?=
 =?iso-8859-1?Q?0TI3AkAKsg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4aa0738-ff61-41ad-c7c0-08de8e7075e0
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 15:24:40.0032
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 22B7eJrMKWDC6kCvKKfnr2XqODOIO1B9o/n/UJD5wJUhUC9dROIrcSXDTou+p5f/rzx2fXznj8w77of4xHqs5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7273
X-Spamd-Result: default: False [2.14 / 15.00];
	R_DKIM_REJECT(1.00)[nxp.com:s=selector1];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9731-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[nxp.com:-];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,analog.com:email]
X-Rspamd-Queue-Id: ECF6335DE60
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 27, 2026 at 04:58:41PM +0000, Nuno Sá wrote:
> From: Eliza Balas <eliza.balas@analog.com>
>
> This IP core can be used in architectures (like Microblaze) where DMA
> descriptors are allocated with vmalloc().

strage, why use vmalloc()?

Frank

>  Hence, given that freeing the
> descriptors happen in softirq context, vunmpap() will BUG().
>
> To solve the above, we setup a work item during allocation of the
> descriptors and schedule in softirq context. Hence, the actual freeing
> happens in threaded context.
>
> Also note that to account for the possible race where the struct axi_dmac
> object is gone between scheduling the work and actually running it, we
> now save and get a reference of struct device when allocating the
> descriptor (given that's all we need in axi_dmac_free_desc()) and
> release it in axi_dmac_free_desc().
>
> Signed-off-by: Eliza Balas <eliza.balas@analog.com>
> Co-developed-by: Nuno Sá <nuno.sa@analog.com>
> Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> ---
>  drivers/dma/dma-axi-dmac.c | 50 ++++++++++++++++++++++++++++++++++------------
>  1 file changed, 37 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/dma/dma-axi-dmac.c b/drivers/dma/dma-axi-dmac.c
> index 70d3ad7e7d37..46f1ead0c7d7 100644
> --- a/drivers/dma/dma-axi-dmac.c
> +++ b/drivers/dma/dma-axi-dmac.c
> @@ -25,6 +25,7 @@
>  #include <linux/regmap.h>
>  #include <linux/slab.h>
>  #include <linux/spinlock.h>
> +#include <linux/workqueue.h>
>
>  #include <dt-bindings/dma/axi-dmac.h>
>
> @@ -133,6 +134,9 @@ struct axi_dmac_sg {
>  struct axi_dmac_desc {
>  	struct virt_dma_desc vdesc;
>  	struct axi_dmac_chan *chan;
> +	struct device *dev;
> +
> +	struct work_struct sched_work;
>
>  	bool cyclic;
>  	bool cyclic_eot;
> @@ -666,6 +670,25 @@ static void axi_dmac_issue_pending(struct dma_chan *c)
>  	spin_unlock_irqrestore(&chan->vchan.lock, flags);
>  }
>
> +static void axi_dmac_free_desc(struct axi_dmac_desc *desc)
> +{
> +	struct axi_dmac_hw_desc *hw = desc->sg[0].hw;
> +	dma_addr_t hw_phys = desc->sg[0].hw_phys;
> +
> +	dma_free_coherent(desc->dev, PAGE_ALIGN(desc->num_sgs * sizeof(*hw)),
> +			  hw, hw_phys);
> +	put_device(desc->dev);
> +	kfree(desc);
> +}
> +
> +static void axi_dmac_free_desc_schedule_work(struct work_struct *work)
> +{
> +	struct axi_dmac_desc *desc = container_of(work, struct axi_dmac_desc,
> +						  sched_work);
> +
> +	axi_dmac_free_desc(desc);
> +}
> +
>  static struct axi_dmac_desc *
>  axi_dmac_alloc_desc(struct axi_dmac_chan *chan, unsigned int num_sgs)
>  {
> @@ -681,6 +704,7 @@ axi_dmac_alloc_desc(struct axi_dmac_chan *chan, unsigned int num_sgs)
>  		return NULL;
>  	desc->num_sgs = num_sgs;
>  	desc->chan = chan;
> +	desc->dev = get_device(dmac->dma_dev.dev);
>
>  	hws = dma_alloc_coherent(dev, PAGE_ALIGN(num_sgs * sizeof(*hws)),
>  				&hw_phys, GFP_ATOMIC);
> @@ -703,21 +727,18 @@ axi_dmac_alloc_desc(struct axi_dmac_chan *chan, unsigned int num_sgs)
>  	/* The last hardware descriptor will trigger an interrupt */
>  	desc->sg[num_sgs - 1].hw->flags = AXI_DMAC_HW_FLAG_LAST | AXI_DMAC_HW_FLAG_IRQ;
>
> +	/*
> +	 * We need to setup a work item because this IP can be used on archs
> +	 * that rely on vmalloced memory for descriptors. And given that freeing
> +	 * the descriptors happens in softirq context, vunmpap() will BUG().
> +	 * Hence, setup the worker so that we can queue it and free the
> +	 * descriptor in threaded context.
> +	 */
> +	INIT_WORK(&desc->sched_work, axi_dmac_free_desc_schedule_work);
> +
>  	return desc;
>  }
>
> -static void axi_dmac_free_desc(struct axi_dmac_desc *desc)
> -{
> -	struct axi_dmac *dmac = chan_to_axi_dmac(desc->chan);
> -	struct device *dev = dmac->dma_dev.dev;
> -	struct axi_dmac_hw_desc *hw = desc->sg[0].hw;
> -	dma_addr_t hw_phys = desc->sg[0].hw_phys;
> -
> -	dma_free_coherent(dev, PAGE_ALIGN(desc->num_sgs * sizeof(*hw)),
> -			  hw, hw_phys);
> -	kfree(desc);
> -}
> -
>  static struct axi_dmac_sg *axi_dmac_fill_linear_sg(struct axi_dmac_chan *chan,
>  	enum dma_transfer_direction direction, dma_addr_t addr,
>  	unsigned int num_periods, unsigned int period_len,
> @@ -958,7 +979,10 @@ static void axi_dmac_free_chan_resources(struct dma_chan *c)
>
>  static void axi_dmac_desc_free(struct virt_dma_desc *vdesc)
>  {
> -	axi_dmac_free_desc(to_axi_dmac_desc(vdesc));
> +	struct axi_dmac_desc *desc = to_axi_dmac_desc(vdesc);
> +
> +	/* See the comment in axi_dmac_alloc_desc() for the why! */
> +	schedule_work(&desc->sched_work);
>  }
>
>  static bool axi_dmac_regmap_rdwr(struct device *dev, unsigned int reg)
>
> --
> 2.53.0
>

