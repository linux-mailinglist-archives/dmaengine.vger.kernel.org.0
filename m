Return-Path: <dmaengine+bounces-10272-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MOCtNzjb/Gl9UgAAu9opvQ
	(envelope-from <dmaengine+bounces-10272-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 07 May 2026 20:34:32 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 76D014ED7C3
	for <lists+dmaengine@lfdr.de>; Thu, 07 May 2026 20:34:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2D6C930309FF
	for <lists+dmaengine@lfdr.de>; Thu,  7 May 2026 18:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E81714611CC;
	Thu,  7 May 2026 18:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="m0Dzf+ej"
X-Original-To: dmaengine@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013052.outbound.protection.outlook.com [40.107.159.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A47F44CAE0;
	Thu,  7 May 2026 18:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778178847; cv=fail; b=bpdKPNFfx7t6zslIc0q2vZP2e8aaZypKSV4o/Op6mAnPr5IYfXvJ4YJ3sfSVN6CWCQ2YCdSkVLcN5XqIGu+tjFTBat+OooqZHXOoVLpm53O+GI2YMhRFx8j+JqFE59GCaDpttwpc2lB2Uz9MOg9KPRohIkV5LSx9VOqsmjkOmOE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778178847; c=relaxed/simple;
	bh=o/jV/cjd3bG9nLmrPEWgHVwQhyVhaxHZF99tQTMxjUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OJrYe7EfwqB2TqGyqJj8ty7yLYWW+DnyOBnqQvUkgKE/wvoeRTyPjNZL/b9mAmiLohwcpORzgKJ0mZwhNGjLaew5bSjMxj13rXndp57juqTAIqGuvGVxdqUB/BRLHBNJsSNDto6/woiBUylnbDhkx8KvErFTsA49YvUu8+osIX8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=fail (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=m0Dzf+ej reason="signature verification failed"; arc=fail smtp.client-ip=40.107.159.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T8baAdS7d1qaBwtCME1oK94HpAb8AoX/I4lfkrA0HPY/gOyK1dLOrbDUqtloLfRaGdKdE6Gu7OEJ6ZzxuIKwHORU2Dxia2rYS3N/of1uxlQUWcBxgfhPYi2b3rylSH9rAyvbyxwGo2tsHFzaDFVsOiXU/odnzpqIuE7LTy6FYOwavbyi2xnSSkNd4gBHsLcNbL3AeHv0nszfsXmIJ+h5LUV5FLJMG2zlyBY437qA/em0jJZmoi9rrOOEFByQ/okHgMsW18hgFXHoI6z0nXR8b18EK1BLRvjxaRReDp4nHZmPfQIP1hfyW+53py74AYDPZkT9a+14eS3tvkTD/y+H+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=htCpMpQuWxIG7cenyf9wkaQ89xgdifU0jjgK7EuEBvw=;
 b=PCSYXDU9MRhvqwccTg/Jttv17eZeNe0f07E17jG2kQ3fp1KdUPIir2L9COfzg31qK15UVpaLfCUQqfYRFisfpSATNUeQrpy9n3g0Ej4xDxSfjhEPGxrnpwRSwuvlf/KYZX+agmULCWLBxSSbUzM3NEtjEq8e46gBeWL63040qxifSCWucpw3Qv0r5azdCT1mc4xqmUU7xqOmVsnE8Ct0wTpRlLWe2DNrdkHJjIVd4QWMCShjO9T1CTjabMrlAw2rAOTX9fHOVVzQe8XHb9AQ2iLy2GurPRHseIxKJlNm7BxgFszy6ybw4NxI6lBseHjZiJktEbKuYAAfUEaZcrqHhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=htCpMpQuWxIG7cenyf9wkaQ89xgdifU0jjgK7EuEBvw=;
 b=m0Dzf+ejHzfc5uZE/Juav6BIKts3NXpqPsFdHLm7cO5Gd5m+EyGnQWrPBNGy9X7J5+RKq+Reojsgs/4j1n+bLSe48+9phqGCuOmZ12bNBPP/v/IJSkL0IqcHtD8cmmYzsCBRfX0aT4IKsXSXnn2hcTI3Y3jk0Oa5pre44yt0vFoZNJZzdelt5WFe4SdgmElkfH8TL5jVpu362mNCi/2tWLMAsrF4OIAMuqIZFl3lMZ3fCCCnVDu2/VmjEc6Hozwj0Ew9IfTN3obixMC4GgC4kOIFE0ioVbQzNBmgLeZ6Isi+fBVQsfov2/LdDsAmk9qkPlx8TIlMa9mUzv/WCcHTPA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by AMBPR04MB12614.eurprd04.prod.outlook.com (2603:10a6:20b:778::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.19; Thu, 7 May
 2026 18:34:04 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%3]) with mapi id 15.20.9891.016; Thu, 7 May 2026
 18:34:04 +0000
Date: Thu, 7 May 2026 14:33:58 -0400
From: Frank Li <Frank.li@nxp.com>
To: Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>, Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>
Subject: Re: [PATCH v4 2/4] dmaengine: dma-axi-dmac: Properly free struct
 axi_dmac_desc
Message-ID: <afzbFi5fAK3faBFW@lizhi-Precision-Tower-5810>
References: <20260424-dma-dmac-handle-vunmap-v4-0-90f43412fdc0@analog.com>
 <20260424-dma-dmac-handle-vunmap-v4-2-90f43412fdc0@analog.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260424-dma-dmac-handle-vunmap-v4-2-90f43412fdc0@analog.com>
X-ClientProxiedBy: SN1PR12CA0104.namprd12.prod.outlook.com
 (2603:10b6:802:21::39) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|AMBPR04MB12614:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bf1e743-9672-41f7-b31f-08deac673734
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|52116014|19092799006|56012099003|18002099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	+4BHbr2ztnuMeYenEa1Hay8cxn6G1UyUXXIAWtliAYpXrr140SLgX45EI4mfD8NDQgfhB+t5ZN5IV3Sx2xhdZklVRcZzKL7Ic+BcbSHAQS/U1F+pfmVcyB0zj4twDWRSsg1+fUOQNzOXVcimstVZkrRph+YBZq+wTSxRZR/ZiJrrnKPN3XLkxK2myYPT5oYSId3dBsO/gLTueAD67sdy1TUmrs0TchuDprbpCqUNjYdJUiUtdvVWJjieKrBzzzSKu1EXJpzspR28j+UKxOn8nKaWiBBhbs0cmr0MiFROByMbzuXjajXm4pND8kCv8Kwn1jrC58T8STRXQe6srdhtKthyrD1/iOxFDnEPHaezimb1e7hHEEPipkC7sd4zoc6lMxZX1ZEJ6K9BVDqq+ByF+L+dNosldl08C04G7nBi4nXhS1OgDXno7viZRBdTk22hKc2Awwsifet3Jy/L9RVQr/OoF9Grbv4Ov+8TJm7pGqPKW4DLfrg5mA7R6fy9Y8KVGT7DC1jM8zj6f29ycJOPOalBtSMt+kki/qAn8fJ2b50ue1gPEfSoohAVRI95zqARBB1u2GSvyyfySJfpem6427yWnTEi1zo8cPxA+jfJFw6Bxb9J4pcbzPwGAMAYKNxYQleyZqT0+9l6+f83sXM6A1COnxHJBOytgil9A1UYYL9XFxrRAz0BVdGLKPusylgU0nlSEH/qwOPwb9Fgk0928vxVIghAp6aZ3QwwOae9v0J7aXUv0acJDXDb8m7IZ/RH
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(52116014)(19092799006)(56012099003)(18002099003)(22082099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?uoKAmU2rt9PSjcFSjHSdIQWE4u0Q4tiQ1iqgpP788uAhj6qcfjHLlQQ++K?=
 =?iso-8859-1?Q?m6yuIPOTNMo9lVw75PwOspcquqf1ZA//rSgKdF+OuxkTcn6+oZkNoqe639?=
 =?iso-8859-1?Q?03HrIdCdR6J9pB0VfJN+YrkNsWyzP902a0J/VROYgBawS4lwX+/p0QZGUl?=
 =?iso-8859-1?Q?cvI1Yrd2xRPKfXxgAwAStXTnNoPKm+s0Tb+g8yCXNMBVbZgi+JYmSB20uU?=
 =?iso-8859-1?Q?omFUiMOnSelfVq6rPsCzTbI8P9+eSOF9/jZt+eb8j+E9kT/hYYIB55Lb2f?=
 =?iso-8859-1?Q?c1sVC7YfBLPCJhEPazAoM+aaGKRCnlvbawTQOl24ClNp+ULs4IziZs9q/m?=
 =?iso-8859-1?Q?1/oMbXg2aRTVfhoyimLyr/PdzEU5mPewYbe3Uu4EiK57hXLXEHpsj0IG7h?=
 =?iso-8859-1?Q?tJymiGthktcG72E8SGK5qJNxz9x1wKRd6X5Jn2KU41VXquCIOKMmF1a73d?=
 =?iso-8859-1?Q?0uAQlmToa/dY6Qiic3KewPhFz8SKNQBNSWWGryu6C/m3JS8/gRG8T9dfeG?=
 =?iso-8859-1?Q?5ht+dMwMLSsALy09EdNV0dqna03XteRh6li7VwqWa5V8bl53c7feKaLI5s?=
 =?iso-8859-1?Q?O9C6/+Pfky9KCOD+kJNpy2M1TjtSWvMl1PAHY2ADE0nyL6NBpASLstbeWY?=
 =?iso-8859-1?Q?hSP0oV8JQE48JPWiy84VwtKRetZVFgszmiayPb22KYum/GimRd+5HU+tPz?=
 =?iso-8859-1?Q?0qqF7fKfr7U82xG8WH6fAwxoIVlZwVvRzJEl1Us5UPDRHYXzRdfckFQ9U7?=
 =?iso-8859-1?Q?7k08wfzlgR+I4sYFLVskSTSOEsei/d6LzvLGg49/ax+3OAQuaKx53mZwG0?=
 =?iso-8859-1?Q?PoWLxFWEMJ15xekVXH5nmsnmwaokESk8DLlufBSTx0KFnxdKb9wn8j0HgZ?=
 =?iso-8859-1?Q?VPxKXlKDvIEKiBS4ScnR++Ta4D9DlTG2ouarp+kDfJh8v1LeTsgE9C7Bz8?=
 =?iso-8859-1?Q?FsG1//3gHxHEKbADLW6d5DLqGaAG+tMVNM7tyONO4tiI62myfjA/CBdWEz?=
 =?iso-8859-1?Q?h+xj1cLSWAKJfaZfU7I3f3QuFVYrdqOrWfL8uHDy937xzTvTR7E7gKh3Vv?=
 =?iso-8859-1?Q?BatBb5fUTOMbTMXieE8ZrGAB9boT6VrDyR0jIOt/oh+WS9oCbcUv45W0Ni?=
 =?iso-8859-1?Q?FMs56KABZxLbSmDYYWSrST6OvTUJEnZAdAe0z2llvzcPg+rufzmGGMqWc2?=
 =?iso-8859-1?Q?qofwByV3QNVMbPjtfgqH7baPcH0qMC32NfNwN5z2ppaaOek8FwV3TCmEJH?=
 =?iso-8859-1?Q?qo0knihopjm2Pb2mw+4+dT8zgZQMPpZKXYUXoMTnklDQkxFW3mBd3e8PQ2?=
 =?iso-8859-1?Q?r2UuXRDFJKOIKt23J0ivIO+UoCYz/dL5ZO3vPR5b+7WsuemNMH3dblTbv5?=
 =?iso-8859-1?Q?oR6hlKt2xzrHPlhj9Yd5IZKL0m+SYrYS9Jq1zFQ/Gpxf2Qj4IgaFHe6PA5?=
 =?iso-8859-1?Q?BRJ+Gz64wLVry1XQIVBAQb3ERGLMtCnA6QKEp4eYDaz8CV2KKhJsAGV4Wt?=
 =?iso-8859-1?Q?fKhi0IgVLLHb+6sJMMqhrzIjQBDzLPj2NGFXcvLm/0SDjfQdULw4wP5Msz?=
 =?iso-8859-1?Q?Gh0AfN9Kq0xyMhsF2zVIGXO8kXwNdcA5OK03MScLJ11leorCxpqcR5DqCR?=
 =?iso-8859-1?Q?I4PG8m/svkQxnJaGmK8Cf5MZQHn44mR7S0lYQV6bxTjBBjPmMsd78X4p/6?=
 =?iso-8859-1?Q?NRdFv+tL6RGvlgGS1FR0caXlGj0TbpcdAR0w8p3n+EAGfABeJLqa8/4FqK?=
 =?iso-8859-1?Q?ROAl7m5torKvTYKwywrRJ58YP64ejKPsK6S75+WWPKyPa/?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bf1e743-9672-41f7-b31f-08deac673734
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 18:34:04.2912
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qb97vzC6sHMGVea+pryG3cnTSUTENFQWHQb3exzk7QDNAxve59R0kq4qYUOj1d9nl0GCPX+XrdziahTEl68GOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR04MB12614
X-Rspamd-Queue-Id: 76D014ED7C3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.14 / 15.00];
	R_DKIM_REJECT(1.00)[nxp.com:s=selector1];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10272-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:-];
	NEURAL_HAM(-0.00)[-0.995];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,analog.com:email,nxp.com:email]
X-Rspamd-Action: no action

On Fri, Apr 24, 2026 at 06:40:15PM +0100, Nuno Sá wrote:
> Use axi_dmac_free_desc() to free fully the descriptor at fail path when
> call axi_dmac_alloc_desc() in axi_dmac_prep_peripheral_dma_vec().
>
> Fixes: 74609e568670 ("dmaengine: dma-axi-dmac: Implement device_prep_peripheral_dma_vec")
> Signed-off-by: Nuno Sá <nuno.sa@analog.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>
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
> 2.54.0
>

