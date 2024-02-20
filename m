Return-Path: <dmaengine+bounces-1051-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4BBB85B8F8
	for <lists+dmaengine@lfdr.de>; Tue, 20 Feb 2024 11:26:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E973B1C224A8
	for <lists+dmaengine@lfdr.de>; Tue, 20 Feb 2024 10:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28C5962171;
	Tue, 20 Feb 2024 10:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="PHUvAw+5"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12olkn2030.outbound.protection.outlook.com [40.92.22.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB9C6166A;
	Tue, 20 Feb 2024 10:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.22.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708424755; cv=fail; b=FsZUUSEbR/uhbirT3t2Q68blYBdMdyNaU5KN/o8H3CkNUuRMRDohQjo8NvfMBR3pwp8f95j8u5rCZIvarfssVE8sPbwj1KLzescLxDb6jpzKWMSEXIJTu34cAPiLa3OoCeCSSElsEvhyZGzmviT5i+vVaGN+kphzCbYan3iIafM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708424755; c=relaxed/simple;
	bh=jZYL1KwmKs4lkwUyd+2oKIz4gaxXCtGAgmToRjR+srs=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Lxe/BBoHiuEfuvkhrgVa3CwfpfcBAQiA5TJn17EsLqoA9MpvMRriiJXRKBFwfbx/oBgigLz8TSXLySM9/CuC8M505BsN1jyXUWsiIKeoRyBW2TzRoocjJQoeYgstBsLXY0JZIZX/Gt0vxvEPk9EZbS2DtYRy0vEuRgcKHthPV9A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=PHUvAw+5; arc=fail smtp.client-ip=40.92.22.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kxYTI7hidFU/OEUH20l8zcU8CbhGmpHv7+h2MYq9N0Ci9sajnMEpi2GTXhBTRdUvwVsq1IKnne6kLzgyrIEi+nAnV343abqyjcmk+SCNb+TqCvqZ+FRq0KlxkgHPPfThGwvF6o/sbmB+QCh+rUSbjR2hblHz6qIEc2F+EdZEq0hTzbvpdykKmebW8CkJUOs88JbvDym27HrtfqcKzn4oqcHbJQSfKKp0g0vKVIHHjU7KvImt2j76TYpj17W1VA3gDy+InTff6jK9nDTIDpHK/vSN68ETw5w/LNdQJtDgwd4srCHBA0Tfd4lEDTNCasaFLZXtekRHgoVgUH8ZolXhSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=orV3Wsjwr4nw1KXDjPNNhJzqk8xIk5dbZSLadb/zT6k=;
 b=g8gMwC2NAehAl8rlPSkzKnT6iC6EyxFlfLCIgddjUHWb3RLf/qWwGCwi/6uM6f3EGOWharkDm5jJpyVpM42GEzUOCQPwURW1POUQW5m/8TOgx3ytIkpmTWrGh4Ul0699xZvR7/Fl8lmTaPnlGsrevdb7zWdne3yreSVBVO2G5QQCJANYc53bSL2yRTY7lG1JJ9YzCBGdUazptvaGRgBodxnLDcLygBuP64SI9W0rERAUQ231ZHDByJouUwL75XvEOxOyK9nD/aj0ylo/MJPrZZbdvviuCL0Y+LhK0Ph5v1iSnr7EAwYrZ5D469ztzEwGHUPddfbPieLhd5bJO0zM/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=orV3Wsjwr4nw1KXDjPNNhJzqk8xIk5dbZSLadb/zT6k=;
 b=PHUvAw+5W2Najo+N8j61TFteFAQgPVQNBA9YqgLdNoII5K+g/l7sKJ0cCWDnAvPeyym0JLsvxff3W8o/Ojrn8pS71VkK2QXQH5MmjvGUmNnB7lL37GXebdVvK4hvEkHWiZcim+YuA/oGTPpypa3nytKG2jtKRr4HKnFBsEwk6+FDSG5pWnEVndv8LkZALGbUwu2by62S+UDbZQ17qj9OFRxP41lnb4DdIfkTYrJ5wSZqAMLg/8b2Wk9FeXgUmpURT6iKBkvqftDiV/3Spb+PyKtrwO5F8+rpeWoAHrVvKU/puxGSpHc1A2OFnv6KeDDNp54j2Oo+Laq23gV08r0kIQ==
Received: from PH7PR20MB4962.namprd20.prod.outlook.com (2603:10b6:510:1fa::6)
 by IA0PR20MB6813.namprd20.prod.outlook.com (2603:10b6:208:405::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.38; Tue, 20 Feb
 2024 10:25:50 +0000
Received: from PH7PR20MB4962.namprd20.prod.outlook.com
 ([fe80::4719:8c68:6f:34ff]) by PH7PR20MB4962.namprd20.prod.outlook.com
 ([fe80::4719:8c68:6f:34ff%6]) with mapi id 15.20.7292.033; Tue, 20 Feb 2024
 10:25:50 +0000
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
Subject: [PATCH 0/4] riscv: sophgo: add dmamux support for Sophgo CV1800/SG2000 SoCs
Date: Tue, 20 Feb 2024 18:25:51 +0800
Message-ID:
 <PH7PR20MB49624AFE44E26F26490DC827BB502@PH7PR20MB4962.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.43.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [3w9Rb1Er7kn3myhQrBcbYwd0j/dwal0A08YsW70kltU=]
X-ClientProxiedBy: KL1PR01CA0081.apcprd01.prod.exchangelabs.com
 (2603:1096:820:2::21) To PH7PR20MB4962.namprd20.prod.outlook.com
 (2603:10b6:510:1fa::6)
X-Microsoft-Original-Message-ID:
 <20240220102552.870960-1-inochiama@outlook.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR20MB4962:EE_|IA0PR20MB6813:EE_
X-MS-Office365-Filtering-Correlation-Id: 32c8e1d0-c6d4-4139-a4ac-08dc31fe4f5d
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1d6vjeKoHs1vdogZIXe8mLFnaQ3zLQs1NEGJZxh1f37OQrmoaz00CYLTuJ/MdptZu3KwqDhKry8481OBTCJyogAciQ+YNo6twohFqyfsFRBvDdxa3ixvnvdBW4G6kRU+Vted6QR4/tUq4ig0Zq4eYuvrpN1fbIrz/OCWrP2P0IoVveg+IuwjUm+o5hEkEtPBUQqJ2ZJ6Cfw14HV5Wsrob5yeGas82oBewf5LOi7MJSZ1vJ44V9l/LCfXmuVrVSSx9JxPVAJKl1/b+C7JHmPMoTxZ/Tb3Ai1B91UWKsgFJRrYFn/GufmtAwO5RibAlMmW+y4REcDYUTS/8XRdWTGaDX0jKlncymYvzMFfXV8IY/xCWMs9259HjXWWxgGD5yrLdpWChomPzBY2EGRgZqmuIuatYw4JwFQjwJny5th8ko1R6W0wgjoxxyRWHXwJ8SRgPZpC01mjzVSMzic9VmK5asiQLuo5py7NtiR81+mHgb7b87RvSItw/YCPbxJ/fOlnfAYqXsre5zUEGzcjgecGiKDmiIBJXsr2ri9mzWHXvnfNPCQEb/uxH+yig7eTJ1Yy1VOocWTvq+ghaIsswWik5+lg+tVFjzHcV+LfoA4wowqgQPPDBrHfoHEQbdxyRAWc
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yDPx0JYt43KHiBhYrlK6RTaLQzPUDn41BB8V22vNEwePrpIVjhJBmwvBj7wg?=
 =?us-ascii?Q?Q2DBkFi7FCyQTZFwoSyTWxfaq5kmdBXSYXm/I4iN4n5jt+TclQhPN0r0gBm9?=
 =?us-ascii?Q?14YAFQDCIB1snOHFzMF7scPhGLMnAlCX8D9God2T+Z4AflBOIEUjQKYvQg04?=
 =?us-ascii?Q?Jx3iIUi9m/JhBJEaYVIpkuA0mmuZSzMVHrYpaGk4Sa1dpZqRzk2JMWKxh3PO?=
 =?us-ascii?Q?GJ7de3Nb+4Rner3xdyKPSjv0JoB+uguWXWgLA3xR578mFN07wDeHLp7DasXO?=
 =?us-ascii?Q?ds6eFkkdysJz4oBZbGt0WDJEdtIP0ZoLa1m1ke6ey8CZhVb1llpts8nwmTeD?=
 =?us-ascii?Q?qhwzUNClWzIBRi45g4Tvtq4KYA2BbflZ9r47MVmGjSeXmldRIlF0Rcxy9cXW?=
 =?us-ascii?Q?vobALYl1k4Fx6mbBo3aoNxp+JludJON5pikr5K9TidraSRivmDy2bnLyjC4N?=
 =?us-ascii?Q?KEDqo2tcNeBhCQC7EI1P9AcmsyRWa21eoeorsIameXrCYht8GM13i+Af8rEA?=
 =?us-ascii?Q?6Q8HH90OtJOK8ugCTK1vYlhgI73qVwXmWeYRrmKQyrSsS92hTb+1RUgzIuZv?=
 =?us-ascii?Q?0L6nAUZ61mDwWwFR88rU3EYbYTyfKZO4hJRQTGApbmn03Nxy115WD0Ea+wg5?=
 =?us-ascii?Q?vszQzpf+C7+yu37dbBNdMph6hG8YAM96RcQMkP80eZgcuTwvZAWju15XR3lo?=
 =?us-ascii?Q?fdGF8V7H87UZhzl0xbYxdd0tpqJiwYvQ6EC2wLHLq9/imdHBnxUBwG9k5aSj?=
 =?us-ascii?Q?274NDCzYXgpjZCStRM6vvGAZGBs8bZ9QrII01VKOuVG8zfPVn983beAnxmbs?=
 =?us-ascii?Q?/XgnWpVTSAC2md+c6r37lx5FSSDWgwApV/v4EMs562dbArQ4Xe+8tLoBH11l?=
 =?us-ascii?Q?ruIrRTEMLpmjbLOu+9Jhd0XVu3b+sEtvSLcH9jN6N/DSRIRRqsCJR1fR5ulr?=
 =?us-ascii?Q?c8D2mmNV1FSx53DBaIhcRxpX7GDh9HXDRnTAN+C/ZQkeuR8lLmP4mW6rB+o5?=
 =?us-ascii?Q?jpASoE+mypa6Yo5n/gcuS8pvzMeWegKZEqYY1fqpqJEICxc9cIA7eJDgIcKD?=
 =?us-ascii?Q?NRpVrL7dVQRZDcRdTcxPDDzNC/g1UHuVMyUZTK7iK4cgC+/HhM+yEAE17TXb?=
 =?us-ascii?Q?CYltJBkA0y1bJsidQ3cbvgzrVxiTvEx8xSuINRYqr10p6JJdMvLTrkNCKMtt?=
 =?us-ascii?Q?bTi2DUQUEBh43Jw3dR4bVCW6d74MtvSb9NK07wHMzQOHvhFBOlT3gZdZHxNH?=
 =?us-ascii?Q?5sB2wvON1HquP8yQ3nD3?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32c8e1d0-c6d4-4139-a4ac-08dc31fe4f5d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR20MB4962.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 10:25:50.4496
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR20MB6813

Add dma multiplexer support for the Sophgo CV1800/SG2000 SoCs.

The patch include the following patch:
http://lore.kernel.org/linux-riscv/PH7PR20MB4962F822A64CB127911978AABB4E2@PH7PR20MB4962.namprd20.prod.outlook.com/

Changed from v2:
1. fix wrong title of patch 2.

Inochi Amaoto (4):
  dt-bindings: dmaengine: Add dmamux for CV18XX/SG200X series SoC
  dt-bindings: soc: sophgo: Add top misc controller of CV18XX/SG200X
    series SoC
  soc/sophgo: add top sysctrl layout file for CV18XX/SG200X
  dmaengine: add driver for Sophgo CV18XX/SG200X dmamux

 .../bindings/dma/sophgo,cv1800-dmamux.yaml    |  44 ++++
 .../soc/sophgo/sophgo,cv1800-top-syscon.yaml  |  48 ++++
 drivers/dma/Kconfig                           |   9 +
 drivers/dma/Makefile                          |   1 +
 drivers/dma/cv1800-dmamux.c                   | 232 ++++++++++++++++++
 include/dt-bindings/dma/cv1800-dma.h          |  55 +++++
 include/soc/sophgo/cv1800-sysctl.h            |  30 +++
 7 files changed, 419 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/sophgo,cv1800-dmamux.yaml
 create mode 100644 Documentation/devicetree/bindings/soc/sophgo/sophgo,cv1800-top-syscon.yaml
 create mode 100644 drivers/dma/cv1800-dmamux.c
 create mode 100644 include/dt-bindings/dma/cv1800-dma.h
 create mode 100644 include/soc/sophgo/cv1800-sysctl.h

--
2.43.2


