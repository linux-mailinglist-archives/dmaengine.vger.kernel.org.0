Return-Path: <dmaengine+bounces-12502-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id B2IZFo1GVmq62gAAu9opvQ
	(envelope-from <dmaengine+bounces-12502-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 16:24:13 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C12CF755C10
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 16:24:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=YTxAutcj;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12502-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="dmaengine+bounces-12502-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0131030379B8
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 14:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E486A47DD69;
	Tue, 14 Jul 2026 14:23:43 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013066.outbound.protection.outlook.com [40.107.162.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634F847D928;
	Tue, 14 Jul 2026 14:23:42 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784039023; cv=fail; b=JCEEV2uXSClI1jZ0+w3xYdKhVMRWvPWLSYRQGI1Vpw3rdYj/WoZWP5XSC4r7d0wZk94Cm4c45N9p5fTwuab5R8wb9YZyK330d6YEAPx60+n3ZaWkDVXVAF5zLj0M6gYIyRcqW7DsOBPGk1Imk9T+GYKmvRrk0qWFLW7z1FrAFcQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784039023; c=relaxed/simple;
	bh=RhoMloSHZg1CJLhQJvE6MukkO7wKCm20AuksLBj3Zm4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=p5v6AiJMIe6gcdw1HUBj1XmWWahIh4AhoAcWdfNHQAftzPj5WYp4x8jvs+LsNwZZ5T8cvS7/eyPmsuHhDVaLhuurwN+gEpFP4JyoczYC/kTySqUjpylxf4WVyCB1eT4GfrXT+6dmjbwWUehr4QpVzROtvesr+YkEFqkUjfSZu4Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=YTxAutcj; arc=fail smtp.client-ip=40.107.162.66
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EMuGTJ/obR5geAXZ6JTjRi9qjU7DjwtaJ0LgRlCamxFXb7uxLJS8v++iuB4tdxbnYFmLo0HmlJVOUm53Fv8/9KHj1xHxJJkMKYvmkbwc8IrOF/vzYXxTo0C27bkSLnqqjKgR6KEpfUeYXaTHuf47VShafRleeNXZG6+pFpWIB+UXPNzMgNU/QG2WoBOnOzZHui0ZbEKWl8pfnRkb3d21r6q0QwnKqOswr5WgC6xpCgy5pYbkmIRVFpdL91X0fq26HfwMstpZJIKZXH289GYTDPp+h9tv4hV6QoMwj4AksSARtC2sBgu06iHzFsnUGz7PY+vp1GfrOi5Ls3CIa/m7nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NbTGL2W1tbRJgS5J/I9QgPZVjgYoekQGw3zKXQRSGW0=;
 b=b/biZ1zXYr83Q9n+zvnvd2RTuzrj7BmKFsa7BwCof/tD73jMxn6aACj8NW2sNyHcwpiRL/AtzTx3s4mTKMlBqu8BMbtGnjOrzw+C3G/a2N5K2MRlcjGow78vAxVhlcA7AHL+NgexQtwhkXI070IMmBPv7cZel3EIeP+KKYwFuawUmvO490OjunUQPOVdlWRb+ovOr96IqHb2XFGz2DI0jZrNcN9BbUfe8GCrjpWqAfYFdxMbfkE7b7R65VT5wxyZzg7AC7bgb5QvE098rHikHTDQ1dWT5hU47+Hhn4CRWQMA+dxV+tl+7h7njICXv54RG0vFreUte7ByWedAgCDgvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NbTGL2W1tbRJgS5J/I9QgPZVjgYoekQGw3zKXQRSGW0=;
 b=YTxAutcjk8yeVrbKsShI+uQ8yoVx7Blkci/lE+Yk3lewVtHP13nmG/TSAViqGwb5abDtQyhUjub0YnzgXc3Y4CuLR25cX4cYcXQLbdoSvucWTYvsEE1uLkyZfK/htnYWq96fVyN7sLQhuWziD9nWa6GGSBT6eDS9YnsyeQVoIzPY/kRCX/efFhumfuxwxGZ+POuNKzA9XVifq4URPLKSpZ30XO6YTqk5jJStrCjG+lkeJ2EY2mDrECM+eue1vtQftXgQsAEygO5EGmijPzeZGTpo9J9ry5hmydKh4Aquhdbi963sobgBiNnAFebhnrIMx5RKew0M9e8FcTbOp9AzpA==
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by VI2PR04MB10739.eurprd04.prod.outlook.com (2603:10a6:800:273::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19; Tue, 14 Jul
 2026 14:23:39 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0202.018; Tue, 14 Jul 2026
 14:23:38 +0000
Date: Tue, 14 Jul 2026 09:23:26 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Vignesh Raghavendra <vigneshr@ti.com>, Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>, Michal Simek <michal.simek@amd.com>,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] dmaengine: Constify struct dma_descriptor_metadata_ops
Message-ID: <alZGXqV_bvldvS-5@SMW015318>
References: <b0a22171f3ed68e156a2fa84383e99c23ec6b2ff.1784037977.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0a22171f3ed68e156a2fa84383e99c23ec6b2ff.1784037977.git.christophe.jaillet@wanadoo.fr>
X-ClientProxiedBy: PH7P220CA0090.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:32c::13) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|VI2PR04MB10739:EE_
X-MS-Office365-Filtering-Correlation-Id: d0605213-b3fe-4ce2-880b-08dee1b37f43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|19092799006|376014|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	EyToHlgddIXil/JVR/2sVQToUidHqBq2wxEJc4ySCwHKAYN0lYfc/zVOUWrK96LTqrtxZpzryOuyk8+f1pTrY5kKb3ZHoQqAv292Pjac4CVWVCTGxT+CoMpAords1sA2bApTibQzBwInGUSQB5nKH+RUqjJQWuP0WnaMCjljkJrmk1x60/HehZ6f0GHrhVg6Kxndy6KJ1V6ZCz5/nGw/nPcDzIsPkDmb/5bZ6UYrvK8M20K7/73mX5y25ugubx+Wo1vcHmMyEFTDR6wZWoA83PV5yPE1fKasGtLVP5tsvaCf8CBkyw0KziO7MYLl2aoLc1B9LQ8uvYUksDz70Z3eq/G0tayBNbDAsHpirIMY0S+RUTy2MLbYx2F2Xom2ZEqOJZtqbxSt3mfvlnK/E0+fTZKZjVhUmSdk/RnmbZnEHHtxXb7oYR1s7JbPxkFaQhQ0K7XBWPm6OwnXgMxM9L6aEx/Z+ttxhoZdXbayuNJ8kqWOU30QnNGlHl9MmB8orNuCuJJ6rSEcX2KuNhQzpB/bgQqrwM5+WsJjkV2O0L+KARkcWTt1xs8mm7APgln367urk5n6A7+DPLH3VGzoLtKHoYqBWal5XZt5vh6tmQpENsJZyX7jbIzkMJKGNtXiGQ3+4PTpWmv9KKxlBIOu1FRNEwobRi9LoEcHIZYSMSaZ5D4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(19092799006)(376014)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?G4Mobyjg6vdQaqqiQhm3fYJNkRheHNop+MzFa9b8CLEop7xY446lbd7dFqHm?=
 =?us-ascii?Q?dWfMYqeGbCtn/081wgCy+fHt96F5Ml9N6CkbKUYONN/lXVMcjJI/XFcKGq+P?=
 =?us-ascii?Q?CfAq+7uKxupYiwT4ue0UfUgPzGem+SC7bhgZxjlbb1fvdQ9mCxTatgep6YO4?=
 =?us-ascii?Q?XqGSPQcR0xebFFmZRwecyVqLIwNN9v1EqqkaXzmxW+wMNk2hFg4xJ3Dg+8xJ?=
 =?us-ascii?Q?JllIDchay1OYv5o5hcPb6t1qmhQVJ0opQ++ZIE7UkObjSAApGj1hfslXhUkk?=
 =?us-ascii?Q?R0E7iZzRejPZFiFcHfrrOY6j0ca1E2Tt+o/hFMkqA6q4Sw45p9bmqqhdaVcE?=
 =?us-ascii?Q?l/g4wb8HoUGWqMsj1EFTEx8a6ulRuJgg9fERyeKqt/N9BYAh+H4QmOeeaGaY?=
 =?us-ascii?Q?2eGheNn0yYFKE9brYs7CoREYz9lA2Jimpu9UTklJsDhsCDJgNy5UZt/XZQ+j?=
 =?us-ascii?Q?eLr3dwBkejO2KIWsBqHhOZNKUONotisQ9lJIoAPyqYVdVyxkYuafZpKD+9Fa?=
 =?us-ascii?Q?H1CdIPkabttGEfK9VjA84ZWScF/+dqnZQKF/snqKi3TAtlbxSFov7KqL0PQd?=
 =?us-ascii?Q?F3HTMBU8Gbw1Qe8EfXbvpLK/cYtYPfgV9SRsdVvWE8QAfnpAzR/NY4/mD+YM?=
 =?us-ascii?Q?rHBu6CaECv4ixeEx5BLx3y9p9dO4OlwuqByNG1XC2zIxZV2Ar26z+CnX+S36?=
 =?us-ascii?Q?oPuVdKBDHx1vF18dh5aI+vKCpdmIlN2kG2VeejcqhqY3SbjR5IsDpPlnVx1O?=
 =?us-ascii?Q?Uj7wRXQT4CFSi+iXkswAYQieahdYLPRGpKbgLKYAqX1o1z+qwKMsL4Sl9p8x?=
 =?us-ascii?Q?4tbOpcsclcDOv0+gsZWSCa86p6RoEaKdRDqC5U6IGfk5IkXPwqDLpMRUHx4/?=
 =?us-ascii?Q?8Tfx4LA6lFQNB6VZPiwIpX9A1qNQfIvV7cZ25DkOUbLYPG26JtMQSVP1I4Rf?=
 =?us-ascii?Q?3fdko2MrMChE8mCjkPEvN6LhgyjRoIj0Wv5enTYi8+rzVrXYZmBp7pi5JXXX?=
 =?us-ascii?Q?f8cNJNARXU4TOTp6eqG+P6iwCo/BbQTaMTSNQ1lq5V4z9UMu1iUdq8PnCIGx?=
 =?us-ascii?Q?irFl5qvr2gd5qAg04uiEFdlxE3wAfsIZ6SbZpByVtncRBecIW447QdVPOPBp?=
 =?us-ascii?Q?ByGOOkNi6C7+Zatph1S+m9A/ztnW2dPqzhqV/hXjUCsZFrwFx6LiKQ2AOPIG?=
 =?us-ascii?Q?DPwHOR0/vTTkVy/LashBTYoS9AdloBO4rb7OGF43RbHDhWy+/SMxS0YWOlR0?=
 =?us-ascii?Q?xbJZve9Wxx+aPsO1bICafNI/218BHcuGqI+1Rp8pZ46wzKjgjiHznbfJ4pds?=
 =?us-ascii?Q?qMIAjhqnotIrwzndYaiZ9mlTssss0a9XsMOresB/Zu3QY8n5GQZNAbIYhUx7?=
 =?us-ascii?Q?dyqhMtocA1hQVJq9d7TcrDjo7JUR0ow/pLSeZHit3y6HKkpvEspkA3KStOVa?=
 =?us-ascii?Q?zuKQkK75zYF0N1ScYEixFx1PURhb3vVR1U+M3/BlqWtF+9otYjqDGdJh5GFP?=
 =?us-ascii?Q?OdFFwI64Au1VpQ6X/fyl0+qQaQAhBDV53Q63FISrJTHUYK+ZHhly8KOlfG+8?=
 =?us-ascii?Q?l9R/An09Y9zEVPwfBUWLMTwQGTIs8HUsg+D0VCpuwEPk/Ly3ilklYKHdC/BR?=
 =?us-ascii?Q?S77XFlLKJfi8P2qkKL/ciKftRp+xRzC9FRZUnov17Y7NGvbgAk5QniWW7hDZ?=
 =?us-ascii?Q?Yf1W9zsp45BlxraPFUHUORFuPjDfHTTu8p/rptV71JuDL6V/dLMlfNCo2yaf?=
 =?us-ascii?Q?Jszt2a7wm6RMwjQ2iua5+Ekd2Be53I4G2828HyBaiYcXFJEwfJbu?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0605213-b3fe-4ce2-880b-08dee1b37f43
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 14:23:38.6857
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8CcG8tHCxbjt4QO8souESTBzA6QOX0myUEiZ1haBa/UtYAc7kYBm6IMR+9vlhapY3yaMaCmTsPFG/m+Ku3EFZk9Zz3/Ynq0J7Gzsc3dXmKAKZQcSSKUgGtXElUhk8fYe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10739
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.94 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:christophe.jaillet@wanadoo.fr,m:vigneshr@ti.com,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:michal.simek@amd.com,m:linux-kernel@vger.kernel.org,m:kernel-janitors@vger.kernel.org,m:dmaengine@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-12502-lists,dmaengine=lfdr.de];
	FORGED_SENDER(0.00)[Frank.li@oss.nxp.com,dmaengine@vger.kernel.org];
	FREEMAIL_TO(0.00)[wanadoo.fr];
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
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[NXP1.onmicrosoft.com:dkim,SMW015318:mid,vger.kernel.org:from_smtp,oss.nxp.com:from_mime,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nxp.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C12CF755C10

On Tue, Jul 14, 2026 at 04:06:33PM +0200, Christophe JAILLET wrote:
> 'struct dma_descriptor_metadata_ops' in not modified in these drivers.
>
> Constifying these structures moves some data to a read-only section, so
> increases overall security, especially when the structure holds some
> function pointers.
>
> On a x86_64, with allmodconfig, as an example:
> Before:
> ======
>    text	   data	    bss	    dec	    hex	filename
>  120635	  21584	     64	 142283	  22bcb	drivers/dma/xilinx/xilinx_dma.o
>
> After:
> =====
>    text	   data	    bss	    dec	    hex	filename
>  120699	  21520	     64	 142283	  22bcb	drivers/dma/xilinx/xilinx_dma.o
>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
> Compile tested only.
> ---
>  drivers/dma/ti/k3-udma.c        | 2 +-
>  drivers/dma/xilinx/xilinx_dma.c | 2 +-
>  include/linux/dmaengine.h       | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
> index 1cf158eb7bdb..fb21e0df5ab7 100644
> --- a/drivers/dma/ti/k3-udma.c
> +++ b/drivers/dma/ti/k3-udma.c
> @@ -3408,7 +3408,7 @@ static int udma_set_metadata_len(struct dma_async_tx_descriptor *desc,
>  	return 0;
>  }
>
> -static struct dma_descriptor_metadata_ops metadata_ops = {
> +static const struct dma_descriptor_metadata_ops metadata_ops = {
>  	.attach = udma_attach_metadata,
>  	.get_ptr = udma_get_metadata_ptr,
>  	.set_len = udma_set_metadata_len,
> diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
> index 98b41b8f8915..bef2b031dba1 100644
> --- a/drivers/dma/xilinx/xilinx_dma.c
> +++ b/drivers/dma/xilinx/xilinx_dma.c
> @@ -655,7 +655,7 @@ static void *xilinx_dma_get_metadata_ptr(struct dma_async_tx_descriptor *tx,
>  	return seg->hw.app;
>  }
>
> -static struct dma_descriptor_metadata_ops xilinx_dma_metadata_ops = {
> +static const struct dma_descriptor_metadata_ops xilinx_dma_metadata_ops = {
>  	.get_ptr = xilinx_dma_get_metadata_ptr,
>  };
>
> diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> index 6fe46c0c9452..fe33a20abc61 100644
> --- a/include/linux/dmaengine.h
> +++ b/include/linux/dmaengine.h
> @@ -631,7 +631,7 @@ struct dma_async_tx_descriptor {
>  	void *callback_param;
>  	struct dmaengine_unmap_data *unmap;
>  	enum dma_desc_metadata_mode desc_metadata_mode;
> -	struct dma_descriptor_metadata_ops *metadata_ops;
> +	const struct dma_descriptor_metadata_ops *metadata_ops;
>  #ifdef CONFIG_ASYNC_TX_ENABLE_CHANNEL_SWITCH
>  	struct dma_async_tx_descriptor *next;
>  	struct dma_async_tx_descriptor *parent;
> --
> 2.55.0
>

