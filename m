Return-Path: <dmaengine+bounces-1404-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F8DC87E3C0
	for <lists+dmaengine@lfdr.de>; Mon, 18 Mar 2024 07:39:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FCEC281D47
	for <lists+dmaengine@lfdr.de>; Mon, 18 Mar 2024 06:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C10DF225DD;
	Mon, 18 Mar 2024 06:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="cuG6cfWI"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10olkn2087.outbound.protection.outlook.com [40.92.40.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4F7224CC;
	Mon, 18 Mar 2024 06:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.40.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710743953; cv=fail; b=HZNhhQJMXSTd0ZWQhDKYphzyYJUxD8lMLp+OWDQl85/p2qEOYktWd+tAxrob1ltbURj7OPSD36OJw5GgwFBk7af9j8IjfP0e6A96eZK4kboKroMrtid9gzMiXQyahH+JFOtq4Dn7bsU3bTarp8wtEsjONuwGZdoE4ARYD77C+bk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710743953; c=relaxed/simple;
	bh=kKmDX0PJAbOMvqOoVrDMWFybqJq9wYE5XTNhpIgdNOA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=d2VORMRght3f/NWazMPG0Kbfb8zfKLMiMkZ5ED7A2rcBdp13SEkUcz6dQrdVtwgd5Iv4l+gtMjG4vkecGgmFQjCyV13/mLKLSO/tiU0lSgP4w4Gv1Qm7m/20dXA3yh5QmdbJ55mEHUzjYBI+05XxmrH0z4+vFZmPmSVPYmjutQ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=cuG6cfWI; arc=fail smtp.client-ip=40.92.40.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dYR1Jy+wQ8+RMyCaBxb4ZQxzhir6+Yj7ilMDseo4RecY8fKRj1oyZJPEkKuUs/bO5QaKuzlB6fZ/7eiPNZcBedNsC7p88E0nLDxN+ykeKZaDLYUOS8FeHRV93L/3lZi0gcZlxuVgncvID6PH9LK2SBnSsHiWz/oXlt6vgaOutlF3Ms9Cgtzf1VQgb5QC88su5MXzOBnpeFscGm4qfh6VHehd6VITbgR76JhBpznicgDciAbETBAo0dnRPZQHm7YWW759FjC4JhERAlM7Mc6GkXl7KZkO9nce+yaePOQ9clylSGdkm3JgtvuAokt+ho+Mf1WPnqXMLvb26lPM/dThSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DUPDeMgzx5bBbMIFB5my6AeSJvafCKMk3W8pCIQGUSM=;
 b=PNzeMRN4Jmn5OBVxl3WgvuXv9H48kw9qth3gc+Ck4zE0Xd91U6ARvegapejlpTPyciT8Qn/s7NB0vS9F9FubyKrE5wn0qa6c1w6PuTdLwsp7IWhW5xSXTLPi4zL87Rel9XJeQM7/opAcGeu9oLBSaeSchxOoQjd/H8UUy6h7R5K3CVR/DalIuw2gBFVlo4Vbo3hX3mwtJkRYBv/yQFjWtKHPCYGUWWZUEycTou0o46yEA1lkcUHmmNG2F5LflLixWYK0IvJuo+aOs8M7KGrRgAB5RrYv7b3gzGN8MXSfxiAMc7cTzO2P01htyndQp6r6nRqKtS6lF/LQ68OrcDiARg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DUPDeMgzx5bBbMIFB5my6AeSJvafCKMk3W8pCIQGUSM=;
 b=cuG6cfWIlLmA/Sgl51zPi9H8fbAkiaFGLr8bnt9Av6AaqrIx5auqzetdjBYnzcFZvRw+cn3cXGTPIgKrEFmRQDk4rZ4WLrCe+56XuHDBZcemNHUcH4FRclyLF00JzK84BJ+sfraysv8ZcrsY5K7TXFgLV55W2nREFro8ztK+yD6ljD9EDcTOCcRU51QZZS4UVKMY7ikXC60M0Pl8c4vST5XBNIfBcNmT/87mP0XnMZgwb1oNymeznQg++N+A1Vr7RPfl7dfKrEVg0tnayY6VfM8TJqu6aiow7b3XEuwXU3qAQD/wKG3uG0Z/p3GtcDJse3EaR3eNNMjdIE6Mlr0xpA==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by SN7PR20MB5460.namprd20.prod.outlook.com (2603:10b6:806:2ab::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.25; Mon, 18 Mar
 2024 06:39:09 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::8615:efe2:7c8e:2041]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::8615:efe2:7c8e:2041%3]) with mapi id 15.20.7386.025; Mon, 18 Mar 2024
 06:39:09 +0000
From: Inochi Amaoto <inochiama@outlook.com>
To: Vinod Koul <vkoul@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@outlook.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: Jisheng Zhang <jszhang@kernel.org>,
	Liu Gui <kenneth.liu@sophgo.com>,
	Jingbao Qiu <qiujingbao.dlmu@gmail.com>,
	dlan@gentoo.org,
	dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH v4 2/4] dt-bindings: soc: sophgo: Add top misc controller of CV18XX/SG200X series SoC
Date: Mon, 18 Mar 2024 14:38:49 +0800
Message-ID:
 <IA1PR20MB495375AEBA417DB6908CAC98BB2D2@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <IA1PR20MB49536DED242092A49A69CEB6BB2D2@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB49536DED242092A49A69CEB6BB2D2@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [FsOmjLBBlLNCs8Y3njdAwO6TWmGnFPSV1JROZl0lzrE=]
X-ClientProxiedBy: TY2PR04CA0013.apcprd04.prod.outlook.com
 (2603:1096:404:f6::25) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <20240318063852.1554712-2-inochiama@outlook.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|SN7PR20MB5460:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cb41ed8-3be1-4fbe-0a0e-08dc47161dc9
X-MS-Exchange-SLBlob-MailProps:
	RlF2DIMZ1qUQWS8lN22nULkf5597sA7XTOYMcwrjOxIakFiGGMGZrpbOnudJ6iHK8HIMbrkc7/xtsAkSj+ikLljg5qT63tEJ0wH/mTogyh5OBbofutqo5iU2BXSinr5WNip5asT0Vf6v9E+iWmOjuR1fmEgPI2TT2wLXVHnIWSQQDiHmDT4DTesB0JaEv5G40wMOQM66AlV3rsURTvTC/IqSi3gqD0EhZ8JEoQ6JTVtyCHouK671EZbj4WxEKyDiRulWgJy+lzfMrcamRRxv8oxz0DKOpQBNwT2BZcF9/I5Bg5m4vlblP7IdcoIuoAy4CDTAKU6NrKxJmjJyPJMKpLU+QXvC9UyGh5J/8OexpZ+yoXuebgiJVuzgiftJCvBRgtR0rzdkV1shrj7gp/M8njfR1PFp10rnDtuyVk7SFBeCFJHEeJ9fFazEXe9+ueMTgCXwWpENiGGZYGeXkaTsd/BXDNgNJR3nnpqZfYkz7v1lVFF0B7FBwBoX6i+8govp9wBH8u+wQsC1cDDAhwDDolqHl7f3L/sQ5lAj6Aj15i8dj87TyKl2hHcuoHsolKwjwIhWgg8G/TIAoLkLvDqj7qNXIze/4MgMtSuSCxftYENwOwBEb3p7NoPG8ySCMhZO1mKDiKZlFxBI1ZUfi89pZnakg8umCLnEyw6q2YysxZi58+iqcoSxTqGwdqCA4i+Sm2biSmHVtqUB3SraYPLyqbcdz/NhIRLG2/DYOr2+FR4KyD3phY5KtAgbmk+EoW9m0zIgFdRvS51uxrWoUQCMyUhuo7y3VnSu1cDW5Jri+gdW6qDx892Hj8LCFpSVvcnVdND8i7cvPE+bIQc0KqvhFHxCfiPH0BaE
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+LIwn1ItZ0nLuPv8i/ykkZZNoaX0M8wjAwD2uB2LeQA8iqkf73RVsYXIE2NMKaSVyqx093h9Vn7rvZ17tr36YbrsggZgRzWoImsMWdpfwpUGeHHzyn4a3gqeXiMCSB055fw6TeakBCNcaw+bOQQBCNzHnXFqehNXOGgcYz1OvLtXA/GmjKDM5e1f3LhwLr7+IaejjIJ0ThHJUbNsxLYGAc9uqYAD6JcFADAsdyvtfjzMLeAufTt4CkeYI8nCr8lBcwSX100mtCefXQ8adG2VRe6pcJxqPMBWGHB1E53SuMV9ss4oD4eGn3DrJ1UoPPwaZ97mxWP2kcz3ECRR9d4CnMnG+3Gqgsaeu+E2BL+tlGfVSscV/waGsIMpU/G3MV10VdhvuPS9jlN0XW1kE2JCE6mn8K2Kn56vUneoe+U/w+IrhOpqzJBgnRTNHZ0mQtzGH/0CP4379YF27xnWOmqUIdKqKr+rZtXiPt2XrKH86LMLEb2059tVSpi3I7mgaWRwCd7a/5kkCqz2LH7OGPUdY77uEl6akIrzHRgAGvN0DQS5MqxIapkOQxuD9dTBKlofeG9Qz0JKzQ+Lp0YXQGBwsHe5e7VNbtAdhCDIljQ12JfAlfKRgxjiXdY7Uf8OP750JiWGanR7Rtn1SYJDogZ9ckx34WAGHoQWHJ19+uPOC7CFz+RGo+QcM4JVcI2usKWXCy6hLI9wpHLHQbdwmXoPJA==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/3OJie0RtUXwQMFm0Plt2WCpn7ByKwEV+i739ywHzLOEzhKbSDCSYD/Kg98X?=
 =?us-ascii?Q?h5ep0qwMVlsp4VMJTQpp7HShFs5t1bfNZTChB5ohw7NUt/xKdbRISBVS5+Lx?=
 =?us-ascii?Q?bHU9CorGi75Q1++bzFpeBygU41/3eDmd93n2q8NDjoQIxeS1vGun23mGRjIQ?=
 =?us-ascii?Q?b70YFNGYXoTBUEAC5ui+OxDu/jXlXKh0Dsu26T44ZawNtp8OWQubrq0473ag?=
 =?us-ascii?Q?bgZNk7PgvBhPhtzaQMGqLHBeVCCm5NSLWLrjU/PrmPd21AeRVAoiJF5lv29f?=
 =?us-ascii?Q?KT4nzI+07MnWLinF/BRJeFPv1Bj3La9t/a9/PbpXT5Ib/YW07tKnCpQNRAxN?=
 =?us-ascii?Q?mtA8efR16D5Y1aJ4pDplkEgxHM71ROpkJ9Eff5jPOvTfzJVlVE98XjAAud2O?=
 =?us-ascii?Q?azXMggH5Z8m0g99o1p26EATgMPXheE1Vi7cYFk7gPUNbJnliJwwTEEZ45m7r?=
 =?us-ascii?Q?Abg5dB+Q2gM+ibwTjqpMHzeXkVTX5ZxxgZjR4WE5SdH461uC1QObpdEOyngx?=
 =?us-ascii?Q?bbLv5mLmX7UezV3O0DyItoMKZGX8jxIP5+lTRvauGdzF6wNOABQmB5dFeyOn?=
 =?us-ascii?Q?pQAbtw162PDaEgwDbFlbvopRCmarLheaMSnBBonhpTV2nk2C9MMxdhCmnRaS?=
 =?us-ascii?Q?lBDoVkfn6gKxCJgnaBd1a9QUG2GDOI6WPCXQvwIGIlbe17r0HOoD8bybR9vj?=
 =?us-ascii?Q?3kz2MyGt88l8VTCowXudm2dWGLV+am1fCvOoKkmSZamgOnSpXmiDw+n7kx+Q?=
 =?us-ascii?Q?RHfb5vZphRcEQIqEfbp7u7b8p2+esYcG/5600NSlEXPQ8iZeD0ZTo93TYVS4?=
 =?us-ascii?Q?Hxz6DgB7uVq3BSNwjh/HxjsZSHk61aGQHqZldjF7BXVSUtPpssQsInt0m3x3?=
 =?us-ascii?Q?QGH9aCxBmJkP4nLGCWjJyLfb1VZ2Y1O/gplAknx5tA4wnkVLXEoCe57418ho?=
 =?us-ascii?Q?uUJjQUCy3sHFnG9BC9v1jTFf9KDOy7rhIo9KMxN0IjzTTcjYskeYxgNI8JIW?=
 =?us-ascii?Q?LQf3qajlqoO47fxTn4hj3edH63px0lJplPsWSVUJ4uGwUi3Uam4hcvq/R8XA?=
 =?us-ascii?Q?kgOVdsrJdfjgLqrK1eHslqoeGDdxHFnVbiP8xAQW8Kf/Cl21kiKFmwKgxKmm?=
 =?us-ascii?Q?YMh8gDYu0KvvRd/A64Ij/cfpirRuPbSssmxt5aG7dCcxT1h85W4hamRgmvXv?=
 =?us-ascii?Q?O2OVnuKQwrKVrSEDV5XKmbI/8gt/BGXfI0JVq9F7Pl9AzXX9B8x1215cgJxq?=
 =?us-ascii?Q?6psCaIYeN9E45z6zUbLH?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cb41ed8-3be1-4fbe-0a0e-08dc47161dc9
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 06:39:09.5566
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR20MB5460

CV18XX/SG200X series SoCs have a special top misc system controller,
which provides register access for several devices. In addition to
register access, this system controller also contains some subdevices
(such as dmamux).

Add bindings for top misc controller of CV18XX/SG200X series SoC.

Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
---
 .../soc/sophgo/sophgo,cv1800-top-syscon.yaml  | 57 +++++++++++++++++++
 1 file changed, 57 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/sophgo/sophgo,cv1800-top-syscon.yaml

diff --git a/Documentation/devicetree/bindings/soc/sophgo/sophgo,cv1800-top-syscon.yaml b/Documentation/devicetree/bindings/soc/sophgo/sophgo,cv1800-top-syscon.yaml
new file mode 100644
index 000000000000..009e45e520d9
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/sophgo/sophgo,cv1800-top-syscon.yaml
@@ -0,0 +1,57 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/sophgo/sophgo,cv1800-top-syscon.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sophgo CV1800/SG2000 SoC top system controller
+
+maintainers:
+  - Inochi Amaoto <inochiama@outlook.com>
+
+description:
+  The Sophgo CV1800/SG2000 SoC top misc system controller provides
+  register access to configure related modules.
+
+properties:
+  compatible:
+    items:
+      - const: sophgo,cv1800-top-syscon
+      - const: syscon
+      - const: simple-mfd
+
+  reg:
+    maxItems: 1
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties:
+  type: object
+
+examples:
+  - |
+    syscon@3000000 {
+      compatible = "sophgo,cv1800-top-syscon",
+                   "syscon", "simple-mfd";
+      reg = <0x03000000 0x1000>;
+      #address-cells = <1>;
+      #size-cells = <1>;
+
+      dma-router@154 {
+        compatible = "sophgo,cv1800-dmamux";
+        reg = <0x154 0x8>, <0x298 0x4>;
+        #dma-cells = <3>;
+        dma-masters = <&dmac>;
+        dma-requests = <8>;
+      };
+    };
+
+...
--
2.44.0


