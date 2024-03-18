Return-Path: <dmaengine+bounces-1403-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0526387E3BC
	for <lists+dmaengine@lfdr.de>; Mon, 18 Mar 2024 07:39:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 829B2281CDA
	for <lists+dmaengine@lfdr.de>; Mon, 18 Mar 2024 06:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22ADD14294;
	Mon, 18 Mar 2024 06:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="cZvx4XjQ"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12olkn2055.outbound.protection.outlook.com [40.92.21.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1436322337;
	Mon, 18 Mar 2024 06:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.21.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710743950; cv=fail; b=DtIm9hKjEGeU3NrI+xvPANgiBK9cHwlPSxnJmS0VifuDHo//E4kwHdvv4eIcps1Zsd9RJ7OmQ/Mi+vdIPqGWyUoZTrbgKwVOYxIMs0Bvwx1nMHmIKEgz0Ogu5lWtls5J00cfss4M0jVjuvMfdvgLnmaLVTrNT97PMAaZ4ciBl1I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710743950; c=relaxed/simple;
	bh=Ck92H+AJ1dLuii2Tsr5GLRzwjEWRlB+XP0aYYdVCltU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mj7wjDFDs8fhnH2WprDzVCfBpfS4NM65Igt7CNrArF7smBCCFtZEXo2PTQCVWmJrav6YfWCHgO6xuRDER9I299VXag6YGmcF7x4IagqI34IxsdajfFfvtWkJvUKy5okf8qHNdSCw7uEEcxGwB22gQYe3R/ej+rc2khVFEABKSPA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=cZvx4XjQ; arc=fail smtp.client-ip=40.92.21.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mhQiJJWhtzdp89OHLp1AE7M0PDkSEI4+qlM1kBzvh7NepEtdWUOkqRXYmbx2VUkibq/YyuvT1hhse07Tg5v8iElLiVj7Tgr+K7WCIkp9xvCILs6qqGV1/V1b5MjN9nSQss5kfq6h9hwN/sejjfVrJ/xI6n/aWAjo3/jKyQ+qHVepQiqcrSvc18Uyk3o+p1xEJ1xKegCHJmR9Hu741oF+/dQz25swDkTA43zGSxVb8XdO/39oXkC5+7V3NFQ8m92Yty0MGq0qZcPMSl99wtkCS+OSrygSwWr6NkXwO7iYuiaf2XfefWD5MYz/r6O/FF0+UmBFpaw63xXFPuWK0SUc0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PkAgJGGdKKPoWWI2AqRpY4pgPVtQAHf44q7yZFC9Dls=;
 b=empvOZW8oD0oAUQhDVPhikdw2NUsNNpp0mEBa5157smz5rkLqeF/fYWX0YGk8PX97/i3YR8cNsfaBMYJMMXClRajTvFE2xrNuwiT0i/aFPDjeZPNQpWxvVMo1TaSXYONbT6dDGjRAQTpk9yitmbzasmS4XgP0n/Hzg1ZAJmCn8oqQYKHwp00RzxIYT6LICRCiuGFNkfonzD1iXQeE7Lbdiu7NMKhd7j0CDPJYtUMFQkVRMM3lVNu4gHhUOYn3u+lgNfHe4s6WJjnz3J9H3nB3m4uHKZYsqDxHD1/saJfTsr5cgVkbr88zROuj37Z2Qm4ZxtghjTl9soO1npqP1rlOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PkAgJGGdKKPoWWI2AqRpY4pgPVtQAHf44q7yZFC9Dls=;
 b=cZvx4XjQOPoCcodd/csLtPtsyUPO5pxNTnMBGcgH7nj+j+kj+OJYIFawli2FEcU6GM/272/N9/Bvve28THwRwUJyjjGPPnPl9n6aW4jBHsoFfaPLGaZ2C+b+YmjWbQrv+1Te/G4PsbfodAJDOPAbjbD5za4LZ/41N/ifExcA2eV8UE0fw2p/mA6LyB093R6Qr4WaimhSmODCTRIUxP4RE0krUqLyXGauju0WvPQ5gZ7u9jUG+TUYyTicjaUjuHBp4pFOv3cIhnJSyCJSZ0/la203GA3yUjXozd0unRC8yuGtfSsespG3B+uSbzkyBTDHQ6/NLAlz90xuVYQQ9SLJ8Q==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by SN7PR20MB5460.namprd20.prod.outlook.com (2603:10b6:806:2ab::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.25; Mon, 18 Mar
 2024 06:39:05 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::8615:efe2:7c8e:2041]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::8615:efe2:7c8e:2041%3]) with mapi id 15.20.7386.025; Mon, 18 Mar 2024
 06:39:04 +0000
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
Subject: [PATCH v4 1/4] dt-bindings: dmaengine: Add dmamux for CV18XX/SG200X series SoC
Date: Mon, 18 Mar 2024 14:38:48 +0800
Message-ID:
 <IA1PR20MB49532DE75E794419E58F9268BB2D2@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <IA1PR20MB49536DED242092A49A69CEB6BB2D2@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB49536DED242092A49A69CEB6BB2D2@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [/Tvn18KFNAAjoTgdgefbrj1RME0n3DxMVAbczuAVNCk=]
X-ClientProxiedBy: TYAPR01CA0062.jpnprd01.prod.outlook.com
 (2603:1096:404:2b::26) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <20240318063852.1554712-1-inochiama@outlook.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|SN7PR20MB5460:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f5de4b7-742f-43c8-e7ae-08dc47161b07
X-MS-Exchange-SLBlob-MailProps:
	iS5pQZgsAQC2q90QthcXzz/6SAXpPIRrDXYBbiJ5dTtNfWJwaG79xth2+7fFi/TVXSDHFQ5APfh8qg7VGt28+ADpr6ikUABPQ5EwxI1SK8GHYd4/Fuwr+h1nnTxtrCxJtA56xGnl//tIOyqwC2z8buKzRN+vf6cB2q4rarAh7BFCZAgdV8EVZPn2/vCzWSeVA8Brut76MoDrlGjM6OZU4bBfEmSFg65/RLW4/7jlgknChSBAKXussesYlqrkN9Wu3qmSGct+bjrqgRQyBk1eRfUglzgnD5kbqETrvJYEBHkI4h0lCIJRVrGOyQP1EvoEjNLYYvLjnhsXSSmjbbKUttvoRl6Dp8vKJOwziTJROLp4eOyskUZ6ysfKn/oixoLbP6oaXE4qUehpUyOgz1xoQb8kynRJwXRXC2vqlPuXcGoeitVUHAZoSmlPu2s5xlfahHzMjAm1yzGuRfXBYRUk4Eua+eePIRz29itaUqq2GGjAO6XHsIUDk2mEpf7TW9WtPS3rid+2a/AftsrXaNuQeg4w9rEnXKeLHYHHjY8tZZg40l7FcHXJGC0Vvw/2BBKMVX5o7ebrSFn9C52X/ZJu5dvgbm0nqMd0CDSktZWSO5o6ifRtfLAHZXUSl2jGW/AjETXWhq81jTJsuLkYDlqyRu2/yFfPLe/GJmcs9dHyzJaHuDoZNQT9aGu12BZKrMtNSXiElYeLBY3YSCh2MCfht0bzGBjRnqHaVR24VFuYqom8y4Lw5xDfNlPmVjTtN+qj+ev7pH4ggv7wtdLmPbwsB5pgn0wr6berWYdVfrzvPmbelBZGYheJqj2K8HplsZae
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xNla0AEn5u4wf0W7wxLEbWQZpT4rPLOM/YxP7vucXOhpHc3PGf80zcLTjAfgO1AJPcZKGASZMMS//McT5kRWTizZXGkWTZ2DDgXdAxvx+7HXXRGE27CJKT1CcJQl8EHuIZTgtD/FOuIqKyq1pO0P5taUOfhk5iT8m5hd1stvLvTxzoYhcZqD44O6Ufp1XEfLNcbWc15XuVoHvDJUdMuJt2MSygSuzYxGOvEl5nVzwo+RablaZG04x2nhDm28CZwMM1EGVfxIp53zPksQSA5SqFdNfXNbqMKslbMdqimJjbr1MJOBOozYcJK81mSUh2O52msi/9VJQTgHl6bmtsPkXdtMW2CBByWN5D44Q7ikXS8W9eGW+XxrVUqsAn67BUMu70BA9nJMy4cw4Y8cnIxoBglc8hgEC5iDgdmIRZo+SXqfNzGMvtw0GWzs0lerAu/rSmL09PuRPA+q2FQ0KqzAM56wu7jszDTB796cIeAFTLefs+vWwFTEtCOtq9Xg0JPJfS55IxLDTSWrhu+jiQKnyVhCgwEOxo1toU3i835XWZZqtjvLw665PLVerqUd5P+yKpKXAG9/0NMz/xThuQb30GIcsKUWFDwz6N+5/7MIcXvxpGDCAPy050jyfYjFlp8tKMyaC6BGbC8r0oep3pZpdK2y9IfCEK8Ef8ctl6nCjzfqHNCPALRSV9TGqD6IlKXsfsAfT+7vCT7nJOCwajM+bA==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cMftT1QzvqKFHiiA3FibTfQvMbTeijCzNRd5eXUXVJN8/j7pDRhSjeYSBqDC?=
 =?us-ascii?Q?1FB/NNVa+tOVDlU/BbVcckLERXzzj8biiZfq5/g3+4EAMT/OQdi0lSs/Zb4c?=
 =?us-ascii?Q?wd50zDnEd1lyT/RwAkyQ/Ym4w3uQvN1u4XDoZVinFn5W9KSveRourAR5fk6p?=
 =?us-ascii?Q?YGmuLC2BmV/+bKMnydL9wEdwnJowD6uZ4OLuaLJTS3xCFnOmHHRNbynheyZS?=
 =?us-ascii?Q?RzXpLYMGTgU/wpJ1+2Zz+FWoMqkVDyjOMLQkpRBdApeAJzp2wDHIS+K20v/D?=
 =?us-ascii?Q?2pSkkjnuf34K4Bq/wuXo0kOgfBbMTdaNu1rRhQ1OHE3B90RYAxb7oHIqjgE4?=
 =?us-ascii?Q?bJdTMJ0LWMzdMBHzd6FzsGdHeUsqRlqIpyZBmTC45mziY9/5+41AFpdXo9VU?=
 =?us-ascii?Q?OAYCg/dnLBRBgC+c71lr9kaudiYXums++8pXgA851Acq3LrD2TaXM1Sqt9CS?=
 =?us-ascii?Q?HURA4DVoR7fxrrtRJawd1/HYrz80bU2izOKQDFOiMhBNrKPvqemZ6j21Emer?=
 =?us-ascii?Q?MI9j091zHoJsK49ub1eES8KSQmgT7JmNzNwSZlE/AAyYaIkljy4MwdY3HBjV?=
 =?us-ascii?Q?mQJ3gUHHKv4QeUeSXLfTSS+ld+U3lZ4vtxU1TGej5OGPL8zF8CHFYIqOS64G?=
 =?us-ascii?Q?vmMu2p0cssO0vTi99t0MHnGqceT+mSqGZb1XUe2pseBOKmfAAxVzujVmLaEQ?=
 =?us-ascii?Q?zQzwUj1wYhp27LRqnVvwJCcHgX48cmvUZ/5Y+XB3ammkNhmLFIBqXZ51AkxN?=
 =?us-ascii?Q?CeuJDjkStHXaKhH7LTPbNFnsqkRV1rQ4VyaCvkNQKAct3gFVc9M3uSf/l8L8?=
 =?us-ascii?Q?FV0o9hh/aVf/He/0rLcK4V6V4szlgdNK7m4XtoI8jRDoZTRB3695o7YwCz5Z?=
 =?us-ascii?Q?1gWm5NbidpZ1sLM5nAPg1c/DiO/ZamxtIQxUY/1fr9lFL6bbqj17rcOT35nY?=
 =?us-ascii?Q?NsTE548lsjxI78mSt0L8Fq6bQyMaQ6kfN2+QuuDen7548JJegM2yLSYIVS0O?=
 =?us-ascii?Q?a9bW1QqGJoLXZI3s3DzklwKUeUISTAWnrzqegI5wD7fOOiEh8t/SXQ5Ufv6R?=
 =?us-ascii?Q?GiHCBc9RxGrT9K3n9IwmM1qiM2/BXrDBGiHb2KN6AycChuDMQs43seBxJ9/u?=
 =?us-ascii?Q?iyujcLYazcpRAI9/xyo2faYDsLowPGB8ZHiLL/GyQEkaVLqZZyg4sBx2cWj0?=
 =?us-ascii?Q?HywZYfyOyfwnYQqPSHa6jgSbW2bj7dT8e8tPc/NiMorgvPi4fP1KmXXySL3f?=
 =?us-ascii?Q?5f6Swv/JDvO45lTEaPcl?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f5de4b7-742f-43c8-e7ae-08dc47161b07
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 06:39:04.9468
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR20MB5460

The DMA IP of Sophgo CV18XX/SG200X is based on a DW AXI CORE, with
an additional channel remap register located in the top system control
area. The DMA channel is exclusive to each core.

Add the dmamux binding for CV18XX/SG200X series SoC

Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/dma/sophgo,cv1800-dmamux.yaml    | 47 ++++++++++++++++
 include/dt-bindings/dma/cv1800-dma.h          | 55 +++++++++++++++++++
 2 files changed, 102 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/sophgo,cv1800-dmamux.yaml
 create mode 100644 include/dt-bindings/dma/cv1800-dma.h

diff --git a/Documentation/devicetree/bindings/dma/sophgo,cv1800-dmamux.yaml b/Documentation/devicetree/bindings/dma/sophgo,cv1800-dmamux.yaml
new file mode 100644
index 000000000000..c813c66737ba
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/sophgo,cv1800-dmamux.yaml
@@ -0,0 +1,47 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/dma/sophgo,cv1800-dmamux.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sophgo CV1800/SG200 Series DMA mux
+
+maintainers:
+  - Inochi Amaoto <inochiama@outlook.com>
+
+allOf:
+  - $ref: dma-router.yaml#
+
+properties:
+  compatible:
+    const: sophgo,cv1800-dmamux
+
+  reg:
+    maxItems: 2
+
+  '#dma-cells':
+    const: 3
+    description:
+      The first cells is DMA channel. The second one is device id.
+      The third one is the cpu id.
+
+  dma-masters:
+    maxItems: 1
+
+  dma-requests:
+    const: 8
+
+required:
+  - '#dma-cells'
+  - dma-masters
+
+additionalProperties: false
+
+examples:
+  - |
+    dma-router {
+      compatible = "sophgo,cv1800-dmamux";
+      #dma-cells = <3>;
+      dma-masters = <&dmac>;
+      dma-requests = <8>;
+    };
diff --git a/include/dt-bindings/dma/cv1800-dma.h b/include/dt-bindings/dma/cv1800-dma.h
new file mode 100644
index 000000000000..3ce9dac25259
--- /dev/null
+++ b/include/dt-bindings/dma/cv1800-dma.h
@@ -0,0 +1,55 @@
+/* SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause */
+
+#ifndef __DT_BINDINGS_DMA_CV1800_H__
+#define __DT_BINDINGS_DMA_CV1800_H__
+
+#define DMA_I2S0_RX		0
+#define DMA_I2S0_TX		1
+#define DMA_I2S1_RX		2
+#define DMA_I2S1_TX		3
+#define DMA_I2S2_RX		4
+#define DMA_I2S2_TX		5
+#define DMA_I2S3_RX		6
+#define DMA_I2S3_TX		7
+#define DMA_UART0_RX		8
+#define DMA_UART0_TX		9
+#define DMA_UART1_RX		10
+#define DMA_UART1_TX		11
+#define DMA_UART2_RX		12
+#define DMA_UART2_TX		13
+#define DMA_UART3_RX		14
+#define DMA_UART3_TX		15
+#define DMA_SPI0_RX		16
+#define DMA_SPI0_TX		17
+#define DMA_SPI1_RX		18
+#define DMA_SPI1_TX		19
+#define DMA_SPI2_RX		20
+#define DMA_SPI2_TX		21
+#define DMA_SPI3_RX		22
+#define DMA_SPI3_TX		23
+#define DMA_I2C0_RX		24
+#define DMA_I2C0_TX		25
+#define DMA_I2C1_RX		26
+#define DMA_I2C1_TX		27
+#define DMA_I2C2_RX		28
+#define DMA_I2C2_TX		29
+#define DMA_I2C3_RX		30
+#define DMA_I2C3_TX		31
+#define DMA_I2C4_RX		32
+#define DMA_I2C4_TX		33
+#define DMA_TDM0_RX		34
+#define DMA_TDM0_TX		35
+#define DMA_TDM1_RX		36
+#define DMA_AUDSRC		37
+#define DMA_SPI_NAND		38
+#define DMA_SPI_NOR		39
+#define DMA_UART4_RX		40
+#define DMA_UART4_TX		41
+#define DMA_SPI_NOR1		42
+
+#define DMA_CPU_A53		0
+#define DMA_CPU_C906_0		1
+#define DMA_CPU_C906_1		2
+
+
+#endif // __DT_BINDINGS_DMA_CV1800_H__
--
2.44.0


