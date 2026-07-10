Return-Path: <dmaengine+bounces-12279-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dVJwOlGqUGpg3AIAu9opvQ
	(envelope-from <dmaengine+bounces-12279-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 10:16:17 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B28A738567
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 10:16:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=valinux.co.jp header.s=selector1 header.b=PbixA+bb;
	dmarc=pass (policy=none) header.from=valinux.co.jp;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12279-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12279-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2E3E5301138E
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 08:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C55DA3EEAF2;
	Fri, 10 Jul 2026 08:15:29 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020113.outbound.protection.outlook.com [52.101.229.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD883EEAF8;
	Fri, 10 Jul 2026 08:15:27 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783671329; cv=fail; b=gAwj7fMiYmS47PE+m2cw1/b22u1gEkSy82gmiQA7y+Y4HCIXHIeyKX0UFEvC/eOqcHU+1h9k5aqmyDb5vNBgTrHpWJ9epxpG9eI0FPq5+ccOeLt38OIlPtesNyAZL0zC3VjwZwdlybwFBSfurOhJdGeQPfD3NCY7Ifl//xJ8fD8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783671329; c=relaxed/simple;
	bh=JaRFpR0IAKujDYdT3drbkPWtCiMhrql/GH0fPJnWPLU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pp+D5frcZgnH8pfavy74HdU3TfBgce/1tfmkczI2241pp7rVc/puV0wIaZtudBccENtUvOG5zsGymksjBjLoaCJz5RHazTTlrDy9aI5sj2CNSCvlKO+dehRThrzJAafZykLhWEduRNd/tVK492Jhx1DNd5Zxx8YYT0PcCFlyd2o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=PbixA+bb; arc=fail smtp.client-ip=52.101.229.113
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vUTK5Hpj9hGeCPbuyXF/aINibL/RPpB1jJJ8K8ILPvr2edoNuF2eqrTePeX8mafVIFmRU+z8ncp/6oQPvA/yHzxrnQvyBvsFM9GBNcZa4s/H9vD1D57G+uvMs9e26ARIO3GjcEeVvizZBE1eCKI33FiJwbwR8sP5MHXgCBVUXm5kmOBvZ+FogbjcuMfBmfPzEbE0NFs4rNdHu9DplpCeiyHregHQsHviFfk+2NFJMDW1LtUryA6Ed701l7jEPliarCGXqoQMzKdIZ8QmSUMQK97nJ18sYgTKy66a7bjhStqKOQdzqnZ/PRj7pzBI5Y+Yr4faa/AVaEGNQ8Gg8S4+MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V8VFhAouUSDfsZ6di4Wy9JZbjD6EcSxLsHy9NBMy+RE=;
 b=sGULJXIe14so+2YGQHG3pG0JZwWcWYGC6nIXLlKas7nH9b8bnGUSdQxzHBRN86DyBD/F0ZWwaqo7OFMLNGU3XbAcEr9kxAm1TGPKSynqL80JXZBlqnhhptA/AiTdhWYV9hunC+98yQlFU3v91AcuHifc4geimIZ+8paDwXR6NwRRqmF0iPXCt3EXd600nGmBM/IO2VfCUXIQm9exGzBHsCJsR0y7Mh6FChvNrx9PI5is/JrlB30RMgnNs906QwTN2jrcAM54TXDQuxL0ClzMAjpBYMfYusW0qegV8CfcGWnmb9/MxArRQ7lNkvvOB5B6O1OW3FifWgNiiv7UVfj8kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V8VFhAouUSDfsZ6di4Wy9JZbjD6EcSxLsHy9NBMy+RE=;
 b=PbixA+bbxgPk052L223uTGpaNAeRGNtwOaMHIRCXlCjGkF6P3EtnAMMQ5mMw3WpJuM3yRV2LuyXL9frBFAZh3NU8JZ5hrEZdb3F4v244SZbyB0ZF9g+hDpT3Ucu3CM70m/R+9C3R7aKfb43ZVZ4TEYmtdiRpSYeiJaeI/rpDOBw=
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS9P286MB6307.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:409::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Fri, 10 Jul
 2026 08:15:22 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.21.0181.009; Fri, 10 Jul 2026
 08:15:22 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 02/14] dmaengine: dw-edma: Add per-channel interrupt routing control
Date: Fri, 10 Jul 2026 17:15:06 +0900
Message-ID: <20260710081518.2394357-3-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260710081518.2394357-1-den@valinux.co.jp>
References: <20260710081518.2394357-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0118.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29c::11) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS9P286MB6307:EE_
X-MS-Office365-Filtering-Correlation-Id: c042a292-28bc-4360-2de9-08dede5b6349
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|10070799003|23010399003|376014|6133799003|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	iUTqwChWSWTKSrj64EYbG5vh6hRNEA/eMJru0Tn25YS4VkX+Y6XyrlRWTPd8VOy+AO+KUylKhpWQudIpUKAdY0wWZvx0Wgc7ebzYZ+rJzaVEg/DFHNOzVuaOv6xsH9TzI47IHk+eGSjj1fqRQyZL9jzqsbETkvTCrDLwlwWMwaKxMpU1t3wHavFoHfl8b+oIwhiBVKDaRvi03O0gviYz2i16sCsHPPj2DU249djkz26Kqq/hRoFlQrQQcs5Gl1JZ/r2WsyhnuUwUAo2o6WoW2Yri+GdAkMOFDtX332HQqakADqCfmzlCy9vRZGvFtvPslaCM9wQse2NcnGVZSCwHJSzCntKDPy13SHLP1oNvz2BtXDcbXqeqg0jSNPhMRBmGtVhGV9XnPiHSn94jgtOIfLfOE3EiZ9yJMBUYvyv3twDayxgMY821YYN+EFn2khuWUCvvZx9Zi+j/MpUMFJuaB4V0UNa1Hcwe0mtmCfVZS/IJUVgDham68belJH6Fo2a2B60tauMYd3bh7stp3z14ZRnHrBkPeZDuoWi5Q3XEkrMM7ygFMCgHS0nUVZRs9oyuipP3ETr661Yw/UfxThs4A5ifhlb6sdqLbPxiu76psQz8vdvzaPyC6QTIlCJcRweUztc8XH4mH5a5GG/3zyDkER/sl3KM+BFAQVLo11ZotUI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(23010399003)(376014)(6133799003)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DABWbN7j6aPo4AY2uQn6GKy8Gll1iCMFtoY3F6yfogiyrDsIwofErDlKOSqc?=
 =?us-ascii?Q?cKIfcEJdxQK24kc3cANldjo/Y0TT1bOa7JkznUqOfQ2a2Qd7MziQ7o58aGAw?=
 =?us-ascii?Q?zdG1o6PVtM1MtMo7b7C/7MlK5V3ZS6f6nK7Cu5Yi7C1KVsG3cSp/oms+UzhD?=
 =?us-ascii?Q?oy7khiYaX67QQ9QVe/uSZfd/J0buqpoc1MBLHKAOA0ZcVINA0K1mC492HCYO?=
 =?us-ascii?Q?9pqXh0+iFA1ze3EB2d/grTx833EKIsNT94XSGh5L8RaX4GvLTE2aGyJULKak?=
 =?us-ascii?Q?ecDUh6Lox1fQRZfmfrBPwxQf4ruEnkPVtzIgwkFBJ6KeXXycACoaFRnpCkuW?=
 =?us-ascii?Q?6a4KAEc7+LUQkcOMX/91Co83wZ5d3ByUIZsmXVvQB5GVbj71am3EDAViqjD4?=
 =?us-ascii?Q?nSxC7S7nssP0oSAqf5mPWBJ77pFy9l4mYqf+q2TROEG7moPjPJ6KbIKd0U9j?=
 =?us-ascii?Q?19kJd0+qbDQuqYXouienx5C1QzSYnIe1/8t/WefeK7e7ma7R1ESQ83AzVjBI?=
 =?us-ascii?Q?Wgn2ekaVYNPHRVMlCy6WnzR3pM0/mjQvbjE1+dE4n3Txym9WNnIYjEyeaRfU?=
 =?us-ascii?Q?n/GSiDRh48KnRyq1xoG55Zii8E19mRVQkZmxqi/8qpovNVzdKhpxowJYyUqg?=
 =?us-ascii?Q?4w/XRfbJZpfYQtavf23NZVlSWafBiLoso/6/IGV2KlLWuY91vcybcUqvh3qy?=
 =?us-ascii?Q?hmBhvhUbxeYlT3ZDs0eQDDxR1/mz0I74f3gkPlufD0mCntXpm0wWEiu37nkG?=
 =?us-ascii?Q?D4jjymmVeBeJrJe/LrWbuKxcG0TF/udbTFPopSSyCQPrJy0G5/4W8K8OVX/7?=
 =?us-ascii?Q?afYaaiLvIXxnxYrd1l17EwdmiH23UQayvW0SpNT6g76zbujeQirgmpkVrmUe?=
 =?us-ascii?Q?DPrQP2VCR7pjifkwSKg3wqns56ZCXu0wAX+GV0uX6KkL02RqxYGW8NuDTjsc?=
 =?us-ascii?Q?tf5nODwvygH105lDk/RaPfblaPMvcML+Um5PSpdfv5228myFtPVlcpCyKRp6?=
 =?us-ascii?Q?xu4z37I6QNNHeNUz1qK+kkYyTcAWBuzVpRdqawlpuSsYeYFvvbAMZdZAyapp?=
 =?us-ascii?Q?uzblVdzLib8vC1JPzFAe3Tz2TesF5EldtfCOfshPM/Bb6WymKKb5DHSZyOv9?=
 =?us-ascii?Q?115igHUxbXCnuaxznrE8ZxlpYmNK0oCw/qJG8glb5zrCXjTLzi2+uo4qOwwW?=
 =?us-ascii?Q?QnUFYkoSYyTn21HMEjZl1vPtr8CNp8SmTUqoJJ/wu+fZEJfHX7lb4D8O3Rtc?=
 =?us-ascii?Q?jMf7gq1KOnqVwrACuBVht4fSqzJnviKPkS7wS12p8x5cztYyl0QjGZ/K7SXe?=
 =?us-ascii?Q?MvClSJfKl2mPUS2U81a5v34iEZPLj1GcDpS2w0VU7p3wtayScAIdDYPcBa3a?=
 =?us-ascii?Q?jcmFoxNXdodphC5cn3DJzqLxlTivbZJ43yAWlRMnIz7QHWzauV4v1mgIpU+E?=
 =?us-ascii?Q?pmtFbxd9rSoCy6zOqFe9f0rj3jnCb8laVbdmuBsVTzS2+QhWt2W23PUmJjRj?=
 =?us-ascii?Q?r8JWie9m+Gwl2gXDk9uHj2ZWs4LdroJ1L8ZsZ8Zfz/xkGOXna83tGnsvhHcr?=
 =?us-ascii?Q?6xcuJiIiRD+yrloYKKjkJp0NaemBDesmxdIsWV/2EgBdxovOMu/q+vQwXiP0?=
 =?us-ascii?Q?/ZF2peJJ/1AQHq0URaCQQR/Lsp2QcKsxGn942d3zZlT4zFZsaupy9Ma0nt5Z?=
 =?us-ascii?Q?+ZaiEH0xro2n3FSY4rEVrN/ygiR4nXGH4v5vzWmlauN0mmHbK5NiwtRj86YC?=
 =?us-ascii?Q?IK9r6U2adD1v1pi9t7fQ3qkgQnnFepCJGsgPyuhsg0YdcKbPKp5X?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: c042a292-28bc-4360-2de9-08dede5b6349
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 08:15:22.3228
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rrJj5tKgkNASbs68Nu2lyIsbIZxqCkximpKNZOpXmPJ1zEvT27H0v0vSAHQaOGz8KleluEavH0dHeqdK0AQ40Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB6307
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-12279-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:mani@kernel.org,m:marek.vasut+renesas@mailbox.org,m:yoshihiro.shimoda.uh@renesas.com,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:marek.vasut@mailbox.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[valinux.co.jp:from_mime,valinux.co.jp:email,valinux.co.jp:mid,valinux.co.jp:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,nxp.com:email,amd.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0B28A738567

DesignWare eDMA can signal completion locally through edma_int[] and
remotely through IMWr/MSI. When channels are delegated to a remote
frontend, the local endpoint side and the remote host side must not both
service the same DONE/ABORT status.

Add channel interrupt routing state and initialize it from the
controller instance configuration. Update the v0 eDMA and HDMA native
paths so linked-list interrupt generation, HDMA non-linked-list
interrupt enables, and DONE/ABORT masking follow the selected mode. For
HDMA native non-linked-list channels, use the dedicated remote
stop/abort enables without local stop/abort enables.

Keep the existing dw-edma-pcie host-side instances in remote interrupt
routing mode so their IMWr/MSI completion model remains unchanged after
local routing becomes the zero value.

Note:
- The routing mode describes where a channel should report completion.
  It does not by itself say whether this dw-edma instance owns the
  interrupt status. A local instance must ignore remote-only channels,
  and a remote instance must ignore local-only channels, even if such
  interrupts are unexpectedly delivered. Otherwise the non-owner side
  could steal the interrupt from the owner by clearing shared DONE/ABORT
  status.
- This drops the stop/abort interrupt masking that non-LL setup has
  applied since its introduction commit b7560798466a ("dmaengine:
  dw-edma: Add non-LL mode"). The databook's non-LL examples program the
  masks to zero in both directions, and with the local enables now
  cleared in remote mode there is no local interrupt left to mask.
  Remote-driven non-LL users keep the same delivered interrupts: the
  local pin was enabled-but-masked before and is not enabled at all now.

Cc: Devendra K Verma <devendra.verma@amd.com>
Suggested-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v4:
  - Document that a local instance never drives a remote-routed channel
    as the channel is handed over to and programmed by the remote side.
    (Sashiko)
  - Rename dw_edma_get_irq_mode() back to dw_edma_get_default_irq_mode()
    and simplify its implementation. (Frank)
  - Drop redundant dw_edma_get_irq_mode() call from
    dw_edma_alloc_chan_resources(). (Frank)
  - Drop unnecessary new-line drops. (Frank)
  - Simplify by just using DW_EDMA_CH_IRQ_REMOTE instead. (Frank)
  - Drop unnecessary chip->irq_mode. (Frank)
  - Revise int_setup for HDMA.

 drivers/dma/dw-edma/dw-edma-core.c    | 10 ++++++++
 drivers/dma/dw-edma/dw-edma-core.h    | 13 +++++++++++
 drivers/dma/dw-edma/dw-edma-v0-core.c | 28 +++++++++++++++++++----
 drivers/dma/dw-edma/dw-hdma-v0-core.c | 28 +++++++++++++++--------
 include/linux/dma/edma.h              | 33 +++++++++++++++++++++++++++
 5 files changed, 99 insertions(+), 13 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index 704d8f9746e8..1c6db2c381e2 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -255,6 +255,15 @@ static void dw_edma_device_caps(struct dma_chan *dchan,
 	}
 }
 
+static enum dw_edma_ch_irq_mode
+dw_edma_get_default_irq_mode(struct dw_edma_chan *chan)
+{
+	struct dw_edma_chip *chip = chan->dw->chip;
+
+	return chip->flags & DW_EDMA_CHIP_LOCAL ? DW_EDMA_CH_IRQ_LOCAL :
+						  DW_EDMA_CH_IRQ_REMOTE;
+}
+
 static int dw_edma_device_config(struct dma_chan *dchan,
 				 struct dma_slave_config *config)
 {
@@ -1016,6 +1025,7 @@ static int dw_edma_channel_setup(struct dw_edma *dw, u32 wr_alloc, u32 rd_alloc)
 		chan->configured = false;
 		chan->request = EDMA_REQ_NONE;
 		chan->status = EDMA_ST_IDLE;
+		chan->irq_mode = dw_edma_get_default_irq_mode(chan);
 		INIT_WORK(&chan->irq_work, dw_edma_irq_work);
 		atomic_set(&chan->irq_pending, 0);
 
diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
index a6a9ed09fe1b..3ea384706b1b 100644
--- a/drivers/dma/dw-edma/dw-edma-core.h
+++ b/drivers/dma/dw-edma/dw-edma-core.h
@@ -83,6 +83,8 @@ struct dw_edma_chan {
 
 	struct msi_msg			msi;
 
+	enum dw_edma_ch_irq_mode	irq_mode;
+
 	enum dw_edma_request		request;
 	enum dw_edma_status		status;
 	u8				configured;
@@ -236,4 +238,15 @@ dw_edma_core_db_offset(struct dw_edma *dw)
 	return dw->core->db_offset(dw);
 }
 
+static inline bool
+dw_edma_core_ch_ignore_irq(struct dw_edma_chan *chan)
+{
+	struct dw_edma *dw = chan->dw;
+
+	if (dw->chip->flags & DW_EDMA_CHIP_LOCAL)
+		return chan->irq_mode == DW_EDMA_CH_IRQ_REMOTE;
+	else
+		return chan->irq_mode == DW_EDMA_CH_IRQ_LOCAL;
+}
+
 #endif /* _DW_EDMA_CORE_H */
diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
index 377812eaa110..14700ac42fa8 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
@@ -254,6 +254,9 @@ dw_edma_v0_core_handle_int(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir,
 	for_each_set_bit(pos, &val, total) {
 		chan = &dw->chan[pos + off];
 
+		if (unlikely(dw_edma_core_ch_ignore_irq(chan)))
+			continue;
+
 		dw_edma_v0_core_clear_done_int(chan);
 		done(chan);
 
@@ -265,6 +268,9 @@ dw_edma_v0_core_handle_int(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir,
 	for_each_set_bit(pos, &val, total) {
 		chan = &dw->chan[pos + off];
 
+		if (unlikely(dw_edma_core_ch_ignore_irq(chan)))
+			continue;
+
 		dw_edma_v0_core_clear_abort_int(chan);
 		abort(chan);
 
@@ -329,7 +335,16 @@ static void dw_edma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
 		j--;
 		if (!j) {
 			control |= DW_EDMA_V0_LIE;
-			if (!(chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL))
+
+			/*
+			 * A local instance never issues transfers on a
+			 * remote-routed channel: on CHIP_LOCAL instances,
+			 * REMOTE routing denotes a channel handed over to the
+			 * remote side, which programs the linked list through
+			 * its own instance.
+			 */
+			if (!(chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) &&
+			    chan->irq_mode == DW_EDMA_CH_IRQ_REMOTE)
 				control |= DW_EDMA_V0_RIE;
 		}
 
@@ -406,12 +421,17 @@ static void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
 				break;
 			}
 		}
-		/* Interrupt unmask - done, abort */
+		/* Interrupt mask/unmask - done, abort */
 		raw_spin_lock_irqsave(&dw->lock, flags);
 
 		tmp = GET_RW_32(dw, chan->dir, int_mask);
-		tmp &= ~FIELD_PREP(EDMA_V0_DONE_INT_MASK, BIT(chan->id));
-		tmp &= ~FIELD_PREP(EDMA_V0_ABORT_INT_MASK, BIT(chan->id));
+		if (chan->irq_mode == DW_EDMA_CH_IRQ_REMOTE) {
+			tmp |= FIELD_PREP(EDMA_V0_DONE_INT_MASK, BIT(chan->id));
+			tmp |= FIELD_PREP(EDMA_V0_ABORT_INT_MASK, BIT(chan->id));
+		} else {
+			tmp &= ~FIELD_PREP(EDMA_V0_DONE_INT_MASK, BIT(chan->id));
+			tmp &= ~FIELD_PREP(EDMA_V0_ABORT_INT_MASK, BIT(chan->id));
+		}
 		SET_RW_32(dw, chan->dir, int_mask, tmp);
 		/* Linked list error */
 		tmp = GET_RW_32(dw, chan->dir, linked_list_err_en);
diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
index 44e7b6c1263c..cc908ca24061 100644
--- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
@@ -52,17 +52,25 @@ __dw_ch_regs(struct dw_edma *dw, enum dw_edma_dir dir, u16 ch)
 /* HDMA management callbacks */
 static u32 dw_hdma_v0_core_int_setup(struct dw_edma_chan *chan, u32 val)
 {
-	if (chan->non_ll)
-		val |= HDMA_V0_STOP_INT_MASK | HDMA_V0_ABORT_INT_MASK;
-	else
-		val &= ~(HDMA_V0_STOP_INT_MASK | HDMA_V0_ABORT_INT_MASK);
+	val &= ~(HDMA_V0_LOCAL_ABORT_INT_EN | HDMA_V0_REMOTE_ABORT_INT_EN |
+		 HDMA_V0_LOCAL_STOP_INT_EN | HDMA_V0_REMOTE_STOP_INT_EN |
+		 HDMA_V0_ABORT_INT_MASK | HDMA_V0_STOP_INT_MASK);
 
-	val |= HDMA_V0_LOCAL_STOP_INT_EN | HDMA_V0_LOCAL_ABORT_INT_EN;
-	if (!(chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL))
-		val |= HDMA_V0_REMOTE_STOP_INT_EN |
-		       HDMA_V0_REMOTE_ABORT_INT_EN;
+	/*
+	 * DWC PCIe DM Databook 6.10a-lca06 remote non-LL examples
+	 * program LSIE/LAIE=0 and RSIE/RAIE=1. Use the HDMA remote
+	 * enable bits directly for stop/abort routing.
+	 *
+	 * This is unlike the eDMA LIE/RIE and HDMA LL LWIE/RWIE paths:
+	 * those pair local and remote enables and mask the local interrupt
+	 * path, but HDMA stop/abort has separate remote enable bits.
+	 */
+	if (chan->irq_mode == DW_EDMA_CH_IRQ_REMOTE)
+		return val | HDMA_V0_REMOTE_ABORT_INT_EN |
+			     HDMA_V0_REMOTE_STOP_INT_EN;
 
-	return val;
+	return val | HDMA_V0_LOCAL_ABORT_INT_EN |
+		     HDMA_V0_LOCAL_STOP_INT_EN;
 }
 
 static void dw_hdma_v0_core_off(struct dw_edma *dw)
@@ -147,6 +155,8 @@ dw_hdma_v0_core_handle_int(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir,
 
 	for_each_set_bit(pos, &mask, total) {
 		chan = &dw->chan[pos + off];
+		if (unlikely(dw_edma_core_ch_ignore_irq(chan)))
+			continue;
 
 		val = dw_hdma_v0_core_status_int(chan);
 		if (FIELD_GET(HDMA_V0_STOP_INT_MASK, val)) {
diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
index 1fafd5b0e315..1007122d4123 100644
--- a/include/linux/dma/edma.h
+++ b/include/linux/dma/edma.h
@@ -60,6 +60,39 @@ enum dw_edma_chip_flags {
 	DW_EDMA_CHIP_LOCAL	= BIT(0),
 };
 
+/**
+ * enum dw_edma_ch_irq_mode - per-channel interrupt routing control
+ * @DW_EDMA_CH_IRQ_LOCAL:     local interrupt only (edma_int[])
+ * @DW_EDMA_CH_IRQ_REMOTE:    remote interrupt only (IMWr/MSI), without
+ *                            delivering local edma_int[].
+ *
+ * DesignWare EP eDMA can signal interrupts locally through the edma_int[]
+ * bus, and remotely using posted memory writes (IMWr) that may be
+ * interpreted as MSI/MSI-X by the RC.
+ *
+ * For the v0 eDMA linked-list programming path, DMA_*_INT_MASK gates the local
+ * edma_int[] assertion, while there is no dedicated per-channel mask for IMWr
+ * generation. To request a remote-only interrupt, Synopsys recommends setting
+ * both LIE and RIE, and masking the local interrupt in DMA_*_INT_MASK. See the
+ * DesignWare endpoint databook 6.30a, Linked List Mode interrupt handling
+ * ("Software Programming of an Endpoint's LIE and RIE Bits for Linked List
+ * Transfers", Attention).
+ *
+ * A local (DW_EDMA_CHIP_LOCAL) instance never issues transfers on a
+ * remote-routed channel: REMOTE routing on such an instance denotes a channel
+ * handed over to and driven by the remote side, and the recipe above is
+ * applied by the driving instance.
+ *
+ * HDMA linked-list watermark interrupts have the same LWIE/RWIE guidance. HDMA
+ * non-linked-list mode has dedicated local and remote stop/abort interrupt
+ * enables, and the remote CPU programming examples use remote enables without
+ * local enables.
+ */
+enum dw_edma_ch_irq_mode {
+	DW_EDMA_CH_IRQ_LOCAL	= 0,
+	DW_EDMA_CH_IRQ_REMOTE,
+};
+
 /**
  * struct dw_edma_chip - representation of DesignWare eDMA controller hardware
  * @dev:		 struct device of the eDMA controller
-- 
2.51.0


