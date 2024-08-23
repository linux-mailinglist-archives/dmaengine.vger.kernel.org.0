Return-Path: <dmaengine+bounces-2938-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16A8995CA50
	for <lists+dmaengine@lfdr.de>; Fri, 23 Aug 2024 12:19:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 325681C2105B
	for <lists+dmaengine@lfdr.de>; Fri, 23 Aug 2024 10:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D309213AA3F;
	Fri, 23 Aug 2024 10:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="PiG7tpIU"
X-Original-To: dmaengine@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2077.outbound.protection.outlook.com [40.107.117.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C641BF3A;
	Fri, 23 Aug 2024 10:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724408393; cv=fail; b=X8LR0lUGSysbwQjWCDjSotpPrcCiif1xK5FPAKulL87UboDB3J8osvdCRjyNcWRUjEd6YOMlkxrq+/v+bW3tQ82jAvLZczCgDjDULod4Qb0bbYPp3acK5aRy3wI/p6u0hog5GjnJmDm6snvwWnCDddF4jByflHrcW6hryk7UBX8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724408393; c=relaxed/simple;
	bh=btm2JgdSLGnftlhe1Xs8q1GCqCXt0nDV9CkkktaAy7w=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=BZQ5uqHyY0/cXC0rK0xILxA/XGhnPWJC1VMcmlJNMn9qcPLgaeBWVoDmHlI7R53BxE9xE8y7CaKdBAsZ4VHyKLEMXAvLSyv8LcszsHqlhrE5wq3AKxocJF3/EDi5JvC1+Ly7AQAlj+pO16fDFE6gXpdW5xKtor1G8xnJ67DsIFY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=PiG7tpIU; arc=fail smtp.client-ip=40.107.117.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cGqsFhCIW95YGhVnLVYiBis6YW8dm0rJ5VLeRo3xU5qgiW/M8ycDcFbxtCeaHtO8eD/moCoCtxRePGbTUOgjp1YM661gRtfB1e1ZTaiYRYNM0VOV4T1re0bpq1ADbP0f6VpGo56fMeWGgxs1yKWrdjBxkmpgXNHzKBROdnb9Aa6FA8RiRx5XWntkpHS1TMPJ3fIrR5oIIkHrewI94BP+jbmI3lCIa57CmDTBH049Fh5CE33qKnYQD6vmlNIBWMyCVDugQ49orzcoGfIg/scXDRiHZBUTtKv1R4KkvdOQBG5UJIrwaismHY12OCqh/EMglnkZH/cdULKepM9XmF1+ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=toT7Y0rXFSpz0QJijd+CyvrL8ZdHRq0i8XED9aPmhV4=;
 b=fQ2w3468WNPNhittyW9r6E11dMGM/jyfSVT8pb/JM3lMu7z2Rk2Nt6tOzbhP/PxXGqylNIWmeC1MCN12vs/3cvNU72eTMJAk8Wexo9uLP+vQlD7blH9zGrEYJt6CYmOWa6tGZoSqnnuM3LKHUibixNtva/9Ae/nlw7J2tMSmScLNSieszH5Od0l1pNFsr2G68GnH1kG+EBc0DOXNywFL5tHcOaHoYRuGfqPAyDoouNqJgKBLSScPrzGrYds8FicgXiPMHtjdr4w8ca2gIl4bd3w+mIn1sErV+wQI67eJIqyQrmKOkzgZ+30o1dYGvUmLnrGQsO4FLq/BZPR5Oviu+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=toT7Y0rXFSpz0QJijd+CyvrL8ZdHRq0i8XED9aPmhV4=;
 b=PiG7tpIUjGxHlmIFM8pFaGI+cVDu82uUCvIjJOa6z9epH/I3y8rLoV7RqERmRG+gHItb1KE7DwycJDuRgWqShTpQUzoc/mhgVTQ27vp/nuDsZotbax/oJga/Q+RX4E4e3PN90P00TJRY+UiPyIGJDilLAzmJ2yxB0oOcGGrS9xtCgONcTL9RwOmjA3qqKiC4PK7msgEKjXPLRTNY8gRGYACbR4kys6RG0GZwAQPAv9rxiyaGae0Dp4gr6h1rNweP/CnGmj3s0y8YJQSblOTSLIq+hjocxYl/4KYUIAzyMnaa7WZ+YCZhPrzO2XISa03f0fRB18GrHI0GzMdTJLtdBw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com (2603:1096:101:c9::14)
 by TYUPR06MB5873.apcprd06.prod.outlook.com (2603:1096:400:345::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Fri, 23 Aug
 2024 10:19:44 +0000
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6]) by SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6%4]) with mapi id 15.20.7875.023; Fri, 23 Aug 2024
 10:19:44 +0000
From: Liao Yuanhong <liaoyuanhong@vivo.com>
To: vkoul@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Liao Yuanhong <liaoyuanhong@vivo.com>
Subject: [PATCH 0/6] dma:Use devm_clk_get_enabled() helpers
Date: Fri, 23 Aug 2024 18:19:27 +0800
Message-Id: <20240823101933.9517-1-liaoyuanhong@vivo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0024.jpnprd01.prod.outlook.com (2603:1096:404::36)
 To SEZPR06MB5576.apcprd06.prod.outlook.com (2603:1096:101:c9::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5576:EE_|TYUPR06MB5873:EE_
X-MS-Office365-Filtering-Correlation-Id: 9536f5bf-bf85-4ed9-47b3-08dcc35d1b7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Fb9EsEgdcqF3Wau8Tfbmop0VTbeclyhigiT6Ve6KeNHEh7t8LAMj92LEvcj3?=
 =?us-ascii?Q?dYVMmXHHFZUCDwVIwzVjaNI+diP66ZoEYpvlRDldXsaC1nvMeGjBIRkIjj8f?=
 =?us-ascii?Q?Rwk4nl9lDY4Dy5g6T9brMeXAru8dAPR6ELPOrfVjRn0SmKP3AByjvad+5gUW?=
 =?us-ascii?Q?Rj+/tFPDz/DPthWcz7LOazwYz4uQYMNAqaQJ3F6CTM8Dr5xzpa49gJ6LZe7V?=
 =?us-ascii?Q?I1CKQMYsXo7wPzOo4hGRTSjV/MaYz2NJmxqJkvjXPxhJ4EzLtuobLQC4NbNI?=
 =?us-ascii?Q?FBuUYI4dqVzb0fMnXd50qrlgNcwBj3crUc+mDS3h9RKd446h1DLOkrw0ikBi?=
 =?us-ascii?Q?w5Ibfi0HAkqLx33bojRlESD09g5GVyg1bUyYlPcRuVM4WU1dhrIj5IG+C1Ut?=
 =?us-ascii?Q?2R2h5862jfRbyFJdOjn+cerLl9dhvZ+E6AwB94pn8G14bvhQjxPC6uyMvIN6?=
 =?us-ascii?Q?2T+3hcyKwRz6JPW4YOoSNgAFqetn2wfMAHweub5+bjvNN+fM3g3gC80CcYXm?=
 =?us-ascii?Q?UbevxHO6m48JL6q8EITZMJne7xU6mIz2hgNyAtIioQ2x/XuHNzwNP6yUcNrm?=
 =?us-ascii?Q?Pyw674FROhpPTElwfE9R9uzjvUqBx2lvZpAbuyyguSWBux4tOa1IkGksu9kU?=
 =?us-ascii?Q?FpxfG6DCYjJurv93bPlI9qNzAjFwZ4LKx1mLg7laut8LsCVer4V6VlIwMqgJ?=
 =?us-ascii?Q?EzXTwiogQ+94smN5VGK0N+QCGvEbkH2eqOGs6o1BZxp3SJhCgGFf2EgZn9l9?=
 =?us-ascii?Q?AY3nrHtlqbYRegDG1SQgX1nGJo1Jz/62CXjyxFy8lfnlK0vp69cW7LxZNqZS?=
 =?us-ascii?Q?rvfOxYHmUV3naoybbzdpWUd4WhoMJOoS99qpaXlz9BvRfQlZIvN9UW3vxDRR?=
 =?us-ascii?Q?y8fwsmjwGy9QKhizXkxaJloiI4NQmitjwI4borM1/qR0pp6NDxLA21C7L3Um?=
 =?us-ascii?Q?ZPwRPAXS4kXAQL+IY3gIjvdmv8sRmD1CAoW+zHKvadcscrj9DoQJ2HeBU3i0?=
 =?us-ascii?Q?yGiPIlI6p63FQyzWQIGBxj0oxgsPH52eKW5AFIZnwfEHSiEvArNws/1YAJWZ?=
 =?us-ascii?Q?6YAk751R+JXBrfjOvjk+M5YYoq54IlvvZ7UPQ15EqJfvKkYXmq0+66Ll4rqp?=
 =?us-ascii?Q?E/+YsUQsCkHh4MMkKPyTXO6Lxx4YV18tJ+yKpbn40BWoL+03CHjZ1vlT/2ES?=
 =?us-ascii?Q?6mrXLPqW1MkDeu7DdMGgCVcjWki4sKdIxdBGnH+OtVCNarORJoRRfumkp9sL?=
 =?us-ascii?Q?ZGgwQqI3CbJxcvpMwCEsjvDe1kBR0K+nKjwX1NvzIS4PBUxheI04l0sm8+fY?=
 =?us-ascii?Q?mGgjyRYlJLxiJEffh1RjMRgVKHd8RHhkmOYKxKxrBfIY6Dg39uk6MKgWDXh2?=
 =?us-ascii?Q?hdpYyOAshL6HaDF62wFi6d+7dA9rbrR6BgLIPhkDUmCHaE9xIg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5576.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sleilQM94avwQ7khvzIMRTlK1Xym+Bj9MmtxzQkvp1vcLXHevj2oOPbNa7pg?=
 =?us-ascii?Q?RiQKGsHsa1GQhuN/jpoeMKncaWFMQ+VoMS7Vm25SHKtyQyPIF/uEdPI3EfPI?=
 =?us-ascii?Q?+M1T1UVumo31DpFFwX1Y/aJ4UzbQtcKdC+rAla9DbwbfNGSaS8R1aFVNlod+?=
 =?us-ascii?Q?eBtcpFnVMAxRSbWy5qYd1/91mxKnjTVo/n4WIWNhk7i3JM32bAkRvXql1aXk?=
 =?us-ascii?Q?Gqi7nKGOFcR3azRp0Sv2+d6ukVhQlJU0gJuRfhNh5TNG4Qutvti4iQAmU2b1?=
 =?us-ascii?Q?uuaBtI3o2z726OFgv3p8zYpWQd5ENvCrc0MjT5CPxOYcvNrmmisssejTgc5h?=
 =?us-ascii?Q?BXDHZbrqNxOwimzjHIjlkNoBJAAcpD+lagBSCG8n6xTMiZfSFGhsEZ9RaQuA?=
 =?us-ascii?Q?UqOgKP0aowWfAiSb/HNr+z5uIOWXxSHIEg5akvt49c/YdMgg7/6HyITduLnw?=
 =?us-ascii?Q?kbPrrhBHpdESDJATxiarNFruG+rIj6teC8VsgUqGNLw/AveGxLJVP6Y0Vw25?=
 =?us-ascii?Q?ZsNPrlEdg8EUa17AGFdMXyH4dKk+ULmTfZiCPcc+QAe2pP599W+dB30t0Swh?=
 =?us-ascii?Q?kK5i+XKYoRfTvehbpvFLNQpLNQK6NMAJZl2TKtuoK7CQVyuF4CDOSq2nhmm7?=
 =?us-ascii?Q?64NhC1Hx9I4JHcXvwh22ChE1FCz0bwxHxcYJcMhvOSZ4aNkuwr+me8VfutMO?=
 =?us-ascii?Q?oCglJJhk++qBrbu2Ys4s+r4Gk5BCD2e9ir0PaNernyRl79d/DUTngn91Ub6w?=
 =?us-ascii?Q?IHtOBonHjzcJB1Q5XrzBGix1Dmw07DdJaY5foE3TfejC/LuDCC0+tD/Ic7Jr?=
 =?us-ascii?Q?bjQrvdj9lO9Htl18rVohJgjGWWpeX7u1gOwkVQeyekwRQy5r5gd2g9rgeDin?=
 =?us-ascii?Q?FqDZZCWNDkHumkjdm/OT4EW2vNdWy6hGUIGia1s/8z+CNDy0GrmofRzHj9nU?=
 =?us-ascii?Q?X3oHWwC+B7RdZDr+nAp6JK/jkbzGihTGImiD0JT6sEdYsohZVxJ6tFrafiP8?=
 =?us-ascii?Q?QfyRXWcXjWOYqAbT85KGRJ0fEgeB9pChadcw/8FuKHuVvdhsECDI1nH+2OX3?=
 =?us-ascii?Q?7ozc3EA72saflR/v1s8tylH9llOoT/ERwLkXhXDXNCoBt9SR1TKM2SKAJunx?=
 =?us-ascii?Q?VZIN4dJ/WsV6eJ4MhOGMgkq8mkhOx+GqyxH2rXvr0lqhqObVQnqEv5LoALee?=
 =?us-ascii?Q?RtXfWgaAwWl+Q4OIIMa3lhffEo79PJ/SSLmmyeSRfqFQTD09BZ+gMdrxMoLX?=
 =?us-ascii?Q?Hpov1dMjWZebvZeXFf6rigrJ+Db7f7vRt5spfzfD0kcWEsN4KtXbLD5V3WUE?=
 =?us-ascii?Q?IzCn7MaBqA6XpmXww+kP1JjYidhg3JF9qIZCcK7HCYkRepgsG7Del23wDCUr?=
 =?us-ascii?Q?fr0S3bAM8r/7FlqeLT7HOuY9d9Pj2U3g7XCqslp2RI7hajx5Ob/JWwYZlZqV?=
 =?us-ascii?Q?jBu/iBWc+DjT5UQCX3qPlAkTUOAv7EMM442/o9Ip280onNOkFPcCQFAqmazN?=
 =?us-ascii?Q?PxXGaOq3PyYzbWyWb5xgoZSF+U7lXXFV8JlJxwQtL5hoYZYE3YIPicSdqTA/?=
 =?us-ascii?Q?mFj0FS1Kik+nqgQ5w1ejpgnThFUGdpWg/Foh67PG?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9536f5bf-bf85-4ed9-47b3-08dcc35d1b7d
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5576.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 10:19:44.3002
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k87pS+b5jg9kSEqMhMW4R/JYfZ0KMPY59WmOYlyqMELKsKD9FHcFvQzmwH74LPs19N59EiiPmmOGyUnUdPFTog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR06MB5873

The devm_clk_get_enabled() helpers:
    - call devm_clk_get()
    - call clk_prepare_enable() and register what is needed in order to
     call clk_disable_unprepare() when needed, as a managed resource.

This simplifies the code and avoids the calls to clk_disable_unprepare().

Liao Yuanhong (6):
  dma:at_hdmac:Use devm_clk_get_enabled() helpers
  dma:dma-jz4780:Use devm_clk_get_enabled() helpers
  dma:imx-dma:Use devm_clk_get_enabled() helpers
  dma:imx-sdma:Use devm_clk_get_enabled() helpers
  dma:milbeaut-hdmac:Use devm_clk_get_enabled() helpers
  dma:uniphier-mdmac:Use devm_clk_get_enabled() helpers

 drivers/dma/at_hdmac.c       | 22 ++++----------
 drivers/dma/dma-jz4780.c     | 18 ++++--------
 drivers/dma/imx-dma.c        | 38 ++++++++----------------
 drivers/dma/imx-sdma.c       | 57 ++++--------------------------------
 drivers/dma/milbeaut-hdmac.c | 20 ++++---------
 drivers/dma/uniphier-mdmac.c | 20 ++++---------
 6 files changed, 41 insertions(+), 134 deletions(-)

-- 
2.25.1


