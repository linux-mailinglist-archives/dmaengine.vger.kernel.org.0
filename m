Return-Path: <dmaengine+bounces-9950-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OJlZKj9o2GkhdAgAu9opvQ
	(envelope-from <dmaengine+bounces-9950-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 10 Apr 2026 05:02:23 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 08A823D1A49
	for <lists+dmaengine@lfdr.de>; Fri, 10 Apr 2026 05:02:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 59151300C59B
	for <lists+dmaengine@lfdr.de>; Fri, 10 Apr 2026 03:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD14224466C;
	Fri, 10 Apr 2026 03:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ahVhGknw"
X-Original-To: dmaengine@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013040.outbound.protection.outlook.com [52.101.83.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A398634C;
	Fri, 10 Apr 2026 03:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775790140; cv=fail; b=Q1/ccFOp6YP3Bj0HWmAz/UVDshUWzqBLKY2T5RosaIld2nFRJbEwTw1AWlRRxa8DOsohww5J/WPBhMf5aW4Vl0z2UZ+pCynYfwnKl300qwDph+SCD0dpwoI15SuC3dDZJyvVUNjr70rAAEShS+a7+pCRjMzsKtK8ZvxyoGdcRII=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775790140; c=relaxed/simple;
	bh=FpEDdqHtYp08DW53gzXYRJkHbVZWLIYbx6UH7ae89rs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fFQpj3SOVl9H4S7GsjZFoHGsT0N0YuPTZbEvgXM7FzBjLxs86ChhyLnHzhIcegB0zlU7yNA6v3+ls49qzrMLY20di3r/JZgpix8KDdhWXhS7S6MbA+wXk0WvG3lMivxDLCRBvkvwQ5RHpgAWGRkheFwE9EcNITIBY2ozXp6jZbM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=fail (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ahVhGknw reason="signature verification failed"; arc=fail smtp.client-ip=52.101.83.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YU+fOT2Yis174U5vgDdvpztvoONc8L3o/eZgVuumTdF842knbab4uYUm7oytx1W1h5Yln2H9pvqROfvIFT4ZZvBP51+XvFRY4z5OL9gqCwnNrRlVBu5Rk9wYWoFMi2xMtfINe18ykPCkOv672sfCvfVU1comSV4vIGbdjyP42UR1KVId/ih+O4N1rFqrOSTuQKf9WDdlQke3xCJs5RkqvxurOPxvQWrVzOiFdU8IYXlqMLmkMpnRBcnAmMpMFlV2zXR2CZNMxN3P1qtXFTvFoqENt2o5xdZbK0jT7FsR+uA1+wjrDkJDa8PgeQ/PazrMO9lUZKskWtErnSiMp2Mcog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zJIfr+YpLzOQL/Kkl5SKHyp0H2CksjswckD3PgdajnQ=;
 b=oKEoaJCmKadSFchrc5gu3NXf03ed/VnEHJPWp7RZ66vyyey0x29oQhHDC2vGDI86C0CwbMDiUeM4N5scHG50UR4HhZcNRfGo49ueNVBxtWxABPDiij9mxzaP/+sxgK98/KNzuO3Tm99au9Qjj8+fq7AA7YicVvQ5nWvNRDzGkOsQodLucbou6JfsFG7SDsQEOXUmcLy4Mpy9vjC6mUpmxyAJxehwhxPglEUcBi/kFQcEYEGPFFILv5VAfrV8G5Nh6N6IAUJK5coBr+1D+DTDenOL53R88OBRxsmaaSomsDqmqxQrsLJlJ9LFI9hzONe3ICEDIlzZZ8fMC4ffzh+3RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zJIfr+YpLzOQL/Kkl5SKHyp0H2CksjswckD3PgdajnQ=;
 b=ahVhGknwprqgwhJeKNjKMukPcfpI96HFZz2ISyqWyFhIzIpq5OGVr7yFbCsJPQ3XR81KpxvOrgj0yS0AHwH2MAorYFErGEK9Iww4OIdY4wkjTRKNrzsJtNJGcSbrKhfKiGgc5B/KHBb7Tet/UfoDJpWe4+iGSrBBQdmVhPYs02NWuKvvQ65VwmIsTujxJu+kD7EAeJPPQ1ov2CUZSHJT/c2RF00bdeHXh1h/1NDv+D2fXa5159aJwImZ0YEQr9G3CvF2XBa+BbyYSMy22++RgZtxTvR3xKBY7lWJTikrzlK+OESEd91zaPdSaLMuFuDfblUKWbc0lDv8lkzbBEWobg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by GV1PR04MB10128.eurprd04.prod.outlook.com (2603:10a6:150:1af::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Fri, 10 Apr
 2026 03:02:15 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9769.018; Fri, 10 Apr 2026
 03:02:15 +0000
Date: Thu, 9 Apr 2026 23:02:09 -0400
From: Frank Li <Frank.li@nxp.com>
To: Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>, Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>
Subject: Re: [PATCH v3 2/4] dmaengine: dma-axi-dmac: Properly free struct
 axi_dmac_desc
Message-ID: <adhoMSGwEvcvFFch@lizhi-Precision-Tower-5810>
References: <20260408-dma-dmac-handle-vunmap-v3-0-2456ad292154@analog.com>
 <20260408-dma-dmac-handle-vunmap-v3-2-2456ad292154@analog.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260408-dma-dmac-handle-vunmap-v3-2-2456ad292154@analog.com>
X-ClientProxiedBy: PH7PR13CA0010.namprd13.prod.outlook.com
 (2603:10b6:510:174::20) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|GV1PR04MB10128:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e2b844c-05fd-4c98-f3a2-08de96ad91e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|376014|52116014|38350700014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	1bZ24FFHRZK8ipO4n6xcAcJOXDbz4MzSAvgyNTIy23y7ql2RSa8cImNgCJVbRFYYMq9r4dL34cJR0AjNd2ScpkfAtO0MB95gXqikBFyIQhWzS4bHKx3JTnDqCc8X/m0Uvpk5CKe0acOyVJaeawPTHs+ZVW/AMJ9fBEWyLcKvj9TGflGTs8m9x0sSEnd2ifavAMRL4PKCOxwyMdEJqk1Blo9190xyKp+WtP611IONox9B75DnyfoXCXMvwyHaGzc5ovneMMMIlT8QOPsiwmbN5jzGTBQqeXQ+GbSBYbH0gSop48j5CAhC6ocf2VeVwhFSWKCePVBOF+5nKRtw0NE+ZwRFDdN99msDK5ntddNXdLn0WV6E3vusPLgtLb4Z5qS6Wsc+pn9/upPNwWoYXExNui1aBRS8j/S7qCdk2+0PdzFqugFzMbtMRAfpM66kH59OL1y1r/gCUFf3D2oxuOlAe2f1hR8fT5BYD0/rlY8eT2J9nm/nBHJQgZeQPVgBVD0AyUnAOsuwiEGLb8fBpHX4fbRYnX3VzJE9gOErHxnA2NUkY3aFN+M3/KNdptkCh++Psr/1xT6uGanhqrXw1gbYIAHORimPUxN5Vlq4HlrTHJT4ZlAqzK36Lpntzk/ST71KbrieOySPe5+kxY6Ejgd5A0P/DDCjvynFUDe1buWEUATaxRiw1IhsMgwzswZLg3V1RnECRCi9VIgia0KPefwuvG1933vDJ9vdaYSaPeN/RlkX7aPVQ/gdmxdEmVwIfg3JMAiMNxXGyiTWVxLjhbnJ/pVFadzphz3jTMeReNQdkSk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(376014)(52116014)(38350700014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?OoJppLPeofoDYzFSHpqtkwpAsjFf+m0r4Kf2IH3DLNl1PNmiwoI/H7QtX5?=
 =?iso-8859-1?Q?jPITD7J+S8qCQweADxVy8i/6Zi3z6a19ZFjgQJQDeMhLw/1Ylt/JMxX/BA?=
 =?iso-8859-1?Q?dkeNmeoR+3oBn6MfBUy3UIwFb3E7FoiYmxT4L+6lRbhl9T0Oygj1FWw9d3?=
 =?iso-8859-1?Q?SmozTtic99elxd67j7toQ+GjPWTD7ei4CWzqHi8oT+cQKYKS1ScVKnb1UX?=
 =?iso-8859-1?Q?z5hxq8BbCSwxveCasahT+0AyMTjnArNUxShRk4nr7qAagqqdzvVgcAtyYC?=
 =?iso-8859-1?Q?L91cAup3N3s2MOQY3ppJ5KJ9oIck6S4BqXHfdPEnBh/bzXz6Ui5Dd8HLpm?=
 =?iso-8859-1?Q?CBe389OOlRXcnVs0GeUOiIy5xNdtNI9B+kdJJArAJ18iz9dgK1XxUY7LV2?=
 =?iso-8859-1?Q?zKyTxxbchuNSTLaBZwr4tYsw5z/FTOh+VUQuN/iFBc1/EIMIRQc48pEYsP?=
 =?iso-8859-1?Q?zAov2rSYgCUtAbj3eqRMWn0kypJf+6D47dwjHCWr1bdZVJfFVnMJ3b4s6P?=
 =?iso-8859-1?Q?jlC3CrtxU6jLi1+cpk9oURlDMgvXYqfKVlowKTCxNhcSapC8xDgHoHKGUy?=
 =?iso-8859-1?Q?3jXGyPLKkrM0iX/os5+XQRloSOJP0M9Nz/9mg+xq+dNdOh8ggr5NWDYwu/?=
 =?iso-8859-1?Q?lj4u0jVn2shHGFvHiSdmLw9wGCiCVbHIB+iPrmgjpWMah0nHCddMQF9e/U?=
 =?iso-8859-1?Q?EuYuOAyK0zmtN+4LHE0VD99pRhwn2/o2qsJeCNn82kHncLDgh5yrcFghu1?=
 =?iso-8859-1?Q?uLSo+e57Vuvz24RQZ0xnNdAUen8iVSKr6YezOtHpglUbcXIuBy90ON19az?=
 =?iso-8859-1?Q?JZWYkPkpjr0N4Udmh556sb2neCEM6PtYLNOw9GyLAJkh2cZ9fR0pzZo54j?=
 =?iso-8859-1?Q?Jaza0AyGKp4tZ6voTCZZtDi0Akxm/hpA+Y1H/gn5owp5sWvOj5zq51wkfe?=
 =?iso-8859-1?Q?l+HLg8E6e6245o0OuaeSVE71YfdP7zSVKhQ/JwPqCljzR0bbfwQCs+S+mo?=
 =?iso-8859-1?Q?r3a/Y0mpmDDkq25TxxMfhc8n3yrzj8+30EhYX3J3q5psmhe3fvESu5BtFk?=
 =?iso-8859-1?Q?13dSsAmMCyZxIRE+4jIxjnMwG4pu40UMma6UTexpJtoVLS91jxY4oTOqhq?=
 =?iso-8859-1?Q?eHdu0DEzs1OZXS9uHitL/cDOecfRARxEccgKUQJdaEUEgTDYW59eEwxDf8?=
 =?iso-8859-1?Q?2SR5WN0CqznLlWHdZOEUt1tmGK0LMGwKxXt4Fn8zjvevO9Nw8yfDaSkfNi?=
 =?iso-8859-1?Q?kpQK6SZeLqYp8SS4iovtXnobbKCVdemdm9TLOP3EE+HF3gsbnmknN937Jl?=
 =?iso-8859-1?Q?Q17TG0Ugc2WbZMgFSGQDQ+zEIpGbDYK8It6f5ql8XvRk4tn4VkFKlnDtJF?=
 =?iso-8859-1?Q?t+T75ApIcGKkJH3y7s+uAePE9XO0sxfyssmo+2+3HcObjLzJY59nnrXZhD?=
 =?iso-8859-1?Q?WGMzOQmbcLnlXldAPooo4zj7iaD+CPhzA1ele8Fez71iPxwH6AgQPE5X8y?=
 =?iso-8859-1?Q?7BNsMe5V1uCdb1rw1xj5TiSZdmIXcNJTHE2sz1T3B82rY8h+rEg4yJf0sX?=
 =?iso-8859-1?Q?D6GxH2yY8n181jNgNBgkkkD5xsWH32M24KJzY2+TSg3ce37BtnttKJGgBv?=
 =?iso-8859-1?Q?N6ofFhjBAeylBCi3Oc7nPPrc9bddfDkuHxlibikGQ9gLQ5+3FOa0gaHgyk?=
 =?iso-8859-1?Q?FATnSp9URkrnKmtBsqL9amj6BQrcDcnvZ5YjbYZ8xPgUMjtZ7//d2MiQwW?=
 =?iso-8859-1?Q?5jYM1gEdyUryGMIUD/xpAvLeYPoCqTrqDYuqb8VIMXp0GMPR/AZ9AoE6zg?=
 =?iso-8859-1?Q?uGY+6Q+QNw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e2b844c-05fd-4c98-f3a2-08de96ad91e2
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2026 03:02:15.5801
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eWaEMPqkE1X8VIv0ZB+FO2jHUN76EBuZKmgeCyL+6dvowMmFn1IBfhpk/D+8eNJpdQC31kuZUL7J06lkKYfsCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10128
X-Spamd-Result: default: False [2.14 / 15.00];
	R_DKIM_REJECT(1.00)[nxp.com:s=selector1];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9950-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:-];
	NEURAL_HAM(-0.00)[-0.995];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 08A823D1A49
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 08, 2026 at 01:42:41PM +0100, Nuno Sá wrote:
> In axi_dmac_prep_peripheral_dma_vec() if we fail after calling
> axi_dmac_alloc_desc(), we need to use axi_dmac_free_desc() to fully free
> the descriptor.

Use axi_dmac_free_desc() to free fully the descriptor at fail path when
call axi_dmac_alloc_desc() in axi_dmac_prep_peripheral_dma_vec().


Frank

>
> Fixes: 74609e568670 ("dmaengine: dma-axi-dmac: Implement device_prep_peripheral_dma_vec")
> Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> ---
>  drivers/dma/dma-axi-dmac.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/dma/dma-axi-dmac.c b/drivers/dma/dma-axi-dmac.c
> index 45c2c8e4bc45..127c3cf80a0e 100644
> --- a/drivers/dma/dma-axi-dmac.c
> +++ b/drivers/dma/dma-axi-dmac.c
> @@ -769,7 +769,7 @@ axi_dmac_prep_peripheral_dma_vec(struct dma_chan *c, const struct dma_vec *vecs,
>  	for (i = 0; i < nb; i++) {
>  		if (!axi_dmac_check_addr(chan, vecs[i].addr) ||
>  		    !axi_dmac_check_len(chan, vecs[i].len)) {
> -			kfree(desc);
> +			axi_dmac_free_desc(desc);
>  			return NULL;
>  		}
>
>
> --
> 2.53.0
>

