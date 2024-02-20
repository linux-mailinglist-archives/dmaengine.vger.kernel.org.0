Return-Path: <dmaengine+bounces-1049-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A0485B8E4
	for <lists+dmaengine@lfdr.de>; Tue, 20 Feb 2024 11:21:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D12E281B4C
	for <lists+dmaengine@lfdr.de>; Tue, 20 Feb 2024 10:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D526612C2;
	Tue, 20 Feb 2024 10:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="poOyfE2h"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02olkn2081.outbound.protection.outlook.com [40.92.44.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7198160EC1;
	Tue, 20 Feb 2024 10:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.44.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708424460; cv=fail; b=SItjhFtczwxlkxbzJxDzAcUKtp5O1BpHEoMgCenXw2F079T5NNp6p6QpDEIi4165qE5ZTbF2wxX+cv3lEQ/8zaKTLDHbYUgEd2XhhXECi9HOE3fjq9Eaj8GFugUMdQ+resnXrcJyPddOFkd6QziRulP7qB10+n8lR9Ix8OFB/po=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708424460; c=relaxed/simple;
	bh=KFjDzG+7y8lC9tvfGHbYkI88rh4Bwc6aVu5oAP3VAmw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SPMZbG2g37N0iRkwAC/xDSnUq0HqIQLeY6++PgvSEa332mDaARuz4YW1ToAphEu3uqyuOs/nUSP6V8JXxUjinZ+uSZcOoVYStkhyMrq1YHeOtFtbtFiqUlXeQj5QAR/YLFILzumn9xcGeghIN7IeUBvAfTlFdthFEp7DpJNvHe4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=poOyfE2h; arc=fail smtp.client-ip=40.92.44.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fT6LcGl5e7x3n2yyA5ksfnQy1d1GzgU6dQCYaZZqx+eXGNR9vJkXTiAk/s/nzXxbfPl+z4jY7gTlyC106sw7wj0qmpagzaXMhjm7LhKeLNrd8+LmlrHnujKV1yH17S6WhtskIlJZgEVrs2kacfe9Gue60jaTnuVhnZnrLh1Mml1ABhOPLeYeemXBBFtLlxM+6LHYyxwC1+oMXf0AMI0Uh31dJZIr6LYfyy/K4SdgnRvPHRSre3LwWY8yjSYDvQYqoCLE5DYywIpk3cS6Fn6MIhbFtSKiXC9/k0lMTNwr3f0uFjOicW/vTpri9ayEYSYpVl6IN30RxR7XxgviBIf5mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3I4Jl06eg62S7kOQvj3HvGIzNzzrrdbNmYBf6ba374M=;
 b=SOePw4NJoUiEGdqcnAT2iFv4V6l/4ndIeFJ3thmIioOYtFk0JGxQ3WZfjHvXt5SMmOs80/1F7Oqml4wh6svDkemZAYD3I/425FFUV6D+4S/uiUTGPUAycnMhmXT9XXx6Ys7jltU/Pry8I3tzRMQzUEkv+3QwQbI8C6gz4sDTLbcA47tjYnMJ4m/p+UEgo/eY56MoA3EdwzYsTTWnbKOiMAgFufWJi0Ij3yUisHL1lDvY9YJS3u50roVRyxQ5MN1S+MAvI1N5/vQQW21sKCVFhzyNAZ92iRZ5LMf12r/Ft1bsRr77aIAqiFUDefs/e6F4fLCu1QzhoR+iCt7fpICWgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3I4Jl06eg62S7kOQvj3HvGIzNzzrrdbNmYBf6ba374M=;
 b=poOyfE2hVxjmGS04+o7XzD7QrV5fa8Zs1WGW/U1rdNm/g3OszSlLM2NgCaWDjFI+0Qrgj8huAwz2KxfnFQPjN5tuIMNK0PupfSBuw/oOmkOu9QN8LkphBxytJIcG9LwZOkItuXLcad9i9NMnx1osRp/g/faip7AnJqpac1Cm2H0MeLvvVELkt1QeuZgFKbClyBLJE2xxApViVUKEiv6OxABrCz6LImLXQXbbBsYnLD3S/8EcLnoFQAkyj83Du+0rOa0v/sb6x2Btl4NGEaN7/6u6qbK7MlEHnZX6I0gvdortL8RfyXMRlJr10pgB815WHtT/hprUh15m5+akdasrFA==
Received: from PH7PR20MB4962.namprd20.prod.outlook.com (2603:10b6:510:1fa::6)
 by MW4PR20MB5156.namprd20.prod.outlook.com (2603:10b6:303:1ea::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.31; Tue, 20 Feb
 2024 10:20:56 +0000
Received: from PH7PR20MB4962.namprd20.prod.outlook.com
 ([fe80::4719:8c68:6f:34ff]) by PH7PR20MB4962.namprd20.prod.outlook.com
 ([fe80::4719:8c68:6f:34ff%6]) with mapi id 15.20.7292.033; Tue, 20 Feb 2024
 10:20:56 +0000
From: Inochi Amaoto <inochiama@outlook.com>
To: Vinod Koul <vkoul@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Inochi Amaoto <inochiama@outlook.com>
Cc: Chen Wang <unicorn_wang@outlook.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	Liu Gui <kenneth.liu@sophgo.com>,
	Jingbao Qiu <qiujingbao.dlmu@gmail.com>,
	dlan@gentoo.org,
	dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] soc/sophgo: add top sysctrl layout file for CV18XX/SG200X
Date: Tue, 20 Feb 2024 18:20:30 +0800
Message-ID:
 <IA1PR20MB49537CFBD486B194466FAD8EBB502@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <PH7PR20MB49624130A5D0B71599D76358BB502@PH7PR20MB4962.namprd20.prod.outlook.com>
References: <PH7PR20MB49624130A5D0B71599D76358BB502@PH7PR20MB4962.namprd20.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [QGHKI2NMpLVbJ17sOrY9CTP2FjxrYgo0JCsdxpWM2xU=]
X-ClientProxiedBy: TY2PR01CA0012.jpnprd01.prod.outlook.com
 (2603:1096:404:a::24) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <20240220102032.870200-3-inochiama@outlook.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR20MB4962:EE_|MW4PR20MB5156:EE_
X-MS-Office365-Filtering-Correlation-Id: d74b1317-2624-4809-9435-08dc31fd96f9
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ZS7QeZPCnCqX24HoYHKr/FuyY6oT/3VzxCMKXc6FZfHcd9zapiCKlZ8qAwgF0dWyfE73a4j0zkJt65ofyiaGhOaRULbIMHgxknLN8z4QIQXWfW/Qxt7x2tBuFZ/aFvWWIPNG4AEf9QhCnSux22BQUfs+dfdQBQw/SfhlBchtU5MXcJm2+d1vFB8PXNqNb73ln5JENj0PuPvToJb2KrjuY8AbPUqWQKiF3G1CX2cDuDFyMcW8SB9uBLUyYQKTGuvF2BpqfzRqZRTug2oSTIhYYOCyp1/lTdC2yNMInPzwMMR5a5jzAvvpGaGAqLazdu1x7Q6YQ5ZUc1WJ8SDH5wRwENOl7hysToVpAH3bDC+p76dDPtpe38yif5Q5IZcJ9t4Q5g/8K6oywModRCfGX5EmJGvif1b/sI9xxHBmBKo2NSFtGTcQF4RbBRcSnKfuviWo+tVHWXMI63NSsep925pbsMbXcMvMGjBwv74pPaEWsy831pfg6fqMIwcXujeDnJ6LbPz/Mp76TDud+tiRR5rp+GA1mSzLli917ht/IJqtB6uzftxBmPDOIVk9VbkmKahwtO1nLUp0m+yQht2oPGlNeocoUmMYK7hq6uyPIGIcKNnyKFIsTRXfkJjNPuv0nOVS
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KDHtKMF+m2d4kp5gyozSrnhC4YNbUljvzGmpgV3XKd1fmujY1ddK6/i83DHQ?=
 =?us-ascii?Q?RQLfoTDxAtiOpaP1oqO3yZ+W5/aPqhHwXsl88x39ZtUQRkrymU5mBqvcSSPQ?=
 =?us-ascii?Q?sMv56DoUP1zmFOJ+DvPIVv6vBB17l9zLdi/ZhvR6iIkNiTK3LD3ubJ4ODSoR?=
 =?us-ascii?Q?fF6J60KxeHGliZMOU6PoN8V/JtfCn3SVcrFwQB97FtZGQY+ctpK+cmaW+ZUA?=
 =?us-ascii?Q?DE9iowapnOZ2Ju0SUSMVm7jriaHTHUto3dkcDfWINbgKcr6Vym1rj/TfcDEI?=
 =?us-ascii?Q?eBR6YeBHxTgy2UmZleXEI2yyRZHnPingWqa5oinBfeePnHCvVwh+MBMYikt6?=
 =?us-ascii?Q?KguTKKuAjFfjMaCHlh9I/ipPKyjg+d0EEJRSMg/w44AHiuioIBzDRGSNYwf3?=
 =?us-ascii?Q?aw4NLF3qgNVscU/QPPomVBK7LF6+oH5yafawthstDa1wtFkpdV0Ev0Ks65fq?=
 =?us-ascii?Q?SRzpGYJ50ZH91ipSW0XzwElBdjCWqeMXvRZl7dlXy1nS/0CwXIImq74V5hPL?=
 =?us-ascii?Q?BXANUSRyh//e8Dj27FdaGQlKs2kPeXTJ4WJtOCmBPlV1nhCk3e3oYaeeXaGe?=
 =?us-ascii?Q?j14D1g7pp+QDhtsDbdwM9JqOqduG5wXCHG9hfD+YjP8AG0e82oFYl0aV3/sP?=
 =?us-ascii?Q?z6HEIU17xbWuH4mvwnXLZz79PAxwi0y5laTd7CIimplmZWokSVpBzTLi+QAY?=
 =?us-ascii?Q?8Yx6j2xkpFBroZ/X+nuyUTwJQJipUoWGmaM0MpnlkS4/AOvwWs8XOxZ5V83J?=
 =?us-ascii?Q?y8Ej3EOBLOW3jB+AxXuP/ZMuz1Dx7H+JOFVecNI9iq7eEj06Mtrpq66yPtPS?=
 =?us-ascii?Q?HnZs+dHf+47x9bLRA4hKFEOlLaROJe+Cb1LBbFKolqcENGNA+s+IhLLi8XPl?=
 =?us-ascii?Q?rr2bG8oKLTet354SsaRm6gRofBX/H+3wMXZlAXlHvVCPg1Yh5ihX0bCRczuY?=
 =?us-ascii?Q?dnDHvTk4k++J+PiHJyxvi7b1bWU5ugW9Q5dpSYkxB0e+5L/WqKwDONduEUpw?=
 =?us-ascii?Q?hzsUy78XWGTUt/KtriwXPPPi802TIMQtPM3j41iFikPUeELe28lQj+oVkKIM?=
 =?us-ascii?Q?d+ojZVtaj3gGn0Ef9cHwmkzR9gwi2ewnJ0DjZsONFxnJcovyZWCDs28b3v6T?=
 =?us-ascii?Q?TbVikQBFWlN/uJ+OIXxbZ7wdNbuhMxCfowJBJtv0FPr/gF3VloH7CgmiX4aW?=
 =?us-ascii?Q?vrhKBF/fgrdCqMOZyNItn/RTXmFPXVIWKVrPJm1sfQb1j+aGyxxqZ4miSUg1?=
 =?us-ascii?Q?VeStawthco55kHhBdXr7?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d74b1317-2624-4809-9435-08dc31fd96f9
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 10:20:56.1354
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR20MB5156

The "top" system controller of CV18XX/SG200X exposes control
register access for various devices. Add soc header file to
describe it.

Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
---
 include/soc/sophgo/cv1800-sysctl.h | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)
 create mode 100644 include/soc/sophgo/cv1800-sysctl.h

diff --git a/include/soc/sophgo/cv1800-sysctl.h b/include/soc/sophgo/cv1800-sysctl.h
new file mode 100644
index 000000000000..b9396d33e240
--- /dev/null
+++ b/include/soc/sophgo/cv1800-sysctl.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2023 Inochi Amaoto <inochiama@outlook.com>
+ */
+
+#ifndef CV1800_SYSCTL_H
+#define CV1800_SYSCTL_H
+
+/*
+ * SOPHGO CV1800/SG2000 SoC top system controller registers offsets.
+ */
+
+#define CV1800_CONF_INFO		0x004
+#define CV1800_SYS_CTRL_REG		0x008
+#define CV1800_USB_PHY_CTRL_REG		0x048
+#define CV1800_SDMA_DMA_CHANNEL_REMAP0	0x154
+#define CV1800_SDMA_DMA_CHANNEL_REMAP1	0x158
+#define CV1800_TOP_TIMER_CLK_SEL	0x1a0
+#define CV1800_TOP_WDT_CTRL		0x1a8
+#define CV1800_DDR_AXI_URGENT_OW	0x1b8
+#define CV1800_DDR_AXI_URGENT		0x1bc
+#define CV1800_DDR_AXI_QOS_0		0x1d8
+#define CV1800_DDR_AXI_QOS_1		0x1dc
+#define CV1800_SD_PWRSW_CTRL		0x1f4
+#define CV1800_SD_PWRSW_TIME		0x1f8
+#define CV1800_DDR_AXI_QOS_OW		0x23c
+#define CV1800_SD_CTRL_OPT		0x294
+#define CV1800_SDMA_DMA_INT_MUX		0x298
+
+#endif // CV1800_SYSCTL_H
--
2.43.2


