Return-Path: <dmaengine+bounces-11713-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tRSnMmC8OGrQhAcAu9opvQ
	(envelope-from <dmaengine+bounces-11713-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jun 2026 06:38:56 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E85DF6AC8BE
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jun 2026 06:38:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=fail ("body hash did not verify") header.d=valinux.co.jp header.s=selector1 header.b=B4xOmcMP;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11713-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11713-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed)" header.from=valinux.co.jp (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7FF7A30087BD
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jun 2026 04:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D89CA346ACD;
	Mon, 22 Jun 2026 04:38:53 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021094.outbound.protection.outlook.com [40.107.74.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B54B3502A9
	for <dmaengine@vger.kernel.org>; Mon, 22 Jun 2026 04:38:51 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782103133; cv=fail; b=Jmk9LywfC8/AeR8ATy2rmvzNMdn5wTNIBH3W0j4K4DOWx1T9ameWOYQ/7XGwcUlEYHc4l5OAdrDvM7ZBjb9OR2oN3PAKkBQ/cmrMucmLYGI5pZQJRfFymFy/xY1alyJ06gkbGf8dXmui+F7bxp2mK6KPGd/ETTJVm5DS9lnmdUE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782103133; c=relaxed/simple;
	bh=cz1vLWgCc6xtt95xeKs/cKXWSqruG0rDYlwad7w9gpY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=L7J7mIEujW6Wth/PyJE7XHOB0a8KremKz4zE1j3O77juVLi5oxrW9Le76mSzxJ7773aqa5TevSeS3uX6MOb7KU4XSBnwFWlMP0bhDmu6Z1NUlVFftl3S+feyeh31WNvJrKbV2ag5gnhJmPrYrjO/zqsCXfIRcmm3ZTitQjf1/8U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=fail (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=B4xOmcMP reason="signature verification failed"; arc=fail smtp.client-ip=40.107.74.94
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QqRUxiwo+pYji3HS4VdAWleAIVcOP61rTZhM8n1v77561ZaAyUcKTwkTO4zG+KuR/mqCcsunwHCaon8NSoY/tdnRk6zQf0H2+yTQlHPaIdD046/HymyxzK/0rEaKbezsX2Y1N+Qj5ZHQkctEQswO9dCEg9oqG/hWSAXK7q0drkJ8RCnNjEmyjVEahSQS9g1VyYMf1TBour6m4CBVV05Y8ImISnyzuOSIByyVqLHJ8wl/8b1a/DfsWTJb/Htzj8Nx0RDB0VbHSL1amhWj+G9a36MLnOXwvVWox1Y4qHViHGKjj6OA0JDvuO6LNZLaGWZHLFK/dWn+Eb7kbIsYc2dqFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pB4jAgHL3V7zjAQvkdCmGdqvc+5ep3fkv0bMxxvZPXc=;
 b=wLeHJYPtrXeQ9bqlBBym/K3peBYbSLJX5iT33oMG5aqOZfuGGdfre3McsWlzMM86F7rY7uci4bmpVLd0Hn4POEZEeNc/ov9AVUVxq5/on/0Dd06tEmo1OeRksaUCyhskfg+sRg7YtnwQJ6M1ukAyuaY6FYCfRgsGwgtN17G024AZTg1anexMlADc5M1eGwaN5HPSbsmirNTlRDaWFErdx57rm9OpG34jdQE5dif/fVOIAmJuB0Ktse6UMrv4YJuTaGtwdj9hmTrbL2x7emXsndrCHDclsXK2aHkHCvoBi2sLFgL4g+aT3vf4xhtZTXrGwkzBHM/ifvUDEzg77+19BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pB4jAgHL3V7zjAQvkdCmGdqvc+5ep3fkv0bMxxvZPXc=;
 b=B4xOmcMPPIPfBCbyWWbM5LqoOQhj+bDIXlaIbXNbafhfmexZNwkC5nOdulbKoTWywpOM5zHsNw44ML+y7YCA4/23cHCLjCTcl3MWNCYM/PIusRNsee+ZEMhWrEatlv5nFUV17WJnMS3KTR829q8P7oFjm9O2xOEKO6ZlICisVew=
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYYP286MB5552.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:1a1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.12; Mon, 22 Jun
 2026 04:38:48 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.21.0139.018; Mon, 22 Jun 2026
 04:38:48 +0000
Date: Mon, 22 Jun 2026 13:38:46 +0900
From: Koichiro Den <den@valinux.co.jp>
To: sashiko-reviews@lists.linux.dev
Cc: Frank.Li@kernel.org, dmaengine@vger.kernel.org, vkoul@kernel.org
Subject: Re: [PATCH v3 03/13] dmaengine: dw-edma: Add delegated channel
 request helpers
Message-ID: <ggvbjazdnbmzh3rucbrumxd6avqk5vrxnttjwy7ldjivf42ky2@3i4cmgdejqks>
References: <20260620170040.3756043-1-den@valinux.co.jp>
 <20260620170040.3756043-4-den@valinux.co.jp>
 <20260620172539.DD20E1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260620172539.DD20E1F000E9@smtp.kernel.org>
X-ClientProxiedBy: TYCP286CA0045.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29d::19) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYYP286MB5552:EE_
X-MS-Office365-Filtering-Correlation-Id: dec3d8d7-76ea-4eda-c711-08ded01826b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|10070799003|366016|23010399003|1800799024|13003099007|18002099003|22082099003|5023799004|4143699003|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info:
	2cgh2nHr3MjXp5kWg6o1QhfjZh6ssloJir8IA0/sfAad43WWgnUjgP/pU1CdmvgfsbdnEk+z0ksarkTmIEPrvXxxSyuP4iMOMP0B58pnLKcDMWlcxkBhGt6wtVKHYg9+M9/fwoBBzQqZIAlwuycekdtmHtjKQYoqy/lgWiKVpz+wjsat7FT6fzS4fKXVgkHdb19BA/sCNw2jlE89Ffn8fp2xRgsJlpWN0HZeht4VYDt05T5o9G9XH7dN/+MCLs9SqHsPB+EJBNuCG/A993Wu6IpnCubk3nYn9PR3k3IxerFFUlEmbA2Uf0vLiC0Ae0raVB/m3NRePy+Yy/nO/XqqfmsDXTn9Ri02F1Vx8i1gBH77brcThys1I1jhv+80ZPILlwIVyZ1Sg+d1MFMolBeXGL4CKQfPvBoLX2yyOUcYpbRm2oUmtr7Ji3qVw2NimeOq6ewRPlS6UMCLEG61lr1fJR32cXKGYgFrZK5kaS6zGFi+ss+B0adiAOvhqCvOFl/fYVpUQMMOhN0EhNZMqhQKsQaP2CxSTY+Yh/DRvLEQI9cP3XvDtoVvu1j3Ur6xBtvw9j9REA78d64HIbO3h/R0+7oY3jbSU1fVZ4Chir2AHfA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(366016)(23010399003)(1800799024)(13003099007)(18002099003)(22082099003)(5023799004)(4143699003)(6133799003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?6D0nz+bNLVF2buTmgzlySYTfY4gSPZyEPuRSWhuw7LUCjRAmojb23PfJue?=
 =?iso-8859-1?Q?ejmze9nlgJONKZqaONCOXoTKuYyo3Da3+xbH+K4mXFV7PVLdenthPZR9Ib?=
 =?iso-8859-1?Q?2KoqsoYtl4dzSiZaX4yrxRf6qUyk8fc65nnvJKqpbVmIgF/v0PD12cQ+gn?=
 =?iso-8859-1?Q?A9sbo+fUI7SB2t5pF7LDD3OZaTz8UuHob2GgxIfb3JKYvzAmsk3ZHnnUkv?=
 =?iso-8859-1?Q?ezqUzhfyuhDEOFUpz1DeI6cVpbu6x5+ufHoq+BsSL+QDHEjlR58NjFWcyh?=
 =?iso-8859-1?Q?da+nmdxxNYX0rVYnxEot4eAswvv2G+njdQITp3GklcsoXl3Nmwxiop9GPQ?=
 =?iso-8859-1?Q?wcNAc5RYy1NqdjBM/ONNUcRo5THouv/C7hQHFgmm82NhUyNX1NZROBAySw?=
 =?iso-8859-1?Q?Tuhm4kD3QVN8yqzpfeHTo2gWb+B4zlcNrI65hL8aTy93zBSIQH5uNHQCZr?=
 =?iso-8859-1?Q?CYv4RyffIzWW0Q4AP8GKBZaJUgkuXlMkUFUYoz9cYPC2FaDHFQtJU9O7ya?=
 =?iso-8859-1?Q?X1MoZoxGVI+kH0IocLpvzjX+OfHgFLRRUxwFwu78K1nJHNmLu62AzI4HMt?=
 =?iso-8859-1?Q?pOgloBAvoigwi37XNnoSpiq49dVXNNQ6LobaLBbdX1EmbqYUw1MU53Y9jZ?=
 =?iso-8859-1?Q?n2nRZc/u4JOcXw6R51ZtMIAriF+1Yjw2Pvb2DChzIG/ehsGTy92nuDyjUE?=
 =?iso-8859-1?Q?EvU35XjKIE6joIcENkT7OendnSFaim1i2dj7vx1mgMBKgw2eVIviMVaF/V?=
 =?iso-8859-1?Q?ZHvPYhRVhBAtn4gyt0BBbsCyXMjS0WOJJL9xc4RK8ag5sqDtE6CRMh9m/N?=
 =?iso-8859-1?Q?Jxp1jD9dqhqEED5HhHbs5tr3cMfByBrwv10DdXwmEJ0e0eila7SDyfp7IH?=
 =?iso-8859-1?Q?VSbqYqdTPZ0HEVefjgZQshI6ih5leL6ekw/5dj0/cPasyBHmWvfBpe4JGH?=
 =?iso-8859-1?Q?dLbXJI+anlEpa0IKePMFVnAc/oP3UP1U3HsLrzhtABpLvKrolFHA/Et92w?=
 =?iso-8859-1?Q?Eh1kP4CRhz7qO/Sya+I0NBdNObj1PlGZZh9tXoUxWLjWfJgT6epKr9CYTB?=
 =?iso-8859-1?Q?4wdWZAhzJxYsIigGGDgSVVI+4X7kLiVpC3pbX0u0Q0jVY5F3zDFxfvV1Ej?=
 =?iso-8859-1?Q?O+AdXao+4LbrYYYGYbgRODhGCSlIiL9okGHm+Xhh+scFn9fzXUjZbPVu8R?=
 =?iso-8859-1?Q?08o/dxTZ9Ajnbgy32SCAoLs7BB0uwtSTMRueZTw4tMsaKrFsNz566EunFA?=
 =?iso-8859-1?Q?v/9tNndUZgGYVxbEhllkppQlw12Bh/6uKdP0lRSxq77ToM7w8JrfcSDYke?=
 =?iso-8859-1?Q?tXOt6BW9sXN0mzl0WwZENXp0rmYhcfg/zSUaYO7HBtpkd65srp/iFjoh0/?=
 =?iso-8859-1?Q?0omgxwBgMn4XIrSGXWXfk3SgdzU6P5ZlzuuMxlrxS4ViNEtnBbLjl3BTFt?=
 =?iso-8859-1?Q?2ZpISVK3cbSoK1cXSVGEiuB3xrAW0MLF8zAG/qbdKa4wZS947OMN4to/HD?=
 =?iso-8859-1?Q?Y91b7LQgQ1iUUmqAxnnIJFYc1xbD8Ds0oWMar8vbTP7WNrcY6tKP+/KWep?=
 =?iso-8859-1?Q?4g/7RJXdYYamZHfLAmJgohJkubwCrkw0jx2dyJogFNAOEHVU9IOL0hZOyT?=
 =?iso-8859-1?Q?Zxd6gdtUk7R8FDi+mZWogU499UbtY8aJ70g46/aN0FeY9CpX9Q8ldp2cuE?=
 =?iso-8859-1?Q?9EYK7mfajSaLek4Ckw+nyxlccjg0XJbkQHNrsoDx/M+zAVPLvPE4qmgeSq?=
 =?iso-8859-1?Q?KBiFjAhVVQHexM/9BG/90X6MeLTkhCkup2BR4Q7eZFxx7e0buAZeNxEra/?=
 =?iso-8859-1?Q?5AD/yQB5yF+rPSnt1flrJJ0AwvUMRvf2fOP/tLCEAJDaU7881uZb?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: dec3d8d7-76ea-4eda-c711-08ded01826b2
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 04:38:48.2662
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZeSWFqlvy4NPHZ24vbYAafGNH30O3MDgX4Q+T3LY4/FEkPXgwWFcaxczlbHvKg6xfgx8zrsPX2JGtPjYLbaUMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYP286MB5552
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.14 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_REJECT(1.00)[valinux.co.jp:s=selector1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[valinux.co.jp : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11713-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:sashiko-reviews@lists.linux.dev,m:Frank.Li@kernel.org,m:dmaengine@vger.kernel.org,m:vkoul@kernel.org,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[valinux.co.jp:-];
	MISSING_XM_UA(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	MIME_TRACE(0.00)[0:+]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E85DF6AC8BE

On Sat, Jun 20, 2026 at 05:25:39PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 4 potential issue(s) to consider:
> 
> New issues:
> - [Critical] Delegating a channel to a remote host fails to mask its hardware interrupts locally, resulting in an unrecoverable infinite IRQ storm and permanent IRQ disablement.

This is a false positive.

The delegated channel is driven by the RC side. No EP-local consumer requests
transfers on that channel while it is delegated. This is the same
ownership-model point as in my reply to:

  "[High] The v0 eDMA `ch_quiesce` operation globally disables the DMA engine and
  clobbers interrupt states for all channels in the direction." at:
  https://lore.kernel.org/dmaengine/pmxfqgsjposbv6zehrgitqwvbxppc7cfht4xsxw4l2lcjkojkw@ycqyo72w24ji/

> - [High] Calling `dw_edma_release_delegated_chan` with `quiesce=true` forcefully disables the entire DMA direction on eDMA v0, disrupting all other active channels.

Ditto, covered by the same ownership-model reply above.

> - [Medium] Lockless modification of shared hardware registers `int_mask`, `int_clear`, and `engine_en` in `dw_edma_v0_core_dir_off()` races with channel start.

Same here. This points at the broader teardown assumption, not a race fixed by
adding a lock only to the new helper. See my reply to:

  "[High] `dw_edma_v0_core_dir_off` modifies the shared direction-wide `int_mask`
  register without holding `dw->lock`, causing a data race." at:
  https://lore.kernel.org/dmaengine/pmxfqgsjposbv6zehrgitqwvbxppc7cfht4xsxw4l2lcjkojkw@ycqyo72w24ji/

> 
> Pre-existing issues:
> - [High] `dw_edma_device_terminate_all()` accesses and modifies channel state locklessly, causing a TOCTOU data race with the interrupt handler.

Please see
https://lore.kernel.org/dmaengine/pmxfqgsjposbv6zehrgitqwvbxppc7cfht4xsxw4l2lcjkojkw@ycqyo72w24ji/
where I described two possible approaches:
  (a) Do not allow the driver to be unbound, as Frank pointed out earlier.
  (b) Harden the DMA engine termination and teardown path so remove waits [...]

Again, for v4, I will add source comments around the delegated-channel helpers
and quiesce paths to make these ownership assumptions clearer.

Best regards,
Koichiro

> --
> 
> commit e6b7ee23ebe516f403f0d3278b28713356c19ade
> Author: Koichiro Den <den@valinux.co.jp>
> 
> dmaengine: dw-edma: Add delegated channel request helpers
> 
> Endpoint functions that expose endpoint-local DesignWare eDMA channels
> to a remote host need to reserve exact hardware channels and hand
> interrupt ownership to the remote side before publishing the channels.
> This commit adds helpers to request hardware channels through DMAengine
> and switch the interrupt routing after reservation. It also adds a
> matching release helper that can optionally quiesce the channel.
> 
> > diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> > index 7a24248b84e94..ca0504eac1fca 100644
> > --- a/drivers/dma/dw-edma/dw-edma-core.c
> > +++ b/drivers/dma/dw-edma/dw-edma-core.c
> 
> [ ... ]
> 
> > @@ -1192,6 +1192,87 @@ int dw_edma_remove(struct dw_edma_chip *chip)
> > +static int dw_edma_delegate_chan(struct dma_chan *dchan)
> > +{
> > +	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
> > +
> > +	if (!(chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL))
> > +		return -EINVAL;
> > +	if (chan->configured || chan->status != EDMA_ST_IDLE ||
> > +	    chan->request != EDMA_REQ_NONE)
> > +		return -EBUSY;
> > +
> > +	chan->irq_mode = DW_EDMA_CH_IRQ_REMOTE;
> 
> [Severity: Critical]
> Does setting the software irq_mode to DW_EDMA_CH_IRQ_REMOTE without updating
> the hardware interrupt mask leave the local hardware interrupts enabled?
> 
> If a channel was previously used locally, dw_edma_v0_core_start() clears its
> interrupt mask bit in the hardware int_mask register.
> 
> When delegated to a remote host, the remote host programs and starts a
> transfer, eventually asserting the DONE or ABORT interrupt line.
> 
> The local interrupt handler dw_edma_v0_core_handle_int() checks the channel:
> 
> dw_edma_v0_core_handle_int() {
>         ...
>         if (unlikely(dw_edma_core_ch_ignore_irq(chan)))
>                 continue;
>         ...
> }
> 
> Because dw_edma_core_ch_ignore_irq() returns true for a remote-routed
> channel, the handler skips clearing the interrupt and returns IRQ_NONE.
> 
> Can this result in an unrecoverable infinite IRQ storm and permanent IRQ
> disablement for all active local DMA channels?
> 
> > +
> > +	return 0;
> > +}
> 
> [ ... ]
> 
> > +void dw_edma_release_delegated_chan(struct dma_chan *dchan, bool quiesce)
> > +{
> > +	struct dw_edma_chan *chan;
> > +
> > +	if (!dchan)
> > +		return;
> > +
> > +	chan = dchan2dw_edma_chan(dchan);
> > +	if (quiesce)
> > +		dw_edma_core_ch_quiesce(chan);
> 
> [Severity: High]
> Does calling dw_edma_core_ch_quiesce() here destructively abort all other
> active channels in the same direction on eDMA v0 hardware?
> 
> When dw_edma_core_ch_quiesce() is called on v0 hardware, it maps to
> dw_edma_v0_core_dir_off():
> 
> dw_edma_v0_core_ch_quiesce() {
>         ...
>         dw_edma_v0_core_dir_off(chan->dw, chan->dir);
>         ...
> }
> 
> Which then forcefully zeros out the global engine_en register and masks
> interrupts for the entire direction:
> 
> dw_edma_v0_core_dir_off() {
>         ...
>         SET_RW_32(dw, dir, engine_en, 0);
>         ...
> }
> 
> If other independent software clients are actively using different channels
> in the same direction, will they be disrupted?
> 
> [Severity: Medium]
> Is it safe to call dw_edma_core_ch_quiesce() without acquiring the dw->lock
> spinlock?
> 
> dw_edma_v0_core_dir_off() performs lockless writes to shared direction-wide
> registers like int_mask and engine_en:
> 
> dw_edma_v0_core_dir_off() {
>         ...
>         SET_RW_32(dw, dir, int_mask,
>                   EDMA_V0_DONE_INT_MASK | EDMA_V0_ABORT_INT_MASK);
>         ...
> }
> 
> Concurrently, another CPU could be running dw_edma_v0_core_start() for a
> different channel in the same direction, which performs a read-modify-write
> on the exact same int_mask register while holding dw->lock:
> 
> dw_edma_v0_core_start() {
>         ...
>         raw_spin_lock_irqsave(&dw->lock, flags);
>         tmp = GET_RW_32(dw, chan->dir, int_mask);
>         ...
>         SET_RW_32(dw, chan->dir, int_mask, tmp);
>         ...
> }
> 
> Could this data race result in lost updates to the interrupt mask?
> 
> > +	chan->irq_mode = dw_edma_get_irq_mode(chan);
> > +	dma_release_channel(dchan);
> > +}
> > +EXPORT_SYMBOL_GPL(dw_edma_release_delegated_chan);
> 
> [ ... ]
> 
> [Severity: High]
> This is a pre-existing issue, but does dw_edma_device_terminate_all()
> evaluate and manipulate channel state locklessly?
> 
> dw_edma_device_terminate_all() {
>         ...
>         if (!chan->configured) {
>                 /* Do nothing */
>         } else if (chan->status == EDMA_ST_PAUSE) {
>         ...
> }
> 
> Concurrently, dw_edma_done_interrupt() handles completed transfers and
> manipulates the exact same fields while holding the chan->vc.lock:
> 
> dw_edma_done_interrupt() {
>         ...
>         spin_lock_irqsave(&chan->vc.lock, flags);
>         vd = vchan_next_desc(&chan->vc);
>         if (vd) {
>                 switch (chan->request) {
>         ...
> }
> 
> Can this lack of synchronization corrupt the DMA channel's state machine,
> leading to leaked descriptors or failures to properly abort ongoing
> transfers if terminate_all races with the interrupt handler?
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260620170040.3756043-1-den@valinux.co.jp?part=3

