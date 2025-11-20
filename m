Return-Path: <dmaengine+bounces-7252-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E7D0DC73C44
	for <lists+dmaengine@lfdr.de>; Thu, 20 Nov 2025 12:37:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7691A344683
	for <lists+dmaengine@lfdr.de>; Thu, 20 Nov 2025 11:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4952D2F9D9A;
	Thu, 20 Nov 2025 11:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="R797rn4Q"
X-Original-To: dmaengine@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013041.outbound.protection.outlook.com [40.107.201.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD4A2E8B62;
	Thu, 20 Nov 2025 11:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763638285; cv=fail; b=KQ17WEYpiNSerJnd4LXm9dEP+onkAy9D8vUeoR/nwA8b6p7j9wVmYxMBS3E7r2f1TdOZZI4Jgfp/vWEZOBY+5lLnRdjFojVfFANGhaWtgl+kImYGeldXk0uTcM5uS+c9au36fIbVwmdWlVI1Dptm2QfvdhA1fNzAsf+zMXQcej0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763638285; c=relaxed/simple;
	bh=6OBjaBLgFuoZCQYO7FAbqpwY8A8hB+icuiXWQ/o+YLA=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=azMtVa5SNqg08z5MNovEeG4PvNjGgaOqJMlkVL6jfyy6Af5/jqUTNauKj8DMLeBIIX0HWAqQZ2Q7rax+m+aAww6IcWcV1YCKpJ0xs78rQej3oB4rJKNsS7+dlYmXliwHvcykXrJNwjLuVobXbqkXuj6NU3t+/kQSlEwLAmsBo8Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=R797rn4Q; arc=fail smtp.client-ip=40.107.201.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hUfQTb9lt3EAibsKg/GjA3yR8PicRJhngKwkXXuJQZT1L6wWTwckr83+vGgCzCo0dWoNG55l3Xdp6OPkfuruHYXiXgF9GOLZwXICUbZ8Ud/1/szW0CxDFO+cUxor2n/0dJoXbuYvfHQ7Z1lJPq046LlzdsRybCupyIEoomx97oTFCossvSknmd/ZvJBlyz+XrfQ8cLuAHMfQyH/TTL7XKgS+J9M9Jea+W6Ta9sz+1WRfgm7DyulOenKeWzMyHicUCh416oFKofpDahKoYUqlXAxWhHmvrb73PONTSa1segYcJUqK7x6ozR6XJRvRtfFVZeda4O1sIaBZBGCsALS5Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jEnreLlvO1iR75Uoyjao4lx+iDcEa9b6FiFzvGA1gD0=;
 b=AMGUu+TZ4DtvRKOqnGRluLxlYZywyzgTGaDgizW6CDJqORVmJAtpvIG0mKy2RNoRXQGJOnUJDnElxtXac/4gEMOAhPhNfffn5rEz/Oeqg4q3QgyeUIaSEp43lqDljP2aKNZFUVYzH6u3sP3SLMUuQ5evYav742QoJxPiHiSZ86FxBKi4y97vZ52GT0bgrCL2m1e8MNH5pgDbcpptnLIB0ySlCq/YuoKGufbmygIk0hmdchJS58DribrMjwYF52OciRbJSJPBPMzZUDyGJqA/6ebC6N9F9P1+qlGM3AK8E1n/ugsZGoHdIylfGuzzsMFrs2NYVgMwguXcHo/kGV4rDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jEnreLlvO1iR75Uoyjao4lx+iDcEa9b6FiFzvGA1gD0=;
 b=R797rn4QsrHa95VJHtwq5SGk1CItwQGRQNe8H+AG6FAIv0k2f0gUFlgCXhlH4PO4P7M9KRr/inSODoBgyWssBmcjHJzVJbskn8DMaPOpuIfdZeQdL5pdOFQpA4tTC09iBW0/xMEUrmU6c9MWHQ02HPD7cT2VBmRej4c3vA5GBHZHYN1vxkUUM6Z86jjB1jAeQVGZlnAbvaMMEzz4vc8cIxk4sj84WIFiHX3De/9Go9e1MPA6NUN2ByGxcOdBzhIhivxxAisTCGw5SKTrz6XwBokBAXK4ivmMNLGGvkJnWuvrgJAkKn8LoRVI7y6KIuULPq1rpPSvH4pUAu5GRhWksg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from MN2PR03MB4927.namprd03.prod.outlook.com (2603:10b6:208:1a8::8)
 by CH0PR03MB5985.namprd03.prod.outlook.com (2603:10b6:610:e0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.11; Thu, 20 Nov
 2025 11:31:20 +0000
Received: from MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419]) by MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419%5]) with mapi id 15.20.9320.021; Thu, 20 Nov 2025
 11:31:19 +0000
From: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
To: Dinh Nguyen <dinguyen@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Khairul Anuar Romli <khairul.anuar.romli@altera.com>
Subject: [PATCH 0/2] Add Agilex5 AXI DMA support
Date: Thu, 20 Nov 2025 19:31:09 +0800
Message-ID: <cover.1763598785.git.khairul.anuar.romli@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR06CA0050.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::27) To MN2PR03MB4927.namprd03.prod.outlook.com
 (2603:10b6:208:1a8::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR03MB4927:EE_|CH0PR03MB5985:EE_
X-MS-Office365-Filtering-Correlation-Id: 942e3cee-cbd1-45ff-80f7-08de2828524f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JKKOlgQ5nmLsK5f/BJzGS/WT3VDS5/Gr487zK2h1cCrMbzNXY6slCinKhDhi?=
 =?us-ascii?Q?nKMxeUyIfoNUS5EGxsBpKwcxJkZsg4X+nnxmYDh7J6+pFztwObrDO2j4qzz5?=
 =?us-ascii?Q?yQImvhbffbHUOjptDbBQNIIAzLgat4CtYyjsu3AuxAvqtnjCVfnzpGVbAL80?=
 =?us-ascii?Q?ccds9cHSZ9ad8ZtpfncbChCsqZ7/FSkhUKUxsk72qorIFXFNQR/qH0beUCae?=
 =?us-ascii?Q?4VkN6lztYpzZsWWiM4guZZDziSe5244w5DJyxX+GAFrX+pM2DFybcf+jHsNR?=
 =?us-ascii?Q?M2azy6HZ1GM4b3sfXOZcmb16k9S6+ADc+lsWagcemNYHnDM4aYwwL8al50p4?=
 =?us-ascii?Q?iw3Nc9W36GOI6HkpxOZTIwyK2kLdDUEQKsSELugNEVkG+qg9NEGit/5Ps90P?=
 =?us-ascii?Q?4fJiA0Jc0BlTU8qEtqVXyicrMNKg6Z0A2z6z9ooq/mE0+ZFp8GxrUstNEG7w?=
 =?us-ascii?Q?gxdYevuH++SM5ogh52vtqHeE7s0/IoWOY2IKudi6EqzQYmqW/ZB0KhnxthhC?=
 =?us-ascii?Q?EirTKhgxBa8Ug96ic1mNAnxwnJyFaTU+gh77utB+KsOewvJP2OR3Ykp4yKqA?=
 =?us-ascii?Q?riSYOQxKZ9BvXwNVIHmsP5Yi7RU00fRIYMUnGckJuC5uUkz43f16+nkjpVqP?=
 =?us-ascii?Q?ZS1rJlXsUu3ztnTmcRz93DwFuAWsGdBxVxfvmrBEdLklurk/Q3sObuKmPNUr?=
 =?us-ascii?Q?kCYLRTISZrmcKbmM4q9FK5i5VvqVMttO9Huqjc1vnSKZlC7st/W5e2muHOgb?=
 =?us-ascii?Q?XITazof9c9hAFasBVTcLFvpIe3fCH6vdk07sFC534SwzjXZjZBgzWgHvNuXp?=
 =?us-ascii?Q?Dl0ZIQuulpXfyNH8Nrr6nKbEoL5GvIUXawz5FdLfvroN+D8FuuxAzEti7RLQ?=
 =?us-ascii?Q?/7dPX//2pswiKtmtSiDgV+Ruc2ro8lhvPxJ5NCq1TlSN8TGK2rEVu+eXHU91?=
 =?us-ascii?Q?aubZ+c2SXXAvlfx5W9Rc+0SR5CTVAanShXH38TW/n1Zv+sX2LO1q+0u3JbWf?=
 =?us-ascii?Q?kQ96dxHKN+fHNic8DfkX319H0vBDZA6evdoIsksmtywqne+v3KODoX+izjUx?=
 =?us-ascii?Q?kJcU4d38+C3QmFt+UcHM9o3HsTRIeLwrd7FwiXxBo9m7v5jhLWzyZ1Jn7qzg?=
 =?us-ascii?Q?fAK2yXYYzx0Cwg/PJk/PoExY+i/ekdiQvppV2J4ExdY0xrZXc6ZCF+Z/FX75?=
 =?us-ascii?Q?w0bqrXjQ5hdVbgoBBss4AkCsGVG1+jnjpAplP7mgA+nicvafEEuBTtpF7Iok?=
 =?us-ascii?Q?2a0IhOUW2kpqzPvBS8RM6qiMTMK7wBO2hhyKkpd05Y3PXDcJd/mJLupCh2Cy?=
 =?us-ascii?Q?P6vGRO1lYcLz1tbiHIpz9qH8Bl/lF5bvl/H5QK+8cLF8ik0jMABdKgaTKP5E?=
 =?us-ascii?Q?YrfEN4HDzPDvt+R/GUWu2SqnqIYYqEt77PCktHLYhkJHH3TMXastEiQ4Kya0?=
 =?us-ascii?Q?0KP+WEFBAnLBZRIGE4Rt0cAHDTfqfbjz?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR03MB4927.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?J3S5W+OoxDZhdelsYyO8ogs4PV//2H+eH6vTAUdCTTFRUbE28ShuY8W8nvW5?=
 =?us-ascii?Q?cV/eQDzlexqTWspP5uz4ttICxS0D7licvaTg6PWU2IA4koSBEW0fG0mMjasS?=
 =?us-ascii?Q?X81VHOqspM0J1lwejKPf0biCmrsQ5JlU0y5VFajwXBM6hQOZ+Rvwpu3mK74U?=
 =?us-ascii?Q?EeL6lDqGRKS9BHSiG7qqlhfbM7HAXdU5MgjFCK/2D6HQApAwicA87s+8mnhW?=
 =?us-ascii?Q?8DwpFrBATdrqwh2qdoMyCOx4SjyMuUB2YFBlePfz9mKmSGdonmCZrbB3Xc2y?=
 =?us-ascii?Q?/QkVVZ0SELsAX+7JlPr2pIxz8QMMWbem0v8t67mPuDVSEhCEIN7MS7UDwjhj?=
 =?us-ascii?Q?9vUfZ2PIUTvEVr5/ADbq/hfNliry5TqnLnam2q1okvo4SpInXr/K/xwapwB7?=
 =?us-ascii?Q?Z+LtBbUzTTtzAhOnX2K6sKN9wRTBa+hK45wx5GoSRN8ZxLrkTyBAMC0NgJAY?=
 =?us-ascii?Q?0P8JxIhWYgZ7c6bb5k6mZfAmH14tHBeTTVuKN+IKz1WN8mHKJVo4p1HFnqaA?=
 =?us-ascii?Q?xNfdj2x3eXDt68HwZq6tNlyLATLpBBuZp24ReGyjZhHHSJ8+mbJiwrlHq03V?=
 =?us-ascii?Q?dXaoaq2Q9QyhlJRyyMM48jCqvgTBtt4DZPalzDs5JqUZLDBcqlDhNzSMABOF?=
 =?us-ascii?Q?QF86beVX2tH2ZRPUyv6D9F3ufnwke96MJLoUFT6uO5H7FqSllZXcM3xamuVD?=
 =?us-ascii?Q?Z2tAg4t1RJYEHP/rLDxV7sCwLUiwJl/9SHtAR71NYhhD6Ggk9RRJ8xBdtRYv?=
 =?us-ascii?Q?ScNMgrmrEBiPqvtKJoZ+hGRf6U3RDZ0hf+CkCq0z3k06xASrsEgcFZNFgDOw?=
 =?us-ascii?Q?A9Ot1OD/RYaZeIg1PYIR4YOeJ2HrczmYDY7N6lgpcV4O9Zb5WE5QcMOeoKQu?=
 =?us-ascii?Q?h+Usq9h2JbxG0INCpl+DFLzmJ2E/lSbiwgOA6zzc8iBbDv7R6z7MaLJnL0ln?=
 =?us-ascii?Q?zJtIXWBIQmISpiVZOybwnDIknyKekxpubobzSqYBDH3gUAoeQI1bmPINJd1P?=
 =?us-ascii?Q?D7uhcOREsuzYlXCkErS/iFJZzjINVLZPCGiIZuUIReMPmUA9OTbhfjfq7OF+?=
 =?us-ascii?Q?W2AKLzio8FtQ9G/97imSGzGDOzs2CMZ0nY8/AnmqlCPOO2EkkVk9+C0g9HIc?=
 =?us-ascii?Q?SJ6mB1X6A4ytgm2eaLNzGErq9LuYtHFH05oM/A2a6auyccnso40vz8oIqOTP?=
 =?us-ascii?Q?cO377KR2Q9Hl6dsc4QMOg/190zwiA2ub5xHg6zZckeTPfTZxQv/+X5FnNeUP?=
 =?us-ascii?Q?ea25KdkiE2R/PAgKLT6Lo7kNoTLoZj4b0BkBe/RvH4PQ7DrP155HTtK/NzcT?=
 =?us-ascii?Q?hTz9CiEgLRswvLShhROHH+/7nyOYxkSY9kY9Oxljfb61QbTHZMI4AEpGLjk7?=
 =?us-ascii?Q?B6ZXrPV4Ys0AVbWbfCu1ssHlCTUfYrqQ8jFw8Rsra1Pyxn1xLyneivuc/6la?=
 =?us-ascii?Q?xJBkG17MbZ1P+quD1ir17fvcyJsXc4aQmXD5VLt++wZaB8LznjWcbEN7DNPv?=
 =?us-ascii?Q?jkdCyZM7pNQhvUDRMQFsgcx8qsx4IP8IdUm4H0qeN4Uv/0E6s9cpT+MxaqQb?=
 =?us-ascii?Q?XxSkOeYbGt2/JBNY2oYdiv369Ou7IsqVKb255x08uS3dh+LkCbu4wgyLRZ5C?=
 =?us-ascii?Q?DA=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 942e3cee-cbd1-45ff-80f7-08de2828524f
X-MS-Exchange-CrossTenant-AuthSource: MN2PR03MB4927.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 11:31:19.4073
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZK9OFIRo9Wy/vT8qND5b7td1XXsJmB+A0MsTmaBbchohgTznSl2B4doMO3fmc5fqvCsrX1QpFccIl5LjsusCTyImdwIGmmnVhVyxVcu7Xr0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR03MB5985

This series introduces support for Agilex5 SoC in the Synopsys DesignWare
AXI DMA binding and updates the device tree to use the platform-specific
compatible string.

The Agilex5 only has 40-bit DMA addressable bit instead of 64-bit. Hence,
this specific addition will enable driver to handle this limitation.

---
Notes:
This patch series is applied on socfpga maintainer's tree
https://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git/log/?h=socfpga_dts_for_v6.19

This changes is validated on:
	- intel/socfpga_agilex5_socdk.dtb
	- snps,dw-axi-dmac.yaml
	- snps,dw-axi-dmac.yaml intel/socfpga_agilex5_socdk.dtb 
---
Khairul Anuar Romli (2):
  dt-bindings: dma: snps,dw-axi-dmac: Add compatible string for Agilex5
  arm64: dts: agilex5: Use platform-specific compatible for AXI DMA

 .../devicetree/bindings/dma/snps,dw-axi-dmac.yaml  | 14 +++++++++-----
 arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi     |  6 ++++--
 2 files changed, 13 insertions(+), 7 deletions(-)

-- 
2.43.7


