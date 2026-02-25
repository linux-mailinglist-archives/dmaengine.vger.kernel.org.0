Return-Path: <dmaengine+bounces-9096-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iDGnDXIqn2kOZQQAu9opvQ
	(envelope-from <dmaengine+bounces-9096-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 17:59:30 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2887819B18F
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 17:59:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 289433030373
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 16:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7DCF3D9046;
	Wed, 25 Feb 2026 16:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="CxCipH9C"
X-Original-To: dmaengine@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010018.outbound.protection.outlook.com [52.101.84.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C32B3E8C66
	for <dmaengine@vger.kernel.org>; Wed, 25 Feb 2026 16:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772038679; cv=fail; b=LM6GV8/4RKCIE4HakolSxjzhWqxGzu97aAzklCaqBm8TYNANFHb3aQqvMkTqdRu6SszQW1dGTVQToyuIy8UK1enZhuVYi0wxqak02BtQvDM5Mgr2NXtKgWOvPqBSk8Ivh0dUB32r3c6U+ClizGfeJXZf9MV6TKtql2xuA1Q+1Oo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772038679; c=relaxed/simple;
	bh=vTCsoee8nbkaK8HbiylzXJ1yo24cWz1nX5T70aON9qU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XpaGUvBfXnNYzJILAeUolexUSVF0C5lYnmiBynJsPwNxUXWcacy/+k+29QYk5GWAnWyGAJWI1muIjliETKADD795TIrJC4GVj1Le9+VJNV8cJkRUx5LUJEQU5joDdHDCk+pv5Kf9aZgHPpo5VhiX+kPkdDWMOnWsBunGWOZwLfY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=fail (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=CxCipH9C reason="signature verification failed"; arc=fail smtp.client-ip=52.101.84.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yrq9Rym5dNVondJqThgRScvf6HvI6n3PPjyDcppqunPi6GhAatNaxTzBdKgvZK3rDpNwnvc3nhKPAiEASQ9qeD4l7+8PBZRiOrgTaaCyEM2vQRNJgPzusXhZndGvP8H8auNN1MkTbbBMSW7YQihfkjsp7IN4CyAWoKHxF72XGTlHGnJnp0SKgO4m65xRSB543mIZTkPscAuV3wdZsv1X7tWJFfMfHrLPUnGezkjmK4j5o74ZJ9ACwKtxMYVTeEgloCn0OTa2EK6tfWkyCK5w9Go/NMn0R8+xRc3HShHuIBSO37/f7y5h/vK+aNfGl4ojfjJVCQ5mFI/cnck87GoBKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8nQU5yHlufsD046KLALfB2vZOzLHzhEJEKwk/nEJ74=;
 b=At3OF+f2V4FAoRC6Aa27JW8k6bHhFTyCEOR0Usu0I5owZZCEPvHQiR0qG8euHZndPK70mR0csSKZQVKRG7qQZlJqlPJX3wsqbWpiWT49LzOfaiY8IuqQbnBind7mKlQ7Uz8anDVsq2FmEMrf9TotpukFdPkdExIVN6ZKZQvVF16VbeudMKDBuRNYoAVx/HFJmUiBW2C5Hf8OF8Z07iP4zqOus1KS6rIWx1E0qxnGch/j+pjTmxAkpUZc9yJYYOdspSoIt6UaZzFlVETjzIOTzQ71QT194bkcjlAvrLOUJgYM/UfoZsuklQUKcnrK2SPWx/b+ZKInivccBLFvhQBZ1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8nQU5yHlufsD046KLALfB2vZOzLHzhEJEKwk/nEJ74=;
 b=CxCipH9CLdHMmbAAvEkXXaIgRd3mKjyDCeVQkfGXnE7VnQrzq60sTxK8j6zMYIuW2pEgDfX0VFSnbxQ7J1MLA2nOTs8ObbLtfmBRUQ8rhCChB8usvkZbdziSViKWHxbhfnLu9wt+mAii7pfc03fCn8QbxwrDAUjGPmKpQsChKOYwk4RJdpioIkQPNmqkHB1735b+sQjgbXbXgYScCQgx9wkFppSH+NxosewvsJg5Lex9t5l3oWWUXMrUiNbQFwfuDW6UOg2aKYtSvBZU+cbJlFW6fbQnKCV+bVkmmCDbK/bnUNgDH5CNTIHbJzzhxnayF/YshC3eWKiyeg7m3o2i0Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by PAXPR04MB9302.eurprd04.prod.outlook.com (2603:10a6:102:2b8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.23; Wed, 25 Feb
 2026 16:57:53 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 16:57:53 +0000
Date: Wed, 25 Feb 2026 11:57:47 -0500
From: Frank Li <Frank.li@nxp.com>
To: Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Cc: dmaengine@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
	Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH 4/5] dma: dma-axi-dmac: Gracefully terminate SW cyclic
 transfers
Message-ID: <aZ8qC9oB1kw4xauR@lizhi-Precision-Tower-5810>
References: <20260127-axi-dac-cyclic-support-v1-0-b32daca4b3c7@analog.com>
 <20260127-axi-dac-cyclic-support-v1-4-b32daca4b3c7@analog.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260127-axi-dac-cyclic-support-v1-4-b32daca4b3c7@analog.com>
X-ClientProxiedBy: BY3PR05CA0053.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::28) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|PAXPR04MB9302:EE_
X-MS-Office365-Filtering-Correlation-Id: accc0092-609c-4298-e445-08de748f0460
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|19092799006|366016|1800799024|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	zT/fy9GbfWszAEt/eGPEqYR0vjX6JBjPPByRJ9q8IVf2IMpCLA/ZWc/dqNfjIexFLQqrMq4TdK8EghXGP4NbBTJ/NaN+VHsDVZJxlLSAwiaoCoTsV7gbdtDPNoeQxK6/Rc9GK1p6bB/JtD8PyO1mU86X6h3eeEOk4ho783GgSeK5DlBofHbTiCJSVQBZmEKJNB3u0H4pRcOai3Y8YqiLzhDrkfon20PF6sht+BVOs+oNRsc7xcCOAc3heoiQR5dVhI4BKujFrLA8QMosdyVzfP+dCf41aWpa4XQZEhdF7AKfVcdFE+EaiEP8HpbOex4K89v1czuEmhTo8og/BJ3PsPJaDaJl4X6EfbKzhqgsVSlduM+q/u1lP3hfYAuforewI8tvLymByixr8V0+LQSP6zfW06NHnPHr4Fp/vwo1+SMLFoWyyLnhjrUi8FW5qgm49kGuTTPM2crGsENjEA/zuw3nNL0+wAD+cNL8a/Q3ZfoEI5vmnZiz1odZ4ufgnehRkMYJZTeB0KR8Z5PuKaM61WwKVOgp9r2rzoc78OYexRCwrvtAxjFRQQ5+tcG1/HBqupcfw5hKNoEF19mWffQ2amWjJv478rhimO6GVD37nTZ/gKht7ZSUhMAQJQKWcj/eIvnHJo7NfLAK4CnED2OMJ+m3woQGEgqM1rsrThbkWLo8DMwaum9OTHX/OOSUC/lF7u6PpWRiAbiU14QeWYsmlUErCddLBAdn9+Xplcz5t1WTIGpts6RZMm3Nqqe6vG547PK6seeWCI8lMMPvv4wyPisTLmL++zRWglwgGq8vOoQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(19092799006)(366016)(1800799024)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?jaFarzZPLJ6xgehWpgTY6zmXuDia+9KNrxTaauPFwmkXSlHyKlxh+BJrEe?=
 =?iso-8859-1?Q?llH2ZQ20vtX4Q8t6vWWW6WDW2Lne3msh4Mt6Elf+LBmJO11bYB6Im7Y0R/?=
 =?iso-8859-1?Q?CLLp6DtoqnoY+qAiNPo1BwlmCwiiDRE2gn1J5b6Lfw+530iGDvyH5zOIHO?=
 =?iso-8859-1?Q?KweNT2BdyD/4d/rBpk4CswXCcrt5OuRvoDuqssP601UcI9YmF+/wvFC4n6?=
 =?iso-8859-1?Q?Cgxo+5FutB8YumXVNIxoG8ZtQzSX77N+S1O0am4Fi4HTTz58vcx0kn4PoH?=
 =?iso-8859-1?Q?Qd1tzRHCxZW1xbbKRvGKpiOEZNsGDbqy49yZg2CP8CGetXsTLSAMtOERtX?=
 =?iso-8859-1?Q?OP7HDTUnXN9HgNTg+p5ppu36gqOZ2sh/bImj2jRBYcqzK2kktlfB63cJw9?=
 =?iso-8859-1?Q?4+WWGO/hZnx+7f0yGvPtz6ut/rEranP2HyzOpU9EL4ju7zdsjL+c+LcHQr?=
 =?iso-8859-1?Q?Zi9jrGLd8uvNkccP/mIY2Or6ZhjtVOa1rEbAoRfz1n0DZMycIV8f+cx514?=
 =?iso-8859-1?Q?k3judAyFCSpb8Be7A/GWDJaAb8knuDh3wLsUwyD5uNirJNBUfsPbNsC5xm?=
 =?iso-8859-1?Q?bJCThkZkE7H3jZTp5BAanuBfK8sH68rOwpZcpRmnkVbnSMXvHWoUDge4A5?=
 =?iso-8859-1?Q?xEiACzhVadyaS3I9t7qXi4pdOVDxIqx8b+Rf0+kdUpW+TdFtmyycEYh8HC?=
 =?iso-8859-1?Q?mvGGOQGW1ySySSy8A6AAqPVKPVUFvBI7GPIRcJ3OBR1E2ak5uhS1ca+KZc?=
 =?iso-8859-1?Q?3bYN9l3PSeD/OqWtYy1j3QkPHWYKzxbOIt+3b4xj1PWXwpN9o0lvDGECKu?=
 =?iso-8859-1?Q?ttLw3di2H8v2FNTMl0l1LF0waKgUigAY5v5wu+vvebSuNhFW0JTzjCVu5e?=
 =?iso-8859-1?Q?wtBfoQD1Exr5KCL2V+e+KgnGOCt1wmCWnGFjn+0CzGnoM3gDE9STknzGGI?=
 =?iso-8859-1?Q?I9VWcbZo2AGMu1rA+YBkmNlV/bWGW+FpotZRxbUepT7vYFfKFQ5/WM/8Tq?=
 =?iso-8859-1?Q?OBzl2lzHZJ3gLQl/sUG2IhEsuMDBeq7dQXFPrt8Sv6Ei7EjpjHbLuNQUT2?=
 =?iso-8859-1?Q?isTXkje/qSILhjzLuJLlAGR6Ujmd9xRPwmc/5F/98yExurVtbGhKfOPgd5?=
 =?iso-8859-1?Q?ST7YmOQFw+LLD7tokcihR1PKFzW+wNv37e3E60wy4r/wk6DddzO0mlHM+e?=
 =?iso-8859-1?Q?3uPZOQolp/d89vpwS99wWz7Q8gJJwJY+0EofliZpb9Wdb4E6ioJl9uWS/f?=
 =?iso-8859-1?Q?rUQHxBkQ4INN0uhgTyD5BjQTVE7lN8jtH8saOOUZz4qehmObNdrHDIJD7u?=
 =?iso-8859-1?Q?qVudo2I6XBAXx82XG8m2RxS7E3SbKSzb4go+ZjnoZOVZu9DB3N2cnTa4D3?=
 =?iso-8859-1?Q?uv2I5l3Y656bR7842H0ofp7IToySgLRgA0dllQ2muvIwDXmSsg1IlE7tJh?=
 =?iso-8859-1?Q?aYnrKZEnGNe9h4hDpfXoRnONjwCe+FR77PJmZNJwNMuW6d6OtI0ZnXEEB+?=
 =?iso-8859-1?Q?loo1EH3raGLs43wlefv9sYt629AVNUBiFMdGSTna3HMIkZ9W7tOdyDJcvN?=
 =?iso-8859-1?Q?tr/YDaZu/D6fetMZj7MFIRG9v8RnebRzxzOI9kPwD+2L7Iuk08etbZtkBy?=
 =?iso-8859-1?Q?MSRjc0zJadqtnqsCOCuz8mtFisKcscY0T7439Y14KlizrjG5N1orOMgXjz?=
 =?iso-8859-1?Q?IKBrof3FnMTGcKdZfAQJ54omIYpZTeJFlynAoASnuXdmpy3JN0M6SZBsR7?=
 =?iso-8859-1?Q?t/VRzUd+jCeg0C5REmPoX2ZbGpqVOz3+Mq2z3OawvEvxnK?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: accc0092-609c-4298-e445-08de748f0460
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 16:57:53.7415
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NZXaq3RFMl3ujJk33MqKbaI5c//w7DbXYURi2tLz+FXi2Vyv0Cm0AM3HkceXUerO9gx90p58KN0ubqv1eA9mOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9302
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.14 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_REJECT(1.00)[nxp.com:s=selector1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9096-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[nxp.com:-];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,analog.com:email]
X-Rspamd-Queue-Id: 2887819B18F
X-Rspamd-Action: no action

On Tue, Jan 27, 2026 at 02:28:25PM +0000, Nuno Sá wrote:
> As of now, to terminate a cyclic transfer, one pretty much needs to use
> brute force and terminate all transfers with .device_terminate_all().
> With this change, when a cyclic transfer terminates we look and see if
> we have any pending transfer with the DMA_PREP_LOAD_EOT flag set. If
> we do, we terminate the cyclic transfer and prepare to start the next
> one. If we don't see the flag we'll ignore that transfer.

Can you rephrase it to avoid use "we".

for example,

Ignore that transfer if flag not set.

Frank

>
> Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> ---
>  drivers/dma/dma-axi-dmac.c | 34 +++++++++++++++++++++++++++++++++-
>  1 file changed, 33 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/dma/dma-axi-dmac.c b/drivers/dma/dma-axi-dmac.c
> index 3984236717a6..638625647152 100644
> --- a/drivers/dma/dma-axi-dmac.c
> +++ b/drivers/dma/dma-axi-dmac.c
> @@ -233,6 +233,11 @@ static struct axi_dmac_desc *axi_dmac_get_next_desc(struct axi_dmac *dmac,
>  	struct virt_dma_desc *vdesc;
>  	struct axi_dmac_desc *desc;
>
> +	/*
> +	 * It means a SW cyclic transfer is in place so we should just return
> +	 * the same descriptor. SW cyclic transfer termination is handled
> +	 * in axi_dmac_transfer_done().
> +	 */
>  	if (chan->next_desc)
>  		return chan->next_desc;
>
> @@ -411,6 +416,32 @@ static void axi_dmac_compute_residue(struct axi_dmac_chan *chan,
>  	}
>  }
>
> +static bool axi_dmac_handle_cyclic_eot(struct axi_dmac_chan *chan,
> +				       struct axi_dmac_desc *active)
> +{
> +	struct device *dev = chan_to_axi_dmac(chan)->dma_dev.dev;
> +	struct virt_dma_desc *vdesc;
> +
> +	/* wrap around */
> +	active->num_completed = 0;
> +
> +	vdesc = vchan_next_desc(&chan->vchan);
> +	if (!vdesc)
> +		return false;
> +	if (!(vdesc->tx.flags & DMA_PREP_LOAD_EOT)) {
> +		dev_warn(dev, "Discarding non EOT transfer after cyclic\n");
> +		list_del(&vdesc->node);
> +		return false;
> +	}
> +
> +	/* then let's end the cyclic transfer */
> +	chan->next_desc = NULL;
> +	list_del(&active->vdesc.node);
> +	vchan_cookie_complete(&active->vdesc);
> +
> +	return true;
> +}
> +
>  static bool axi_dmac_transfer_done(struct axi_dmac_chan *chan,
>  	unsigned int completed_transfers)
>  {
> @@ -458,7 +489,8 @@ static bool axi_dmac_transfer_done(struct axi_dmac_chan *chan,
>  			if (active->num_completed == active->num_sgs ||
>  			    sg->partial_len) {
>  				if (active->cyclic) {
> -					active->num_completed = 0; /* wrap around */
> +					/* keep start_next as is, if already true... */
> +					start_next |= axi_dmac_handle_cyclic_eot(chan, active);
>  				} else {
>  					list_del(&active->vdesc.node);
>  					vchan_cookie_complete(&active->vdesc);
>
> --
> 2.52.0
>

