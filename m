Return-Path: <dmaengine+bounces-7735-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E46CCC576A
	for <lists+dmaengine@lfdr.de>; Wed, 17 Dec 2025 00:26:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9CBC9302E5BE
	for <lists+dmaengine@lfdr.de>; Tue, 16 Dec 2025 23:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B16833FE1A;
	Tue, 16 Dec 2025 23:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="LhQpjBop"
X-Original-To: dmaengine@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010035.outbound.protection.outlook.com [52.101.85.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A0533344A;
	Tue, 16 Dec 2025 23:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765927594; cv=fail; b=RlnDr09x59aKVebHd3wP1cFTg9I8ov626Yme1rmN4P+l119dI83DOlQm7CMQQIGiFqiGUqBPDwIwYN9127G7lo3KvMaBK202R1lqZryP5iVaFBm19GnHNpZk6E2QNNve3RBBHAGTahdw6q0br+/Z+YXXk5gHV4LYlSQAp3WWttE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765927594; c=relaxed/simple;
	bh=AhISZOHp4s6icPjyKOOhXoLLrkSbHI0hiXzV3Vui9E0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KYtkjBE2bcsvgHhc8v8HCUe5bGuw+ubxN4ctGKK28XeIZenACHNhM7R8Tmx5sRWESsyTqIwxjzQq7MQtTz+8Zww3c0t/UM3VFrkYpoSsxSy35e2M1m8WfC9Uga5viV2ooBN5Y3FRrYLTk38sUFXgvjL0/qMwX6Y9aybvNfZOCjQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=LhQpjBop; arc=fail smtp.client-ip=52.101.85.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xve4QwYtw6SNJ9LIaU9I97NKGJ+FTht6hVLN30X8+YBxA+yE153a2s0HKJGzS+wM2tDLKNzR11bLILNgX1Q4/seeGhKnI8V9SWs63DM06wkwm6J72yiyjMYgis+jNHgIObpYciS9uWBnF7kk4tc+KMRZLbs20+c1SPFGmPrlNSFRhRqpvFsivMGSx+zmIKnlXqxVSM1UFVDKvzoTr9cXe2v4duuJb3ZTXGacW60Fj16L5JCIDvBTSOGbZNuXEUbAE42o6uwZkr/Ld8Qz3i0oer6ipg6VFBQ1CWT1HSXzAlU34lDdDIlZDvGKrtnhRKZLfXB7ae+CfMQxoTZ41lE3IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8C8wQK+bCb4SbUsZHryB6Lh5thkOY3lkAku8tpftGMw=;
 b=ydGdI/dF6r719nvTYYwMkV8F8upjxqyqlxY2CL5b09L/0j4b/L2DpWGt2EppInE1x1RrPAHiGX6VY0U99+byJV7zA88nQCeoAWafN+j/hdYfkeL9cuIzquWwIxgOk0ZY+4e/bv+CYd2wZwXuSDC+BLYzRgMW8ih0F45zB1eCWZQlgnrRn0aqsQTRcC7if503QFgNDkUdc7k8WEXdhIFpQYKbKbN6gKNBixZuCzatDrOhiiCI3tntwfF1tb7RTAOe0mWnsfXEKh77kyfJBQ+48/VkdxP8V9VCmozD2l6SZuhswbN/EjKg0CvaUuZ3pBN51+aB8KtThKaVbrvWkN0AEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8C8wQK+bCb4SbUsZHryB6Lh5thkOY3lkAku8tpftGMw=;
 b=LhQpjBopCgeFrNGdJSwEOXRL+p9+hmWLpuFD5YmGsw0vnBEB16DNgPyNJX3EXfjZC9UvoDDahUME4Z1V3/HNEhipbFVSCMsUm+r9q0GFJ9L8Sza5vP6DOF3JyRJ+UPAeS+FXH6UaEhh7UnhsaZaREgHOct6YzXoziGK8nFV+fsXLJ1W1cAQ2aSYp2Yrfkw00glHQArG+Z8sf4ZUC/08z4aEcNJbE4wJcU7YfXxxeaKTacGewM9Nv2zc7ooE32gd6cNQi7b0XwBIOKMrEt3jaKEW5UpjG/LHbFgrLWO6/XaVqhCecu8JVj/WrZwk+xNkwmuzgCRvcs8e2UAZ0npMgJw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DS4PR03MB8447.namprd03.prod.outlook.com (2603:10b6:8:322::12)
 by SA1PR03MB6497.namprd03.prod.outlook.com (2603:10b6:806:1c4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Tue, 16 Dec
 2025 23:26:28 +0000
Received: from DS4PR03MB8447.namprd03.prod.outlook.com
 ([fe80::4682:710e:536c:360a]) by DS4PR03MB8447.namprd03.prod.outlook.com
 ([fe80::4682:710e:536c:360a%2]) with mapi id 15.20.9434.001; Tue, 16 Dec 2025
 23:26:28 +0000
From: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
To: Dinh Nguyen <dinguyen@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Vinod Koul <vkoul@kernel.org>,
	dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Khairul Anuar Romli <khairul.anuar.romli@altera.com>
Subject: [PATCH v4 1/3] dt-bindings: dma: snps,dw-axi-dmac: Add compatible string for Agilex5
Date: Wed, 17 Dec 2025 07:26:16 +0800
Message-ID: <dbc775f114445c06c6e4ce424333e1f3cbb92583.1765845252.git.khairul.anuar.romli@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <cover.1765845252.git.khairul.anuar.romli@altera.com>
References: <cover.1765845252.git.khairul.anuar.romli@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR16CA0021.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::34) To DS4PR03MB8447.namprd03.prod.outlook.com
 (2603:10b6:8:322::12)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PR03MB8447:EE_|SA1PR03MB6497:EE_
X-MS-Office365-Filtering-Correlation-Id: 526bc299-6b63-4eee-c277-08de3cfa8963
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YjQ0HEC5NmvWSnMyFe66lMZu4MhVniWzlB1vSYcDRPB8VpHVjFwEZToCCopO?=
 =?us-ascii?Q?7eyhzzc9t6XWtHOJDc6qyyC0qys6R3Xfa28kzBcl5ElHtetL/HD5bKShds6k?=
 =?us-ascii?Q?2X5BrjpBK2A33u2J0rhh1fOIMpEfz5OVJPx7Ww2B08TotB3iSb1j7vO4ireC?=
 =?us-ascii?Q?Epax5gIH07xGACKG0cZSr2vm8GS+jUBgKdGN9dCTAn4wmqlmjtoCCs+IO5ER?=
 =?us-ascii?Q?NtfMyLn5U89Crx1pwMaEF4VA/ZgR8sn1QslsIi93lP5NBvNecvfbLltq1ZNZ?=
 =?us-ascii?Q?ay2cEPHtTYUphKXJGCHpu7BE7PXrlqoacB1jnMsreTZxHP4Ub9XEC5Lqghab?=
 =?us-ascii?Q?avQjLhotfi3a881iAM75STmDQvLINZOPuL8zJlj9hxEG8Qh6VB1CPaD8wZAq?=
 =?us-ascii?Q?ZbCbQznetUlN+tj/dFOOQ67DqWHeLHXix/FvqUZweuoHHD1eT2ASqt+mq6q/?=
 =?us-ascii?Q?gz3NaIF5/0rFevMrvEVLsox8R/hw4oNkE4a9UZcB7sbzLTIYN9tgHnH/DJ/e?=
 =?us-ascii?Q?IRqHKP05Etgq5aOJdUOlgb0Uw8Z0WF6UzLvtLo0d2XbRv1zLkZslFWPxHVcR?=
 =?us-ascii?Q?z6f1xeWMGpXFDJEiVRvJI+D7Bdi3Ljbz1BcGmxD4n/e5O3oGaU5n86aX5A0z?=
 =?us-ascii?Q?39TBqq1ZayYPAsKx+a4klTU4pQwcNZdoSQt5f8eGVz3aA4E9uW5VvoZ4p/MM?=
 =?us-ascii?Q?mCXpGLAJ/Y8xv1XRGadDSpgSs/dHnNBlXuZQwFFfUvyuA1J3XSZrs6dKoHD2?=
 =?us-ascii?Q?osQXVsMOCziai32aXcchhtbgD8aECutA1JLgJdlTabepsYa6pjKdRuz5wjtt?=
 =?us-ascii?Q?Sthnt5KiYgAuIv+3SH6eCZKtv2gMblb0q+XUXwB6EUJCoSY3IRnDzvRV5t5l?=
 =?us-ascii?Q?iVr7Wo16LvVRASVrY2h+foX73ixEG5b2nk4UVX8ERviHO5I8DeTfCwPRCLRq?=
 =?us-ascii?Q?sr616XOcxBXu0hB0TOj8ElXE/n+YLem4UbBt6B34wqwy3MmNq3HpV4s4hziY?=
 =?us-ascii?Q?l+Z5dABx0r+jrOZ9sNEdZ7HkVx4rdJioxlDhZzXPTKwHLae4wDDGa9g7DtMs?=
 =?us-ascii?Q?g3gYf6F9xO4fIG4sZLkXXqWUdSXYJNK1RA8JJNWNwKJxili8LlrJM7OSv+fj?=
 =?us-ascii?Q?LxH9ckT+uQW7Kr2tJsburr2LttDd4rolcYNt+sNR+cvbljNI87Q4dg4CPK8H?=
 =?us-ascii?Q?5aQOKmZ476dc07BsPV20JYWji3rq6WTsd6Qs5a68Z/jh2BPgafDkO7IR+QT/?=
 =?us-ascii?Q?tovwV4NtRXrQz6Du/pLLOCAo9riqn/W4MQRbKx4eZL/UIox6w+6w/ybhzNQk?=
 =?us-ascii?Q?HFIL4grIlWecIblP92B204e0sGX6+0xRYv1lODSPYXdXP3O3/mbgcPfohoIW?=
 =?us-ascii?Q?Ko2jPJW9Se5f10fbENcvLxz+IDo2TYBA5SNU7sjly9GBQGldWIvXNKu0p/Cx?=
 =?us-ascii?Q?lwnP6zigMtea2K1whsAqeUXe8V5ZENRDA89OiX2sFPvcWIr4GNsJbyDnNuXY?=
 =?us-ascii?Q?8sKE8LKNJiCt/eU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PR03MB8447.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9dC6k8aC8nbf3EgVuKZLXblW3fbjYJQjXd7drDVd2wFVogAF0l30J6wpDESl?=
 =?us-ascii?Q?Se2L4aVUsyZ8VS6US07minvP7xWqUDgtmwae1KeIcZFQ8BrZROzWQAj+trnd?=
 =?us-ascii?Q?TDx5hKL9VgroKeXszys1//DILNszJEn/arWjxZcGfM70b5XX4uJogDFc9USg?=
 =?us-ascii?Q?UMFSMgQp8/9yvadnQYFEb8couNmC51hT+T9QEHK9SyJa3adPvNwO/O5zSjZ0?=
 =?us-ascii?Q?yOMGHvBsxhxX20Anu0tBqXWUWgqvR5OWfFEaOgrBNfoxc2NIcbZlv+UFIj41?=
 =?us-ascii?Q?X3Zmsqa+ACgWS5TzU3lgz01nh3k+tPzjNCQpPttlpwIzpFORgsTG+TJP9t0x?=
 =?us-ascii?Q?fOYUTHQbbmsw+UYm0esHY5uN7EAWvpLGe7JDJXMXSfy6fxKg7hcP5JAAIZ1l?=
 =?us-ascii?Q?zX+GO9tTCFmACVsN4C5Oz7Bi3Wq3iMwHewiSkufNUo900BcVvPLfAEYuQ2YD?=
 =?us-ascii?Q?qOLIfIItpReaUSyEECuIGXJ90EBUV/++YXkmfd1ZW4n8c9occKyUKIl/wsq3?=
 =?us-ascii?Q?Y89sjkTaGD2sz7PM1eNlgoLqjMAreIuEsLMeZBQOxtS/C8LgsK0s+kqwcxd/?=
 =?us-ascii?Q?Z6kjtnozM4Hd8gRYCUL1a/gw4HjEdkP/AHUNoQfFME7ObMWnDAnDR/OVoPwT?=
 =?us-ascii?Q?puchIZhzF/+lhgLoPtlCYO3S3ciL9llP7G8f5T1msnfmTeeznT5q5rFoNZbg?=
 =?us-ascii?Q?1astH5M1v0HzC6ni57/LO0mYSYSq/iKW6EEhWDLOuXCICNHaPr7YHSdwXl5G?=
 =?us-ascii?Q?Jju/VxE9TnJSNeI78iWsz+fYbn7VidZ8rWmiOH76nI8dxRg4+/4Bei53KBF2?=
 =?us-ascii?Q?4NOT4X89TFRwAhbv7GVHX5VYVBhu91th9sIlNiRHqVI5M2l1+yawTj+JABWD?=
 =?us-ascii?Q?PkJu1ICi3cvn5aYRgVjhZsUSfHcf+Iqq81e3bmhoy0HHa7mvPazDsKHeznu8?=
 =?us-ascii?Q?PJJ8QMA5jfLzSkhJN7aQp7rgf1Lh878CneoOiPovytqr2zzCvtBdSTvWgfpM?=
 =?us-ascii?Q?SJlBuw5QzdhcWQekevEUI/ryHpYSvwJ8PH+329w++4AH2S/KjFffeu/CVnab?=
 =?us-ascii?Q?FCIzTYxtaYk1frECwsZhCI60Z/i8ltPDneibAZun4AKeoK/ass/y9mCMUDOK?=
 =?us-ascii?Q?g6hfs99fSexmMWfQmr/o2GI7QYxDrDEMyhkCvtv7rs0xrAdMr1+79TNw5bXS?=
 =?us-ascii?Q?8XJfLIdhhbSTwMfD+kCNaxGNOg1cCr5p9e6RyVdn71+rffPKq0hJKhyxmmq3?=
 =?us-ascii?Q?6e1Du12KEDMyw7f7J762WLygYGZz2hpebc3pKyxtPJTev6VdBCWxdFBHuT3A?=
 =?us-ascii?Q?8s0i+3fEu1oev1KyuIhzTlMFNuPguJ9GoOXGSzOM3Wr5tyWdxhZ5JnWLrki5?=
 =?us-ascii?Q?KtCkRtpURc3TvICpg0b85QvGeZAathkcQ024StiXguyh5MtbnsBv+5SNk8Jh?=
 =?us-ascii?Q?Z7sabPs8gaGySdLgihW68eK0wAUqBueJbJyeQ+2UnetiO8IeH+pz31s0hRO6?=
 =?us-ascii?Q?FE7Kb7gnJJSQTUaSMjaiab/mHOCv3UrFPjHpq0QmkupN3jKDlfiBENJuNViP?=
 =?us-ascii?Q?5D5J9BNir+Rfi5NCu/n5Q0c8wlyvDnzzY16JKLZrZovKXGwTWNiv5kxDU/Q6?=
 =?us-ascii?Q?7hnOobgLtmhMBicy/EeugOh7M1ZBdFBj46fsaqXXXFzRBXMqokgflOMWos76?=
 =?us-ascii?Q?g2rlDQKnc9+1jBElqeDaZNHX/OImAlghIAKTSQVb7R7yP9VITay9WFggtCdv?=
 =?us-ascii?Q?7m3d9apwtfVRnFd6nnuOUtWCbc+VyEM=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 526bc299-6b63-4eee-c277-08de3cfa8963
X-MS-Exchange-CrossTenant-AuthSource: DS4PR03MB8447.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 23:26:28.0147
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GsHj2Ks8z0Gf0AG+QlaOVmtHxoC/P/Lf+3QIzupo+TxGf5VdPIWRJvwnOnwV+4u9YqW+I12YMP5Bb5YJovA9yjCaM1iL6sDv/pLi0YNGNSk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR03MB6497

The address bus on Agilex5 is limited to 40 bits. When SMMU is enable this
will cause address truncation and translation faults. Hence introducing
"altr,agilex5-axi-dma" to enable platform specific configuration to
configure the dma addressable bit mask.

Add a fallback capability for the compatible property to allow driver to
probe and initialize with a newly added compatible string without requiring
additional entry in the driver.

Signed-off-by: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
---
Changes in v4:
	- remove dma-ranges as it is no longer required
Changes in v3:
	- Simple dma-ranges property with true and without description
Changes in v2:
	- Add dma-ranges
---
 .../devicetree/bindings/dma/snps,dw-axi-dmac.yaml  | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml b/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
index eb67348b4ab1..e12a48a12ea4 100644
--- a/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
+++ b/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
@@ -17,11 +17,15 @@ allOf:
 
 properties:
   compatible:
-    enum:
-      - snps,axi-dma-1.01a
-      - intel,kmb-axi-dma
-      - starfive,jh7110-axi-dma
-      - starfive,jh8100-axi-dma
+    oneOf:
+      - enum:
+          - snps,axi-dma-1.01a
+          - intel,kmb-axi-dma
+          - starfive,jh7110-axi-dma
+          - starfive,jh8100-axi-dma
+      - items:
+          - const: altr,agilex5-axi-dma
+          - const: snps,axi-dma-1.01a
 
   reg:
     minItems: 1
-- 
2.43.7


