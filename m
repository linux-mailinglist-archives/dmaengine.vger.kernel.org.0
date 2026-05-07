Return-Path: <dmaengine+bounces-10269-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yAv3DE3Z/GkgUgAAu9opvQ
	(envelope-from <dmaengine+bounces-10269-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 07 May 2026 20:26:21 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 82EB84ED655
	for <lists+dmaengine@lfdr.de>; Thu, 07 May 2026 20:26:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B18D5304521A
	for <lists+dmaengine@lfdr.de>; Thu,  7 May 2026 18:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86B904534A2;
	Thu,  7 May 2026 18:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="B3JTGMQr"
X-Original-To: dmaengine@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011015.outbound.protection.outlook.com [40.107.130.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2C44657E3;
	Thu,  7 May 2026 18:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778178305; cv=fail; b=DdRPgs0OJuMl+ZVefZnj28bTWmBe8dYMOvsEg+a28UUaJm8v5sdhqJGYsXbzdKzpZhjrdGlzXsgLopJD+ktMQ104JaJ1Uyx03atsnXrjt/fF5YTyC5zL/8N4uzdIUr8NKKQJRhCYDnIlRodx9Qp0INX6pXot0vOzewVJnIRa60Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778178305; c=relaxed/simple;
	bh=747bl4WEkI1toD+CiUByl1bw74BFq230Kdbn5NJc1ps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rEebSltD90zQR5Bxbu9aFzVjGrnIXA2D1vNITfhuElG25/Lc+4SGw+3P4Hz1vTapU0CSS7CYbJ0W1FrL3EIMLvre+v0hKiA11zvMgtKsa6cNWiZ2i1XKeD9p8emnFc9tT/RXt0vNABzQmZE54dmEqTHFBZzpfjISJRIf0OSbXfw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=B3JTGMQr; arc=fail smtp.client-ip=40.107.130.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FiCWh2LymZ3O94QWpc8a8g9rgApwrkDXVqDOoLkejdbszrmAaK15zzbobwPuT4GHhRydcDXZr51OlF0F+GeZAwalWDmkl5ht5/Sq1NMeMWl1/AAew6P0i8aBa0cw61slJ37aI95LxxPawUA+87Sb7333TkP39/baS3r0LlgfjGDNSc0GS032x7t91bpsJUt6taE1PpE4NlxHKjsSdCyXYEDtq1YC1yKhovOok2Z6k63eRHLzfPYVgIo8+VvHxW6A4Mt1+8ASHhSc6NSarSQd3O7CvlJZtAU9ou0x0yomE3sfTSb8O985jAQsx8Nyu9gerBZ1wKoaWiPyIWZi+D1Z3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1FSsVTChnv6HUuY7JVAV8NRct4OAuCqN7X/5DxGhzug=;
 b=PmyCybXY5qw8Cp72dH+LUQXaKxU5+NlWBIcLX0zMkQIsKiJSnmReQdP3fO+oyOLa690Md53fxyaGIRsKBSg+8IDb6HJ1BsOO0N3GBeAl1U6pFRdyEVeSUsIt6vJv6JsnCqyt/DKmLzSGrMr/hfDbqmed+EsrSsD/IoNhHk+x92yyBgmLtsl8PM4sDFr2okgeoCyYGsMOT5TeNam/2cbwwoAS51nzxzTCBDC3w0bRtQdoC/OJM1GcGgZhc0wZ3okF2rp1+4mmJyGy6P2tcqDM/go2SsuCmj9MaYTgeFPEDXtaNhk95SdtqiCuZQM8NCSVHgcwka3UgRh0dR7Cr9ddTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1FSsVTChnv6HUuY7JVAV8NRct4OAuCqN7X/5DxGhzug=;
 b=B3JTGMQrHBmNjVhJ3SVjVihuRbK3lfTnLCcKHGr8Kl0ff3W+rcMxNrj45zcsxnHEE1/nJf+gyMjZDvw+avejowOD2eUsFAMSeXOPEFdhHS0doOlXBFLVZI51/ZdJ43ts74VzRZrw9D6jl/Th0RYNQhMQ82D+o0pvwZrIeRF/TqxqyJvonSlFkv+8LsavTz7Wu6jbe1C4x08khDlofVQsnjKENOnn1Lc6AevO3YNXkoEf9YMn05Njk2KaofbzOGts3C9MrChlo6OhvrvVsi1RV6tLT2Kq+lLdDiiyhd5vLYkEOKLVn9b2KvDZ9iPtUCzvKW3dUwvXK6u824RfmcZwBg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by PA4PR04MB7823.eurprd04.prod.outlook.com (2603:10a6:102:c1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.17; Thu, 7 May
 2026 18:25:01 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%3]) with mapi id 15.20.9891.016; Thu, 7 May 2026
 18:25:00 +0000
Date: Thu, 7 May 2026 14:24:52 -0400
From: Frank Li <Frank.li@nxp.com>
To: Hongling Zeng <zenghongling@kylinos.cn>
Cc: ludovic.desroches@microchip.com, vkoul@kernel.org, Frank.Li@kernel.org,
	djbw@kernel.org, nicolas.ferre@microchip.com,
	maciej.sosnowski@intel.com, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, zhongling0719@126.com
Subject: Re: [PATCH] dma: at_hdmac: Fix IRQ leak in at_dma_probe()
Message-ID: <afzY9B9lGrfWMWUh@lizhi-Precision-Tower-5810>
References: <20260507075750.14310-1-zenghongling@kylinos.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260507075750.14310-1-zenghongling@kylinos.cn>
X-ClientProxiedBy: SJ0PR03CA0042.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::17) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|PA4PR04MB7823:EE_
X-MS-Office365-Filtering-Correlation-Id: 6158c20e-6aa5-4406-7109-08deac65f34e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|366016|7416014|52116014|376014|38350700014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	usa5Aip9hbxmzLYbmjfCrrLXNddYKRMNSWSFOVVdnLEMc22G6xg2jql0pBq8VicgARcFjwvcHvAoKF52+xA1uNp7toCTGwI5dJLNerTkJ2aozEHFNd9CQ2HHf4lzD5kTkrkzfcwrvLMhXD4fVQYm4vpibweBXGrp1vByuAUhihx/6nMBdtvgOdkSC4v0kLwW1WUHeybDfBj29U8jIK8BZ/aWEdLUOOwUjrdrJ19tfcIqkv3aPenN4AEZdNXMmPz/euaGI6wKfthK1IlQkMOGSumbl7kUpXoEO70Z2LHEzGZD32OyMKCSKgeEDfRr0K2bxuTAS7UtBVzLVMu93ETlJpSJi47QyVG56bDf3IeIWW8x5GqBLxZO2nXg0TzT2OyiW48F533K2+aDIylifl7wCrP6DlHMTO9nVlaZD5GJv3hrezZwoWuVYpgdtf1MqEEtNcKnC6ZKmGbR7ROIla8/Z4QzDPicIbI50Nsjsl7sJGDzgl4eYS2GCJne/4HDwv8GaiNYdpZmLqD7IHVFXMxwg2wyjhRwgqK8/9yjxIhG0wW9ExzweHT75QKoKCz/S0sc+f5p4bO6hPNI5orVs8piC0E6BuSZzlCJA4jOVlgvJ3Mtek5y8zjcVFQEou4QAOU0qzjALJvpJjQrpiESs5SjbQeBbqcjgcLQ3DLDwT02dviiAEeETElqGVnmpgEUboV+xof4WpgigC3LWxsEARlpu7x7YdnLZ+FWjakikLxIqBYSs1tEv5AC5XsCjPL4YkjG
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(366016)(7416014)(52116014)(376014)(38350700014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8lBUwcE4PVAg0wNt0MSbXOrrcSTswAgHS78Loo/gfZPgwfZPNGHiuRv5c7oI?=
 =?us-ascii?Q?ay5iYnUA1629LqoVWFNacU3suR6Ln71O27VKx+oL8pzYVZWCyMs6H+0sKvfh?=
 =?us-ascii?Q?7nHJT3zdyL45/cbHMtRFA22fUrO8e9GGzHwdXH6wyWNnHWhHj36eyUzsWqRD?=
 =?us-ascii?Q?y2jgF3CfkvJr06eo3OSN9i+ykOAiaW9CuhsK40hgsMaMW+sACAkpjoPxjr+p?=
 =?us-ascii?Q?s2XV/uRxBHY8wb2cw4+1Z640Liw81N5EguUEBSlOQQFRWqek7hmmvAlk3cOO?=
 =?us-ascii?Q?CqWxxV/pY6shdKC/uR0sADCFmYezphOndOGzrZulCbut5qwhEXoGtVLoiPJP?=
 =?us-ascii?Q?fMgypVsj8P7+mrwA+Z4vIMc3FObRvdmoIDr3pw0KPIOMmgf8imwrbEF+2nMs?=
 =?us-ascii?Q?TEAMxSpZSYAJaxgQ+fj8SDxY1AbrmbNwU41CAhwh5U5fdMU4nOqrxcMDAUBs?=
 =?us-ascii?Q?+rT+M097bINKDrcy4JvyY5fN/h8fsTTH0zhBFhJLk5kzHQvr4r8Akla9fnPV?=
 =?us-ascii?Q?A/9yPGeAVVNhaRVRTe7nc+Y4HOJIQuS8WxnYeT/E0KKtgOzjgUBaoF3pEB1D?=
 =?us-ascii?Q?K8/T/hFDrYF/0lfyDnE1WXQtruRr/6Olq+SVIz+Z7jIJRKQyDcOzkYfXWL/F?=
 =?us-ascii?Q?8wLjau3dFMCVcFnWPgKmZbKrM4a0eV6NFRecfKaHrTEF0CFNKe8+7by6l7kY?=
 =?us-ascii?Q?ju111XgMnCkOQ+biK+oF0jnZzin5AirPv/Q5FPnl8BydN7sA0RQvUG8gOdeb?=
 =?us-ascii?Q?GWX8TlSxtr9yBEnY9QTJie0r6oORLghszoNf38St2xYR9p5aQcc32yRCqFPd?=
 =?us-ascii?Q?G/zkUkC8J2nAMGsfzh+G/8G37kly5D1pXNtqNyveiCY/syC4l0yGrovMv4PP?=
 =?us-ascii?Q?83V9jX6BVstkUUU91GQTrCRn7YP6WqI2hl01hVM42cVD4xP/OijHepNayMeP?=
 =?us-ascii?Q?i6rE1Lw3HGZMZYeOkxD/ZWi1L93Fb3iS5EdbXV0KAE6i2gi/mx2lm4/AXlyp?=
 =?us-ascii?Q?R+PX6rGyV2bkWCnUd4gEHIwo7ILqCDjIJuncFEgnrFwkY3Ou8kNAhTOGBvTj?=
 =?us-ascii?Q?lGMRdjERviTpb1V2Gwj1wzBqTW81eIltJSAO+idQzZhonNfleMf3py9/oV7y?=
 =?us-ascii?Q?/WWVh1rY5jRBp6fMgEHiz/OvLuMdWzHJbEA8GFT9c0BXbGyJ0LJFBhEecJ+c?=
 =?us-ascii?Q?Ut4IGFoO8B1BimK7QUDlG1kW+bnF91mLhyAFhDr3qia/xBX8V4qBYgfK5LBb?=
 =?us-ascii?Q?dQAifDSKFD33xFb16S4/uMWMrpkM+3AuR+8gTtIySYiUFY+zxcYyYP+AgRG5?=
 =?us-ascii?Q?34dQMpcQB1LR2uHS5cQ8QmHRgicnV3taDokB2rZmGVLc2LKaFKWF0R+q+zO8?=
 =?us-ascii?Q?Q+R2nJD8230ylDQQ9IIi3aSuGFdp5XXaSlxAfJYB/AT4eHB3gMjbYBHuJmeq?=
 =?us-ascii?Q?Vrlhic9XZU+WE8HPjEdvIPGCYQN4smnHVekJdhm2EHef8TA3kyyjsyRNB04N?=
 =?us-ascii?Q?VUjmCh15r2hxe2w+Iw2guqd/b1O6j7wF7MO8UCvFvHKTu7U75S8De5x02YLC?=
 =?us-ascii?Q?4kRKyKbMkcbPU7bVTLEZkIoWKI0aCwO+9u/W3FZkNrNq3h8GMbz3DkErPtAu?=
 =?us-ascii?Q?uY3gqTkI2mN2odKg0UwLhvaHSVZZgnV4vjfGkgrR+mvA9L/C/C0mU9VIzqQ9?=
 =?us-ascii?Q?iquekdyTIcFndWMEgatOGTZr13cGMaiHbtCMR9PlUcniUL7zdO8Kbv+e2rnB?=
 =?us-ascii?Q?oDJVD9mX4A=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6158c20e-6aa5-4406-7109-08deac65f34e
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 18:25:00.7656
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YTpM26mrZ7GK2lEEu/Ilb4zySkfitGF7VcSPrEG2Bju+9i/R9zm3PLwHQBy/csjJgeBXTlMzcxkgA2L77pl9Jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7823
X-Rspamd-Queue-Id: 82EB84ED655
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
	FREEMAIL_CC(0.00)[microchip.com,kernel.org,intel.com,vger.kernel.org,126.com];
	TAGGED_FROM(0.00)[bounces-10269-lists,dmaengine=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,kylinos.cn:email,nxp.com:dkim]
X-Rspamd-Action: no action

On Thu, May 07, 2026 at 03:57:50PM +0800, Hongling Zeng wrote:
> When request_irq() succeeds but a later error occurs in at_dma_probe(),
> the error handling path attempts to free the IRQ by calling
> platform_get_irq() again instead of using the already stored IRQ number
> in the local variable 'irq'.
>
> Fix this by using the stored 'irq' variable directly in free_irq().
>
> Fixes: dc78baa2b90b2 ("dmaengine: Atmel HDMAC driver")

Any actual problem do you meet? suppose it should be the same as 'irq'.

of course using varible irq is correct. but this patch should belong code
cleanup, not fix.

Frank

> Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
> ---
>  drivers/dma/at_hdmac.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
> index e5b30a57c477..2a860679b9e1 100644
> --- a/drivers/dma/at_hdmac.c
> +++ b/drivers/dma/at_hdmac.c
> @@ -2109,7 +2109,7 @@ static int __init at_dma_probe(struct platform_device *pdev)
>  err_memset_pool_create:
>  	dma_pool_destroy(atdma->lli_pool);
>  err_desc_pool_create:
> -	free_irq(platform_get_irq(pdev, 0), atdma);
> +	free_irq(irq, atdma);
>  err_irq:
>  	clk_disable_unprepare(atdma->clk);
>  	return err;
> --
> 2.25.1
>

