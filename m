Return-Path: <dmaengine+bounces-7955-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F35BCE5E15
	for <lists+dmaengine@lfdr.de>; Mon, 29 Dec 2025 04:49:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1A6DB3000B59
	for <lists+dmaengine@lfdr.de>; Mon, 29 Dec 2025 03:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 777C51F30AD;
	Mon, 29 Dec 2025 03:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="HsAvzdEE"
X-Original-To: dmaengine@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010007.outbound.protection.outlook.com [40.93.198.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C3C1D95A3;
	Mon, 29 Dec 2025 03:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766980155; cv=fail; b=hlXTc59lJPdImTd99oaD7RsFJ+un5wedL0rRJRvVX9rWVPI8+9ThLCCKIJx50bw1sYTp9/LTdBS+LeX9QQqYUWnVx3hIDK0HIOu2ufQBzNK89lY199lVHpv1WX4pq53hCMZWi10d7lt8KSY5PIt43817o3KxyahVqBrJJwqVx0s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766980155; c=relaxed/simple;
	bh=LiZcuUwb+64hK4NYIhNTQWXIuveTP/UOcziHqKzDsO4=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=hEThApWhAFln6ml3XTKSB8em3JI0Sd9ngCbCDqZHjEfQVQVOY5mJurg1YTdvvB24EnNskKFKmPv0ablo29pJIb/GLg8BiEfbt/fYEwlLco19SeCo6e7YwyVv7cYgBUJmWytQgAoNs1dfubi7BjHC7q3bzhyBwpdqnkMIvY/7I8s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=HsAvzdEE; arc=fail smtp.client-ip=40.93.198.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yn7qkwLMu+IiT+ysla/2wkVnoG/oHsl3j9E9XF2X3CZ8jCY4H7rhl+NvfYp+fb7AmQrjPO8DfeRFQPWfqeFaMrdKYTcvEEq8ybMsRsFbGXsAGQK4UPTR/leUxK/8DVATnA7010EaykHcOae+fWWxXMPhIaS86jiXmXMvw8BZ2yp1AAs2PwGHoMY7nZVW3Gw7a2ek3gHnpYfBpGMYGryIV/tkCxEom8ZI9bWGGGVv1ea8+J+oXOUViCraMAWMVlslkV36cZ5JHAYfCOZvT4G0FujzR3LD4B5Tjami3GTzNhkW3UPNb9v3NoOc+TxL2Xv79tDDrJ3gLnAUU+WNNK9w/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qADQntk3CFpgZKei/rvSG0ygBW6h4P1QTJn5blfyisw=;
 b=W+jOpBgcT9Z5+F5aiN3arEbJMoANVKApVVEV7Wl5HMS5fKMZdMkMGhv6tNV95G8FyfiAtRNQm/cVbW3jbjB3N2xUez8uaEQKXGVwS+lPb8OALvJFnvPwAawP21CRuy2pTIrcUkbQDPHcF3Yz2b7566rPlMFjx4rcPxPlYFV1Qo9qnBicOkfKoBp1IQ/+vqjK1wtYFt3Gnbct2STGCGebqDoAmw5px3dLWfAYFyk9uZxmr3fh2ZKCMfAeTVbvyg3Y2Uuu7Jp7zAMuKu+QX2h+2piQc9nYouj6ZQQALWccPy4QPRC8810473iqtFIvoNRwYVClTM4UIpS8cbxAWgjB1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qADQntk3CFpgZKei/rvSG0ygBW6h4P1QTJn5blfyisw=;
 b=HsAvzdEE0sunVqBfpFgE0ifnomMi79UHUU0s67/PkrboEmgf5Nx3j/QHNANx8C1Kvk6TVfGseT21V3/YMo10iXmnHhMMMoc7PS1MFpqJUb0TjLkv9qd1q0TOlX3AOUIgRDqEbVNFL8Zqc+1wuJGf6X659emlXB5UTIxcz9+Nwz/fmL27CIIX/M0J9D4vgWfJCVywI41WogtNwjBKbnk/a7qbpdJ2bEuMEsXwsmrfwyTwnxSIcnXVNLXvsdtv+TditIa8fcbDbkCV4ioWFh9vGfp4q0RlGIGNJWSwYvVbNSQ/QqOSOdwwKDb7SZ84XjJsJhmhhEe0fR6/LXWE5TOSHQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DS4PR03MB8447.namprd03.prod.outlook.com (2603:10b6:8:322::12)
 by SA1PR03MB7055.namprd03.prod.outlook.com (2603:10b6:806:33b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.14; Mon, 29 Dec
 2025 03:49:08 +0000
Received: from DS4PR03MB8447.namprd03.prod.outlook.com
 ([fe80::4682:710e:536c:360a]) by DS4PR03MB8447.namprd03.prod.outlook.com
 ([fe80::4682:710e:536c:360a%2]) with mapi id 15.20.9456.013; Mon, 29 Dec 2025
 03:49:07 +0000
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
Subject: [PATCH v5 0/2] Add Agilex5 AXI DMA support
Date: Mon, 29 Dec 2025 11:49:00 +0800
Message-ID: <cover.1766966955.git.khairul.anuar.romli@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR03CA0001.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::11) To DS4PR03MB8447.namprd03.prod.outlook.com
 (2603:10b6:8:322::12)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PR03MB8447:EE_|SA1PR03MB7055:EE_
X-MS-Office365-Filtering-Correlation-Id: 35febc8f-33ba-47db-95fe-08de468d37f3
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?68nmHA1rWz1TevknAG+xGRkp7LYuL9IML+fzEcFAW1yZZWY5lnZTioo8rvnW?=
 =?us-ascii?Q?mp01NgN7Wa5MzEj10ZcMjwPAaajFGgdAhnu8cmqWe7tIPULhmWZv9YcyaVwY?=
 =?us-ascii?Q?QeZ7Uju7D+Esl8py2flaBgVzhuwIo/vJcNFB2A07873/rWt1WtFP3NNQ1xYp?=
 =?us-ascii?Q?vwLtNBOMWTnWQWMA34JSCp7ihoBhaP8lb3xYgluKCPrKZ26B7tg+bPsCjqcw?=
 =?us-ascii?Q?U6NIEYXJUkBGHByNEp/6FsTHsBPcWEkCQkZJ3Rze533z9RM9AhB0lPUEZGn1?=
 =?us-ascii?Q?d4qur0RKGY9p39D9hWrzDMGL1Yk6WrCXrxLbIMBuoLXpOv6uxvB5jBwv5ely?=
 =?us-ascii?Q?xWPVxZ2/wgZ49eCOvzpxGNnHje/meWUkOJR+YlQCbyVSXRNQkvOeOD1AWCZL?=
 =?us-ascii?Q?XCJPxp3vnt8i4nhuSJFBFTFEUvIZepSwQl4+7jLs8bQaVh7Y8poTj5EgDpu4?=
 =?us-ascii?Q?L1bJkPdjosOIFFMmujhE0WHtnaNhUUwZS1kyr/bXNrjDQOvOU7L3Q/SOZA/j?=
 =?us-ascii?Q?hM75wF6UjnvgR0ByztL6JlYurkJUs2cC3YprtO3HKL4tXgNUmL0MRhmdK8tQ?=
 =?us-ascii?Q?VmmVe7AmceCX73EOaZ9LzPKLBuSLeWQ6eNr34zJdNGXHQZGuTKKSaxLFVOZ7?=
 =?us-ascii?Q?B23BFFgXGO2a7hCxJzK+1y5WoigWywDaVel7zv0frKXP4lOu+kYjA4rgTrBH?=
 =?us-ascii?Q?kO718PNYPq3rBRcBk9mRKFzdUS4jahvMXPknIfHJRDh5FgsPK9pCRYOKxRIA?=
 =?us-ascii?Q?wp+pO+wDEwBddTAuuxY6RzKuViy3htUc/CpvzOwjoWn0hPhO0cSq0ZXle08t?=
 =?us-ascii?Q?4AXJ5EdMAMsm5aEu7bWtjqjKEz95UwT2m/ciUheU3c3arlCPIGteiy6L83D6?=
 =?us-ascii?Q?MDAKZAxQ2Aey2OV02BELGgrTXNK8Ga+WnunHqJ6TpWh5V33ZM0bXUO24v3ig?=
 =?us-ascii?Q?R8TRkTZPA51/s6QutENCw4OCB221h94c4WjM9dzbhHwLzgKNonRPlRSMep4U?=
 =?us-ascii?Q?yTZvT6K4hpZHN0mlVtX/fxIlxyVADxoTDTXbjigOrxrszSXhP/Sc3Ske19dP?=
 =?us-ascii?Q?b4T2Jes9JcdLcWZw+FSQbAiuFBHdVmwQ0dFqVoXg9TLFy5LOVFS4Q7ERU5FJ?=
 =?us-ascii?Q?Y1L3d5ysNyY9ELQ30+CyW1QHrPVYRqPVHs1mBIuGP08R42UaHbOluAjDh5D3?=
 =?us-ascii?Q?Vr4VSP+h9QV6U081KLjCSxwgsZT/O0TqCS+98/P+xQncRhQzc8Sj1cqu7rAb?=
 =?us-ascii?Q?s9QdP8JS5oQv2qc6jxw/jtWAvrWdsgZ8OHACtJi4fs3fLjy1DBEmEfq6VVqM?=
 =?us-ascii?Q?4LBnso5EciYVVg0vNWn6VIaGVhaIoa4YePv8YPK6ni0e6j+V8EonezIDFH9i?=
 =?us-ascii?Q?9F8VcyxB9oKaPZZbyO49wJ6jAIweKk3hsL9ulodart/wdymLjQl+LYxVkp+X?=
 =?us-ascii?Q?CzyYLzkjfRCgsfGI1ufcCbYrvP3bWfAqqnc8QMb0OpaPx9EAOfhUh38g6iFb?=
 =?us-ascii?Q?HWE2NxiNDo8ZuBCaQ9rMrEMnFvG8rvLfTlwo?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PR03MB8447.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MEd/nw5QXZj0KpaB3NJANNqwZYS7gW9H3rLVNpo3iuhxp6ni5ToCTYn4x+Qt?=
 =?us-ascii?Q?Ri68594dpKv6JQA7rVBawEFab7b9w2/D8/v+FVfhLhzSlmUB5h9JXHhEBa39?=
 =?us-ascii?Q?CoIkPK/O35xRP2+g0cGXU22ERDB6CSwh9aDnnN8XjHqIyC1iwCOonJTaJmOu?=
 =?us-ascii?Q?7DqRJGqpOApnNkj/zLmkP5lkM7kmqbLNh8BOdXj8yCw3jc9AUo/B7pN7Z5v8?=
 =?us-ascii?Q?89mOhRUrJAM3CwfHrJLxnmj2dJkCR2e+CTByIiBzqeiuSjYHcP8Ic0zLaE1f?=
 =?us-ascii?Q?NXAXCDpq0S3rz/jAfmdrdpt9AWYnhCq3CS8a32TnMZhNAAR65u9HXghJ+4A/?=
 =?us-ascii?Q?j6ByRe0Mj8tkvKhp7pQiVAwcxp5I+mSPnijGqR0geEN3N3jotO9h0k83JLVZ?=
 =?us-ascii?Q?cwSoFrKhGXhJuJbbwTxaZ9Z9aOxvbExBVhY1iG0Sq+PDFy4Vu31TtdYslyE1?=
 =?us-ascii?Q?R5kGICO6OvvnH6nwTCFzskA9Scna87oC5Iv0GSbZu/eH1DLzad9mxnuKKHX9?=
 =?us-ascii?Q?I1ARBBWqaiOBfhWKTSnBYklSQRY/nFYpXbNV5WvsmD0FQQ28+Afz+hrKT4uj?=
 =?us-ascii?Q?sL8VIGf4WTFeY+f9UgwdKunysJXDtuY6V4M7wQVhxTFcViLAVx0NYr8HHw4+?=
 =?us-ascii?Q?v6up6Ym8qgj/wL41Ioe4ZZi/h0iDVwJuGz7G1+hRB5NIxCXetazfKSorKZ3l?=
 =?us-ascii?Q?8aBCLR2Ts/qTf4J3DLxtY51ULv0l0Y6zwq4m4AAawGFklcYZU8yNkZxbrRPi?=
 =?us-ascii?Q?0/XeVtHYYrpkuEpVDXm+q5slzQKsYfsi6SySIEf3VP6dRoKEX+ytQL6/ntTq?=
 =?us-ascii?Q?H56GzfGHxzXtYj1qD0Zwjx9TJdWd5f6ZbKNGCJIPShcGBfZS0na+gi88o0g3?=
 =?us-ascii?Q?3ephytPtHlo+UI7uG7nwRDeAs/S8SQXsn/rBLL/XhhL2YAvP5AuotoYUIeR4?=
 =?us-ascii?Q?E8jdBg/ADJgne0Wfw01hCeYsEVk+nASYNY7zqrEze+aAeQytonuzHQmmLhXN?=
 =?us-ascii?Q?98ZLVtrdLbPY69tj9Zt4kHu6+eelr1zhMgaxd0dBKo4+SuKT+56ko3KHYxAo?=
 =?us-ascii?Q?dp7dusHpfRhGytiH3mzVP4CHcb1rvB/f6kQOCFSEvR91v7a4718u+LDt9dvu?=
 =?us-ascii?Q?d9WjqhdWvwC5UvZ15hGLUtcb+SudYoyUnGrlUMViFlfi9Yp3SEwaqlQG82zZ?=
 =?us-ascii?Q?Pv5krkCLFwZXIRxMoWBUmkqtxtzmTy5doFyu2PRVLmBmQy4o14xWGYTe5Ab/?=
 =?us-ascii?Q?IeClgIVf9i3aQwlaRzDqZyWkBsNln59gUpMDnW4MLm/S1JYi2L8NIsBHURJ/?=
 =?us-ascii?Q?02zHIYzbuuot8wosiUY5pDAcQpADBiRNaLWLtn+l4P5oios4FSgXN9huaE1w?=
 =?us-ascii?Q?WednCoJkb0S7sd488wbrZ9MJOaqhC3H7oYEnMI4bkIZgoqwR33A04JkefyCS?=
 =?us-ascii?Q?D1hBbqaUVCbr5E6hgSJ4Cik264RF1mb89Qro7lCNxrRY8K8H9OXlM1Xylsqj?=
 =?us-ascii?Q?/q9RRD/+lcAgmIvXRh7TYtFLl2DpU5RBUXrjQf/1g8KAET4ytAXd+FIeEBM2?=
 =?us-ascii?Q?CI/lSTLMYx0Idxne7qPT8QR47Al7u+ZTGavoq0GAqJPU//Z7CaGhjZH3tRNj?=
 =?us-ascii?Q?13f4fWuuS5AKxfv1J9f9BwarIF5Io1+H1COeS/D4Jw+Cz+/bFjqrnnZCWbmT?=
 =?us-ascii?Q?LvteLdRNfLwG8mgGWby0aeSc+qCP12PrfKQulxVWT6rpIR+jtxhZMgzzwHWL?=
 =?us-ascii?Q?gkgs7nyyZqrqGmLyJ/N1N8SwsdrzQQg=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35febc8f-33ba-47db-95fe-08de468d37f3
X-MS-Exchange-CrossTenant-AuthSource: DS4PR03MB8447.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2025 03:49:07.8949
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yuma+nYPd6PMgVJ1wwjooLOvHFcvsGGeSvbIfg3uw5lzxuUTyga+jfPaSDqrYuVK1LuTgew42fAELx43xW4WgxEgILqNsycriSmzkEFYoww=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR03MB7055

This series introduces support for Agilex5 SoC in the Synopsys DesignWare
AXI DMA binding and updates the device tree to use the platform-specific
compatible string.

The Agilex5 only has 40-bit DMA addressable bit instead of 64-bit. Hence,
this specific addition will enable driver to handle this limitation.

---
Notes:
This patch series is applied on socfpga maintainer's tree
https://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git/log/?h=socfpga_dts_for_v6.20

Changes in v5:
	- Drop driver changes since Rob's comment that the core will merge the
          device's mask with the bus ranges.

Changes in v4:
	- Use common code to get dma ranges.
	- Simplify the code to only in hw_init that will set the bit mask.

Changes in v3:
	- simplify dma-ranges addition without description as per input
	  from Rob.
	- Add simple-bus to with address-cells, size-cells, dma-ranges
	  added under this bus-node.
	- Move dma controller device node under simple-bus node.
	- Rename "arm64: dts: intel: agilex5: Add dma-ranges, address and size
	  cells to dma node" to #2
	- Drop "dt-bindings: dma: snps,dw-axi-dmac: Add #address-cells and
	  #size-cells"
	- Refactor "dma: dw-axi-dmac: Add support for Agilex5 and dynamic bus
	  width" to align with dma controller node now under simple-bus node.

Changes in v2:
	- Add dma-ranges property.
	- Add address-cells and size-cells due to warning when dma-ranges
	  is define without address-cells and size-cells present. Also
	  prevent kernel panic if address-cells and size-cells are not
	  defined.
	- Add driver support to handle defined properties and set the DMA
	  BIT MASK according to value from DT.
	- Rename "arm64: dts: agilex5: Use platform-specific compatible for
          AXI DMA" to "arm64: dts: intel: agilex5: Add dma-ranges and
          address cells to dma node"

This changes is validated on:
	- intel/socfpga_agilex5_socdk.dtb
	- snps,dw-axi-dmac.yaml
	- snps,dw-axi-dmac.yaml intel/socfpga_agilex5_socdk.dtb
	- Agilex5 devkit
---
Khairul Anuar Romli (2):
  dt-bindings: dma: snps,dw-axi-dmac: Add compatible string for Agilex5
  arm64: dts: intel: agilex5: Add simple-bus node on top of dma
    controller node

 .../bindings/dma/snps,dw-axi-dmac.yaml        | 14 ++--
 .../arm64/boot/dts/intel/socfpga_agilex5.dtsi | 78 ++++++++++---------
 2 files changed, 52 insertions(+), 40 deletions(-)

-- 
2.43.7


