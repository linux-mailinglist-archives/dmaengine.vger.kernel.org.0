Return-Path: <dmaengine+bounces-8824-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qCRSNh1fiWn07gQAu9opvQ
	(envelope-from <dmaengine+bounces-8824-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 09 Feb 2026 05:14:21 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7752810B87D
	for <lists+dmaengine@lfdr.de>; Mon, 09 Feb 2026 05:14:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9972030053D4
	for <lists+dmaengine@lfdr.de>; Mon,  9 Feb 2026 04:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13194265CDD;
	Mon,  9 Feb 2026 04:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="EPNkqlEC"
X-Original-To: dmaengine@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021120.outbound.protection.outlook.com [52.101.125.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3151CEADB;
	Mon,  9 Feb 2026 04:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770610457; cv=fail; b=UTbVftm3seV8T/r/gfLHd29KsAqo0jjL5jwsw4WMwQ1AitwolWskZ4KplO4Wd/slEp5OCnbAbjA4g/hpwgkTjtgboGDSrKC2hB2wd4Vxp3DAf2TeGFrrElQ1PHiNabxzqkzVrmjmAPM31bAdAxtOYzOYdbXxwxFiueo34yti+5M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770610457; c=relaxed/simple;
	bh=E2xnEfZFkzAHYOEqHMpJW03F1LcNoIeRQca4ZMNyk0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=G4EGWbYc3MldgIE3UdaIcWnc+SkjSXGkcmS5WJSBN5oNDZFYCUi4ejpMn5tDv/QUaHCCfJSIWFMOBD4PuXv82MfPV72ttsVjpFawIULMXIN055zf49Byx5J6x8FpzptZWRTkBYFLP/dcwndDR/VwnVfyBZFWNKq2e8cwb0uKz3g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=EPNkqlEC; arc=fail smtp.client-ip=52.101.125.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X29deZoeTYgixsch2tRmm7qhOrGOgwTumeeswETEHMr5szqUx3VQqUo0rZakfdA+tyQX3OQ2Fi0xvIgVpgtVatzQTdQtNL1LyB8aCMJDaj1dzF4zkS1kzEyCAa3coSMxgayXsSe6ddofr8diAxmV9OqiVgV+JemMovFEiolX6ZUPdan4SPLl0nLfUUvkBVIfulpCKrGItIt74fomo9Y8+rdKWoSvvhJ6593uY/JAT/JPsghJN9G6Jze4SzVsHDBtkxRBBWXeBrsFQ+DMxIyCkHChw+73GUsu6G09bSmMjPVKgKNuDOSfKGUkSjpfJp6lFZLr6DXVV7iBgKiKethp9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HNKKbmzA+2oKrdN4rPNOluy24TPjc7iJjLDrZYPs6qI=;
 b=VsbDVhT40TGn+oLTWGSPD9KWt+tA6qTXE14+QKoQwD0VdtsIhYfEPNgYRJiI+AmS+Crm1xXhtTTGB1q3+kX6JpXRgyYLbPIEkpGj/qX7ChEcSEL2x3uEPewm9mdQVcvj0sq8Vuk/pMK1Zink5Oa01qrPsvpanf5ooGCprC6vzt3LvlP+WlFdS/CfsjaekTf2qOiphO/nO2Wklv9n9AN5Aqisi5aFL+OhvFbrhgXxyW/b3lh387tGclP2OJeUFK99U7sEbxw+Py1sfJ3xZt1g3FFTmhwNlIGRc94iibCoGqoEiEBI1IJl1T9apEKixLsPz6930+hXm+IHXNeJFbtPEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HNKKbmzA+2oKrdN4rPNOluy24TPjc7iJjLDrZYPs6qI=;
 b=EPNkqlECalckozcDsyETxMJBP9vNbbRHHACiYkK5Apywrmmg3soacirwh30Z5PfHUZhiowr1Tsc8li3//ZccYd2SKos9QY4jby9CwIDdHXfc0YhWnTJIZTZqLZSFrJY3F6gBXDUBRqdVp4gx6PZmeVGFYwl7G8DH+4yh9ZsDDAg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY4P286MB7494.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:351::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Mon, 9 Feb
 2026 04:14:13 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 04:14:13 +0000
Date: Mon, 9 Feb 2026 13:14:12 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Frank Li <Frank.li@nxp.com>
Cc: vkoul@kernel.org, mani@kernel.org, jingoohan1@gmail.com, 
	lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org, bhelgaas@google.com, 
	dmaengine@vger.kernel.org, linux-pci@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/9] dmaengine: dw-edma: Export per-channel IRQ and
 doorbell register offset
Message-ID: <tpntwbsnraa4dcguhshrqmocnc3n4qik6ezr7hacrcwcq5emd3@ba2bsucpnxmo>
References: <20260206172646.1556847-1-den@valinux.co.jp>
 <20260206172646.1556847-4-den@valinux.co.jp>
 <aYYrSM1oOz3_u6Na@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYYrSM1oOz3_u6Na@lizhi-Precision-Tower-5810>
X-ClientProxiedBy: TY4PR01CA0008.jpnprd01.prod.outlook.com
 (2603:1096:405:26e::9) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY4P286MB7494:EE_
X-MS-Office365-Filtering-Correlation-Id: d9ddddde-7e13-4d01-0152-08de6791aea6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|10070799003|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IL2gHQT3VjTjBBtDNHRzC2lOPCpc5U94WKAyNc8NIPnK8AKFF2qFefqUXY37?=
 =?us-ascii?Q?0lGTUcfyh3GTMt+lLDybgQV1WRRb6gUeywZG55Of5XF/uQ27uz9fYN8fwpp1?=
 =?us-ascii?Q?0rudsrTI5UJtoZ9o5wL4xZq3H9jfTU2EtKcbh7bZmd0vfqzXMahYYeDEPPqH?=
 =?us-ascii?Q?rW8JhuW/fSqO9RPrivKC6raPq/qDeKZnlxdJtCensyCPUy6dL85f/UCeaXlY?=
 =?us-ascii?Q?hZghpZhAc0ywzCW8p3sasSJltZYOid5mNk0QNPV6VjRD3UJ2Dt4VRpomPGXq?=
 =?us-ascii?Q?9iw1nAiV4+CpeCSlRGAQ1fHv2hAn3xGYJ68OMAj+pMZVUZmBOtSqmGzMLOYM?=
 =?us-ascii?Q?b04sh/wbaiKR6d0h2hyWwTTyCRTPaqXAdl3l2vkW96TEOx5rVV5JAKatRPWm?=
 =?us-ascii?Q?xlujSrvGyvmND3q91zHo6Kb31XWtAM6ZW8ZWlPOLeOzC7VAfOfkGTXcNR58K?=
 =?us-ascii?Q?76pXjEoaXnfh+yWDceWQZ/ofTFLzwiTp5fvJVKHvEIgIBw/HAQgiVxIlfPB6?=
 =?us-ascii?Q?HSbLQLq2vEvgDi3AFyQKu6N6BLp425IbXd0kAe1/8t5XNwM7y6fBlQGXa7Rp?=
 =?us-ascii?Q?81gK956oVICW/uGil4Zq3yIzGP0POgVnLkIB33JuCqmwwXiV1giMidg72EMX?=
 =?us-ascii?Q?97x8FgMxom4hCaR3fUV8EpCqIVXJM78oVWcdWw6JTVVpin9Jjk9k6fO6mqaN?=
 =?us-ascii?Q?TqPhGj4V7CblYmYhdepQUMKQ0DMlGvx3QOm9gmKfgEJ3lMvjsgDQPW55FUrs?=
 =?us-ascii?Q?JYNlwrr1OEzLMR4OxDk095iKCrr5tpcBb/koK3NPEqUFUZxH+Yk+50Kw3bPQ?=
 =?us-ascii?Q?9gITZlRnIxnxfa9uRP7tdTnE3p4/dZvk6EibztDY3lDAoJt/VgZQkSekQIGm?=
 =?us-ascii?Q?ut6kdhplZEOfQ/etQp7tlcRvvdvxiSssAzWDoe1ZWeKvFq+e67qll63JcDSs?=
 =?us-ascii?Q?eY33DSw02fAZmM490ywsir64fys2/SfS5ILLYAraaId7Jokx1F5+ZF75HCGY?=
 =?us-ascii?Q?V3/5WqIOf97soAPLxybf5BURL9Onj67dWYv9UXGNb5Ytkk37WbGugFPQ7mkB?=
 =?us-ascii?Q?xP2ZBr+KC3BUyPcPP82Kvyuv8Qnfy5Hw/fTKdBJZ/kVHeBfhPOayQWP5kPrx?=
 =?us-ascii?Q?j5Va1cXxoMNceXsKutNVrvmk4WyfW23QagYk7OSAuYBRWqPJ4DQ+7ykKvwY8?=
 =?us-ascii?Q?otrbS5TyiGC9zcXOWBZ0UxiVIlBiaZXr+v/Cp6y7/Dlu5h3+EN6inl0UAlbd?=
 =?us-ascii?Q?vHC+vKdt/MFq5iG+fdIEA/SCXd4r03pKKH48H+wE25NrXwDKcXeIKabFFvmq?=
 =?us-ascii?Q?4HzNEl87AYwhz/rA0c+IKazM9SYkRqYq8JNSKO0u3ZRLiNa1TbYO1/9HLYmJ?=
 =?us-ascii?Q?PqjZqlh4rIAwB6eEJqJn/kGwDFSsrq3qty2P+2jxsBel4tSqY3h5zSxFmvVG?=
 =?us-ascii?Q?dUdoLt0ZCrUWxzfutZ9mANy+1MFxTwZwB7NXvDABarBypESk5cd71H8saZ2A?=
 =?us-ascii?Q?fVcmh8Mdcql6/wAD/pC0DYN0/ozWuRoiTXxLB8jcFEmweLQ6UAHcB/VQbGFk?=
 =?us-ascii?Q?HKdQqfAxTPvp8sHpOjM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(10070799003)(7416014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?twjbzl9ICj3ZI/zbwidjxuwuOu1FNYURRkNxcep41PuKtR47wbnuXYgUMMa/?=
 =?us-ascii?Q?WRbj8R8SKannUi1xTzFPyYS5Vje1hkPLBswUN9ziETBSa6mi4OfTI5pUuIpv?=
 =?us-ascii?Q?rKcfH5Jk5S90cN4yAOpsyW627SLwP/wZAu3NdsrzL+FOJZT06+96fAIiBE5I?=
 =?us-ascii?Q?p86c6GzAioJQUw9A+Vf7X0tHNL3lSOQtwMX+Ws4ZO3k7Vp2x3Wqdeqr7epND?=
 =?us-ascii?Q?V/ETZY0CaoyZvYEn4VkHreoYavPjyiPwNac2wVQiy6UlqhEbAdWXuMwSESAC?=
 =?us-ascii?Q?xyLEPcJdJa1wEE3WZUPT/jCLXT1yu5nycZxkP/sxCoPBWyi/cakQIgagHt69?=
 =?us-ascii?Q?+idL9iARJkxz+a8hSdY4d6pN5KDWOLTEztDjbofajv2xuYpe4kmum18v1D6/?=
 =?us-ascii?Q?GqFws2avcfsK2FOmAV/076MYghCoJ+pFGa8uVQWhzOD0p1bRFwbw9HL91bj/?=
 =?us-ascii?Q?OViocUWXjV3K6ioXjDRcA8DGdkPh7TZ7Ay3AuDEajZLJi9rWT0WgU0CwGRe4?=
 =?us-ascii?Q?Uosc96+dH0RTODcJ5m+fEhTgl4HpR2XC4hwxttX8iqjcWbNi7An/Ciq2depG?=
 =?us-ascii?Q?K30eT2MDj5Wlnk3kV6BGH+QJouhbuU+q+dd7K84oziV0ydhs4HnkVLvMfRu1?=
 =?us-ascii?Q?kz3kvKeyPEqcUpOvZ7Mo+GfJLguVuhpGUPcRMy1DI6JxYVMHHFIHnUBy4SfZ?=
 =?us-ascii?Q?jet3pqXLyAX3Uhyob+jYInYoA932OsRPQhd/AF28zm+sBm98xDY16wvLcNJn?=
 =?us-ascii?Q?7/j9FNETT+wcAs6WFVaKoYleQ765S2m7lWCkncBqSpcmg+BXlgP3Isu3l0nU?=
 =?us-ascii?Q?SQAXTtBQD1dLPKAs2144nkp9JZ1DSUNqsFxXLT+kCiYrQ7vBN7MNPKCFFxpq?=
 =?us-ascii?Q?1atIgurj31w3g9azsoY4rR0zuBJPSqgsLdV5/ie0DNrcoI+rECJC5KRhspLK?=
 =?us-ascii?Q?M4JrjkojVOt6LFjoz8YJhWzV4FeVybJ5BUSrbZ2FdvSeiM/sXRUm0j7NoonS?=
 =?us-ascii?Q?FN8R5Dayv1vI19QUedr1PFOCaNGfi0al/HwRHXMrVZbjEG9Bm05s3mHAwmUX?=
 =?us-ascii?Q?sQvodFoNbY5sKlHbgBzg5IM/ZwnyWWEBw+/ws9Jpje5YZpXSPEYsRzXa9YMM?=
 =?us-ascii?Q?yahcZg3LhZw5Kj0ev0aJfz3T2cRMmtoqPDkxOkSSPIQnc5iLBZtBn6kTP5RZ?=
 =?us-ascii?Q?eckfPEc5IAl83BHLcx+8ex/xYawxtJYLjpvG2Ak76M8u4KvaLJvXCGAB2QP2?=
 =?us-ascii?Q?UBI0MEFW+lv/zJCjNLyQfPh3gcGmMgOJrAd9fioYOSKw3d6L3v+rnjn8e5YG?=
 =?us-ascii?Q?mjA1brBcLWpfbDOUt0ya6sco0z/KpAW5I+IcEH/WSMeYQEvBbkE2xpDr+2Ch?=
 =?us-ascii?Q?XJMtAUiMdnS+8feR6oaOGLVsSVCU9m3jVRfn3WlQMiiv+CAViKawwmAIe8Zu?=
 =?us-ascii?Q?4oaxNb1FBuMH87OOTqPzjcyJggbfFJgFSA43HK6jKxxMIXoyEumMk4qiesBM?=
 =?us-ascii?Q?lGRXN+xcQDgXccM4VU2knrIwuZkLhQYmkyp+JR6aQ8wZXJnm+dyYnjso9l19?=
 =?us-ascii?Q?JtHtKgF9ge2Pmv40Ob/FyN5s5weYCZrL3tbPwQf2XZMq6sfYm2GGfUBR6/qJ?=
 =?us-ascii?Q?i0t34mUqHrVvktc0Vhp1No9nDUvRSWY04z19vmYed+D0pOlzQbtTjd5Du0G8?=
 =?us-ascii?Q?eN6ws79bLVZ2cPYtkMkF5JsLork1+GAVz7/E5sOCcIPRAT9bATJEEMiZihuN?=
 =?us-ascii?Q?OO9Uk/jDC4VBNtSPK4CyVFrYNcl9wj64wtpmlk6NVzwWgWI4/g+Q?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: d9ddddde-7e13-4d01-0152-08de6791aea6
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 04:14:13.1983
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h8tvkCNKG7S9Vt8oRhJ6GoawSXZtKU3CuelwcMQ8iWPZdRTe29zSHqaq5cQDivTRNU/2L8VDnyP3YSFtvfvZwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4P286MB7494
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8824-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,google.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[valinux.co.jp:email,valinux.co.jp:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7752810B87D
X-Rspamd-Action: no action

On Fri, Feb 06, 2026 at 12:56:24PM -0500, Frank Li wrote:
> On Sat, Feb 07, 2026 at 02:26:40AM +0900, Koichiro Den wrote:
> > Endpoint controller drivers may need to expose or consume eDMA-related
> > resources (e.g. for remote programming or doorbell/self-tests). For
> > that, consumers need a stable way to discover the Linux IRQ used by a
> > given eDMA channel/vector and a register offset suitable for interrupt
> > emulation.
> >
> > Record each channel's IRQ-vector index and store the requested Linux IRQ
> > number. Add a core callback .ch_info() to provide core-specific metadata
> > and implement it for v0.
> >
> > Export dw_edma_chan_info() so that platform drivers can retrieve:
> >   - per-channel device name
> >   - Linux IRQ number for the channel's interrupt vector
> >   - offset of the register used as an emulated-interrupt doorbell within
> >     the eDMA register window.
> >
> > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > ---
> >  drivers/dma/dw-edma/dw-edma-core.c    | 31 +++++++++++++++++++++++++++
> >  drivers/dma/dw-edma/dw-edma-core.h    | 14 ++++++++++++
> >  drivers/dma/dw-edma/dw-edma-v0-core.c |  7 ++++++
> >  include/linux/dma/edma.h              | 20 +++++++++++++++++
> >  4 files changed, 72 insertions(+)
> >
> > diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> > index dd01a9aa8ad8..147a5466e4e7 100644
> > --- a/drivers/dma/dw-edma/dw-edma-core.c
> > +++ b/drivers/dma/dw-edma/dw-edma-core.c
> > @@ -842,6 +842,7 @@ static int dw_edma_channel_setup(struct dw_edma *dw, u32 wr_alloc, u32 rd_alloc)
> >  		else
> >  			pos = wr_alloc + chan->id % rd_alloc;
> >
> > +		chan->irq_idx = pos;
> >  		irq = &dw->irq[pos];
> >
> >  		if (chan->dir == EDMA_DIR_WRITE)
> > @@ -947,6 +948,7 @@ static int dw_edma_irq_request(struct dw_edma *dw,
> >  		if (irq_get_msi_desc(irq))
> >  			get_cached_msi_msg(irq, &dw->irq[0].msi);
> >
> > +		dw->irq[0].irq = irq;
> >  		dw->nr_irqs = 1;
> >  	} else {
> >  		/* Distribute IRQs equally among all channels */
> > @@ -973,6 +975,7 @@ static int dw_edma_irq_request(struct dw_edma *dw,
> >
> >  			if (irq_get_msi_desc(irq))
> >  				get_cached_msi_msg(irq, &dw->irq[i].msi);
> > +			dw->irq[i].irq = irq;
> >  		}
> >
> >  		dw->nr_irqs = i;
> > @@ -1098,6 +1101,34 @@ int dw_edma_remove(struct dw_edma_chip *chip)
> >  }
> >  EXPORT_SYMBOL_GPL(dw_edma_remove);
> >
> > +int dw_edma_chan_info(struct dw_edma_chip *chip, unsigned int ch_idx,
> > +		      struct dw_edma_chan_info *info)
> > +{
> > +	struct dw_edma *dw = chip->dw;
> > +	struct dw_edma_chan *chan;
> > +	struct dma_chan *dchan;
> > +	u32 ch_cnt;
> > +	int ret;
> > +
> > +	if (!chip || !info || !dw)
> > +		return -EINVAL;
> > +
> > +	ch_cnt = dw->wr_ch_cnt + dw->rd_ch_cnt;
> > +	if (ch_idx >= ch_cnt)
> > +		return -EINVAL;
> > +
> > +	chan = &dw->chan[ch_idx];
> > +	dchan = &chan->vc.chan;
> > +
> > +	ret = dw_edma_core_ch_info(dw, chan, info);
> > +	if (ret)
> > +		return ret;
> > +
> > +	info->irq = dw->irq[chan->irq_idx].irq;
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(dw_edma_chan_info);
> > +
> >  MODULE_LICENSE("GPL v2");
> >  MODULE_DESCRIPTION("Synopsys DesignWare eDMA controller core driver");
> >  MODULE_AUTHOR("Gustavo Pimentel <gustavo.pimentel@synopsys.com>");
> > diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
> > index abc97e375484..e92891ed5536 100644
> > --- a/drivers/dma/dw-edma/dw-edma-core.h
> > +++ b/drivers/dma/dw-edma/dw-edma-core.h
> > @@ -82,6 +82,7 @@ struct dw_edma_chan {
> >  	struct msi_msg			msi;
> >
> >  	enum dw_edma_ch_irq_mode	irq_mode;
> > +	u32				irq_idx;
> 
> can we directly save irq_number?

Yes, that makes sense. I'll address this in v5 together with the changes
based on the discussion here:
https://lore.kernel.org/dmaengine/cuihp4wo5bcku75myq7mfbfvyddwptitiyy6pz5ldq2l6robxk@kghlibxpr7wf/

> 
> >
> >  	enum dw_edma_request		request;
> >  	enum dw_edma_status		status;
> > @@ -95,6 +96,7 @@ struct dw_edma_irq {
> >  	u32				wr_mask;
> >  	u32				rd_mask;
> >  	struct dw_edma			*dw;
> > +	int				irq;
> >  };
> >
> >  struct dw_edma {
> > @@ -129,6 +131,7 @@ struct dw_edma_core_ops {
> >  	void (*ch_config)(struct dw_edma_chan *chan);
> >  	void (*debugfs_on)(struct dw_edma *dw);
> >  	void (*ack_selfirq)(struct dw_edma *dw);
> > +	void (*ch_info)(struct dw_edma_chan *chan, struct dw_edma_chan_info *info);
> >  };
> >
> >  struct dw_edma_sg {
> > @@ -219,6 +222,17 @@ int dw_edma_core_ack_selfirq(struct dw_edma *dw)
> >  	return 0;
> >  }
> >
> > +static inline
> > +int dw_edma_core_ch_info(struct dw_edma *dw, struct dw_edma_chan *chan,
> > +			 struct dw_edma_chan_info *info)
> 
> wrap int to previous line, check others.

Thanks for pointing that out. I'll update it for the same reasons as
discussed here:
https://lore.kernel.org/dmaengine/qktad6ggosznbznej7n2luxwkhr34f3egtojzjnkry4v2balbh@sfxxoii5yxoa/

Thanks,
Koichiro

> 
> Frank
> > +{
> > +	if (!dw->core->ch_info)
> > +		return -EOPNOTSUPP;
> > +
> > +	dw->core->ch_info(chan, info);
> > +	return 0;
> > +}
> > +
> >  static inline
> >  bool dw_edma_core_ch_ignore_irq(struct dw_edma_chan *chan)
> >  {
> > diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
> > index 68e0d088570d..9c7908a76fff 100644
> > --- a/drivers/dma/dw-edma/dw-edma-v0-core.c
> > +++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
> > @@ -529,6 +529,12 @@ static void dw_edma_v0_core_ack_selfirq(struct dw_edma *dw)
> >  	SET_BOTH_32(dw, int_clear, 0);
> >  }
> >
> > +static void dw_edma_v0_core_ch_info(struct dw_edma_chan *chan,
> > +				    struct dw_edma_chan_info *info)
> > +{
> > +	info->db_offset = offsetof(struct dw_edma_v0_regs, rd_int_status);
> > +}
> > +
> >  static const struct dw_edma_core_ops dw_edma_v0_core = {
> >  	.off = dw_edma_v0_core_off,
> >  	.ch_count = dw_edma_v0_core_ch_count,
> > @@ -538,6 +544,7 @@ static const struct dw_edma_core_ops dw_edma_v0_core = {
> >  	.ch_config = dw_edma_v0_core_ch_config,
> >  	.debugfs_on = dw_edma_v0_core_debugfs_on,
> >  	.ack_selfirq = dw_edma_v0_core_ack_selfirq,
> > +	.ch_info = dw_edma_v0_core_ch_info,
> >  };
> >
> >  void dw_edma_v0_core_register(struct dw_edma *dw)
> > diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
> > index 53b31a974331..9fd78dc313e5 100644
> > --- a/include/linux/dma/edma.h
> > +++ b/include/linux/dma/edma.h
> > @@ -129,10 +129,23 @@ struct dw_edma_chip {
> >  	struct dw_edma		*dw;
> >  };
> >
> > +/**
> > + * struct dw_edma_chan_info - DW eDMA channel metadata
> > + * @irq:	Linux IRQ number used by this channel's interrupt vector
> > + * @db_offset:	offset within the eDMA register window that can be used as
> > + *		an interrupt-emulation doorbell for this channel
> > + */
> > +struct dw_edma_chan_info {
> > +	int			irq;
> > +	resource_size_t		db_offset;
> > +};
> > +
> >  /* Export to the platform drivers */
> >  #if IS_REACHABLE(CONFIG_DW_EDMA)
> >  int dw_edma_probe(struct dw_edma_chip *chip);
> >  int dw_edma_remove(struct dw_edma_chip *chip);
> > +int dw_edma_chan_info(struct dw_edma_chip *chip, unsigned int ch_idx,
> > +		      struct dw_edma_chan_info *info);
> >  #else
> >  static inline int dw_edma_probe(struct dw_edma_chip *chip)
> >  {
> > @@ -143,6 +156,13 @@ static inline int dw_edma_remove(struct dw_edma_chip *chip)
> >  {
> >  	return 0;
> >  }
> > +
> > +static inline int dw_edma_chan_info(struct dw_edma_chip *chip,
> > +				    unsigned int ch_idx,
> > +				    struct dw_edma_chan_info *info)
> > +{
> > +	return -ENODEV;
> > +}
> >  #endif /* CONFIG_DW_EDMA */
> >
> >  #endif /* _DW_EDMA_H */
> > --
> > 2.51.0
> >

