Return-Path: <dmaengine+bounces-9094-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yGPtJ3cpn2kOZQQAu9opvQ
	(envelope-from <dmaengine+bounces-9094-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 17:55:19 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D3919B080
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 17:55:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C2CF7301F787
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 16:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 119743D3481;
	Wed, 25 Feb 2026 16:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="W/0z+foZ"
X-Original-To: dmaengine@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012022.outbound.protection.outlook.com [52.101.66.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9C838F93A
	for <dmaengine@vger.kernel.org>; Wed, 25 Feb 2026 16:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772038326; cv=fail; b=R4XHIe0bXaRb3pkQT8MxLMbmayUB8aUzzRExSq1cZ6oDBftvFJrRYpwtcWViH269L4xsUbE2T6NK8nS6uZIfa9Hup5KNHhZAxb/bLJQCpeTP1Xc5i8M0NXodEXUoyes4uA+O3lPsrGZLB1ymGOe3IzqoaTKRhVH9NDo7D1RgNL0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772038326; c=relaxed/simple;
	bh=+97s/DQvyutpRJyFQI1V8XzIyWZYLuijkD6XR5shgq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=S7H6MCn1OtqIZojWimmI9P19MAc/iaTwGM+Da/cbMAFLq1u7KebqJxxIuN+IeZ7h7CBD69DsRVF2xQ0tghpy3ELiRvT7FmlVZgis1b0mEPndBVlONxyEoiPTC3pghh2mpAmBUbOjQaxkMYB5uoH1dSPmwkCVkJydpY2SVUwkFWc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=fail (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=W/0z+foZ reason="signature verification failed"; arc=fail smtp.client-ip=52.101.66.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nmFti3XVTnoVvib/uADZJOa70a3r3Dd7j6GLE7r29HdJaCBeyHsetkVhJk3xdIUY6J7ayatkYGSVQA78dJMYVjJsFL5ylAesA+OFSS4sQLAA8RnhtwLVdPNgB0mVd1xwninMoWcoFCqGMC//FQEkgZtNQExe2GKVHY+yY8tcf4CwDo1t5L+dyoqpDpb7D4rYDoYm4OuwOWrhkfKTLN8wNcYvr78uxTCpgLdYWdx7oFOeURzDTu0uZwRIr4rsAfzvUqBE02nYoUrhWyD2Yy4cq0nsqQWYCgl3uzw+PfJbzxeMG0CsQg5MwumGfkozBX5qW73RsfFfEtiLNwjAVZ1JYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ph8oUVZmOg8IphtIYpIJEB23+0tYEA8JaB0RtwzmfWw=;
 b=FvM7oyXs+A2Q2xI0+XmXKSHaQN6qdgNwBGsg5d1JboGBJnPMJ9KqeoQWDqGpHZJ7lfAv5Q9bTUVGY2qhRm4JKhwsxVFNw23XJ3V94j3CAd00mrHP5/3aaREAVVBQFx4HNgSlnlVYw/vWXXZIGnxP63JSgN5nNjP2miNXvvtQML4f1mDlZl3lm+iKSOIemPXpFGRfHR/2PoY8FAsqQtd1x/GtCFidtDOx0g8aRb/9wRLZx/h/9A6gL0uJtESsygdUeLsaQDeudgJ4RuoA63SNURaOhH/r/MWBQjVSt4rZRGOq7L3cwD58Otp8YJz1ruNkrUVusPZt7bIYOcnL0Id+Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ph8oUVZmOg8IphtIYpIJEB23+0tYEA8JaB0RtwzmfWw=;
 b=W/0z+foZM3SvZkOqBcGAdioi8eUjHuatQs1FLZ9fLmw0sbQvjWtMEjEDOSwPXHWOtRU/XKK+/GJk3AIYJv8WmSZUPnmunKejwPKCMTWj2QFjDOrx2oahW4A+MM50x3eFkSJAAywJCthKumMu5ovT2DMtnkxQkLk+s4xdO8xKTiWD71Kk+XLlEJacgfFUWKmxwrfBYyeqJyb8S1EpozhP0qHDJGGnqwKp9PM4J8hIb8SgeSWwCZ/eZom1l5dVBx9NRjhtZk5aRS+hrsPlF1mPLNCorh8X0gHUWttSsGfDRIuASHnisWLV7suM6aBIFX/LSCBQzXfxYkAqfuwgxlAntw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by DB9PR04MB9961.eurprd04.prod.outlook.com (2603:10a6:10:4ee::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.23; Wed, 25 Feb
 2026 16:52:02 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 16:52:01 +0000
Date: Wed, 25 Feb 2026 11:51:55 -0500
From: Frank Li <Frank.li@nxp.com>
To: Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Cc: dmaengine@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
	Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH 2/5] dma: dma-axi-dmac: add cyclic transfers in
 .device_prep_peripheral_dma_vec()
Message-ID: <aZ8oqyIYsB4HL_sk@lizhi-Precision-Tower-5810>
References: <20260127-axi-dac-cyclic-support-v1-0-b32daca4b3c7@analog.com>
 <20260127-axi-dac-cyclic-support-v1-2-b32daca4b3c7@analog.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260127-axi-dac-cyclic-support-v1-2-b32daca4b3c7@analog.com>
X-ClientProxiedBy: SJ0P220CA0022.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::33) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|DB9PR04MB9961:EE_
X-MS-Office365-Filtering-Correlation-Id: 5986b29e-389d-48af-2978-08de748e3292
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|19092799006|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	7/Jkt7DlFZw33Wujnq6hsIdL0npHVxMLqYU69bzHr9BAFTlfLzXnG/oUpm1e18F6xaqLxcawYtZfAKVieGwv93l27bLv3tBrIITULVaCRw8I5ROKNNBwnf4rg+DzTNRTHk7kIJDYkGyRzLsCdnDmC0Q8iZLce1OC8R0CjFmfuHLja8ppaaE2N/Dl+8oyelFKRqRmehLt3j8HscAo3gwLojbYIx31rOMnGnzDIKHB5hf4NQDIYTzOrsxD31Uvt47RhhT16rB0ScG9osjI/lJKlMYb1k605dFB89IKl4ac/lTs88i5UwbkDsFy0Y7vcark7ddP69Ddntvt4pNH1T4Wk4MPSphso0/0mt0xpewRjyWPDwwiJdonAGWuhzqNVIv9aCq6SY9o1i9/zf+bUXSy7dT5FmQhcdUfJhXkbb8xzXwn3XWp1ld4ObAl4/7XPbj7ITMHnQbYuU3LFuqG0mF5ntCqwbBtvf4z1IStgfyC2fZjteCedn5CEbKrR71nOBjVMXanPN3J8qz5x0g6ZqTpziSegRk4Pl+eRd/M2ENm/70JDi64Ea1Ya6BArjj2PLy2IWJAXtjQIhLupyNj2zIgpKP4y9/N0U//7UzhWtUGi6VmHeNh2asjPRQkMB4C9my+ax3nbBPmQSZEk4Il8X2tTD3mw1TiK2ZSNZNuf2BZ/UyO3ADWLm+gl8Yc7hayR6UOIkh3P1wYevG/gfZdpy70ZgW9pTuu88AXkoe7dPhwD+9Vn6icvqZqn9Ih5FrYcrE/W6WBPqoFXnLDKK99zvdhDbPOuVn+j1xAg0/68xKdOdk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(19092799006)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?fZ1lLZbGudTjgi1JheUnVbOc8lvvZPwDerbTtucmhDzTNv8Bj/RfdoJW27?=
 =?iso-8859-1?Q?wOiQe0wXBY4evQ4KPDaa2hn92srcxXaYrXvbh+eRpLW8VlxjjY1BDkDcmY?=
 =?iso-8859-1?Q?LqD9upndwq2qcvAD84o28cNlCs+zA+QmaDxTilIuyL/JKwu9bQMuDucoL5?=
 =?iso-8859-1?Q?y873xrgcqW/EWvOsHoag3zrZyZJrOiLdCekIYeI3m9x8MQdqUxyF9GLJuy?=
 =?iso-8859-1?Q?KEE4woRpgTIvozJh0xc0dg1w+Xbdxko15RRMhootaSYjU2wJDdthWw+MeD?=
 =?iso-8859-1?Q?Aj5O/FDxky58uPrBggjmAs1KFgkJHB02z1dnjeFCT+GR6+Lu0FMsgX6xnS?=
 =?iso-8859-1?Q?Bq/UuSvxDO//HDf2iJc0npY3oqLuGk6Q8Sar4mKG0SIEspmGdVv3lRRqPW?=
 =?iso-8859-1?Q?UWEi2TWBII9oPA9MJj3l0cC8fDrZubUMS7TgIxndFHDw79FCXr4dqIJDaC?=
 =?iso-8859-1?Q?Nz/daW75veOYoBhuwj1kKf3bvbYaArs76hRK0u4TaBd95tpLHm2YPXDfFS?=
 =?iso-8859-1?Q?G+z1CVEJWB0ju8lkzRyOXPOK6DqgOZU4xD3Mi/jJ2dkGSk2f2Ly41geKhy?=
 =?iso-8859-1?Q?z3cxK+8UbWWUwVzZWjLifg2on+T1AhZzQ1h9hCr3/hAXvRpijRHg0NMuAE?=
 =?iso-8859-1?Q?nBrYhKN0irRI+dMBcrbZRz8RzoII4c1rt6BI0KmNUz/uxGgNlLjGJmXP+2?=
 =?iso-8859-1?Q?+xXBg5jwwWelRj87U5RgzBndUocYKWYVxaZ+dQQgyRQGg8jiprmDrBFeS3?=
 =?iso-8859-1?Q?PmPtKsTo6z51jv8CEiIcPpTG1XFPDtiQV5pyfKXoYwb2ZAt5g45SX96uwY?=
 =?iso-8859-1?Q?ML2CWC40kVX3thK8P2mYqsaT+3XirngarQHzUSIL19tR46X6LZv0j0Svoa?=
 =?iso-8859-1?Q?O8LY1ucQ5IFHm6nj/7msOnKs6FwlDjLk3knA4c7WKkeMxLDKj9+F0krxz6?=
 =?iso-8859-1?Q?7d9OCTkRO8mC9o5HMTOHe7OlQJIO4JJgnNTxC2yurJxiGK8t+uS1oMMvzV?=
 =?iso-8859-1?Q?t9LPYUbpunff7DJOe0lA/X4cuIMCY7kAtlOIBijNGsQwx4Ho6HVncezWiO?=
 =?iso-8859-1?Q?b0ZVMyWBdl2WLnjSTJfDyN0K6fFaUtbsEI33efSq7v1QWKra7CxwhkcqEd?=
 =?iso-8859-1?Q?B0MkF71s8YrJ74HAx/gs5xicuJuEAR9yJtaVoih8RPQng5rPqAirDCweXt?=
 =?iso-8859-1?Q?jm6AqglIBI4eRAuDPgrEEyu1Qv6xaWV2zqNra5sURNvAdRwrxMIBTLGbXL?=
 =?iso-8859-1?Q?XcGTjWJdtE0e9x4CeE/KWyvmqljFoFECUbhA2BEtBK+dWKCMnErlQ9H8v9?=
 =?iso-8859-1?Q?KDpro6m//XVvUFD8/8bG8Y9gBU+DjdDrNRkSVerK0KcNFtr+OXjkEWecIJ?=
 =?iso-8859-1?Q?BD0Ji1q2oSBroOamyZkNHmyKuyNzDLk4AE52IwknddWo8GyV7y6ZqpZxY+?=
 =?iso-8859-1?Q?yQI5pabTr3C7xq3gKBYlqnXdP8AUeBvNKYBk8KLH6EvC8zrszmrGgFc4Il?=
 =?iso-8859-1?Q?Ts8z+pesTs9QgoxrupgUG/b7LLbwh3D490OxuuOKNV2hgtLPTE+TTfgs4F?=
 =?iso-8859-1?Q?+rE8dM2a0IJAB5HEQ0vKQ0kb55O6RG/ak3zSXIHbax1+2fLuxPcVgluHVQ?=
 =?iso-8859-1?Q?fP5ns00qPjkf2JP6qCq7w4PXYecl0h29LS3usj0Kyn807LO7Mpr1mbLaLU?=
 =?iso-8859-1?Q?ArQEZHrhsNvViVEKvgsqs+Q7TNZaZrD8xvRp0s1axktkToB/GLLII0u7Jq?=
 =?iso-8859-1?Q?L5FmfjtcixPJ1KHvQQlW+sczi0n2hiGaWjaq6ECIhYoPgz?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5986b29e-389d-48af-2978-08de748e3292
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 16:52:01.9093
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +ddZsZ4EW55iTsBffxqD3vsw+fTzsk/2SzfemEQDb5sr3dUV8km5QPdRS/vLJrlVwig4txJuv969GYOHVKh6WQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9961
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.14 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_REJECT(1.00)[nxp.com:s=selector1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9094-lists,dmaengine=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,analog.com:email,nxp.com:email]
X-Rspamd-Queue-Id: 16D3919B080
X-Rspamd-Action: no action

On Tue, Jan 27, 2026 at 02:28:23PM +0000, Nuno Sá wrote:
> Add support for cyclic transfers by checking the DMA_PREP_REPEAT
> flag. If we do see it, close the loop and clear the flag for the last
> segment (the same as we do for .device_prep_dma_cyclic().
>
> Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> ---
Reviewed-by: Frank Li <Frank.Li@nxp.com>
>  drivers/dma/dma-axi-dmac.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/dma/dma-axi-dmac.c b/drivers/dma/dma-axi-dmac.c
> index f5caf75dc0e7..b083b6176593 100644
> --- a/drivers/dma/dma-axi-dmac.c
> +++ b/drivers/dma/dma-axi-dmac.c
> @@ -657,7 +657,12 @@ axi_dmac_prep_peripheral_dma_vec(struct dma_chan *c, const struct dma_vec *vecs,
>  					      vecs[i].len, dsg);
>  	}
>
> -	desc->cyclic = false;
> +	desc->cyclic = flags & DMA_PREP_REPEAT;
> +	if (desc->cyclic) {
> +		/* Chain the last descriptor to the first, and remove its "last" flag */
> +		desc->sg[num_sgs - 1].hw->flags &= ~AXI_DMAC_HW_FLAG_LAST;
> +		desc->sg[num_sgs - 1].hw->next_sg_addr = desc->sg[0].hw_phys;
> +	}
>
>  	return vchan_tx_prep(&chan->vchan, &desc->vdesc, flags);
>  }
>
> --
> 2.52.0
>

