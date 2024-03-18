Return-Path: <dmaengine+bounces-1402-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 244C287E3B7
	for <lists+dmaengine@lfdr.de>; Mon, 18 Mar 2024 07:38:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CECFC281D0E
	for <lists+dmaengine@lfdr.de>; Mon, 18 Mar 2024 06:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF0514294;
	Mon, 18 Mar 2024 06:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="V1ZUM5UR"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10olkn2031.outbound.protection.outlook.com [40.92.40.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51E322612;
	Mon, 18 Mar 2024 06:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.40.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710743897; cv=fail; b=MgNC7tpcKLiIjd6ChYliBEhN+yhBukfcJU4D9MUkLHkVFOtxCYUiJ0tqJmWRE06VZCbLEldgl+lRamUSJvfAvVyKHMB81RtlhjAfVO+GCxWXxiiQzPoh99fcKntWoGYkDHR9fL0eWNLndjiZ2dcwOAORsaQfSG2IgjhqlRnCeBg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710743897; c=relaxed/simple;
	bh=lMSmNML512n8KmwSLQVvsYiZWxwhfyMt5FQ39Mm4oP4=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=iaBa8KRSe1C+HJRNyAhAsSaZm3bje38GVJtfvfTOQ6UoWMjxxAwXfi22ezOl4IOtd3akw2QzzEUoJgtsxASI9kHOW2pTqPRj30L+mmWLpyxZcCLbNTkF8eSjOD1Wo4OvPDuVNJ4W1b1T7KA7UZT2k7do8w8dDBALyGKTww2F6NI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=V1ZUM5UR; arc=fail smtp.client-ip=40.92.40.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HI9zSjnveVQmwxhiTjMkqlJ9m4eqBRbB1cHjyYdduWGbw2Y5p21sOe/z0AEUdX0D24bY3hRci1siO/HsB9ghQ/94MqH8sbyJnbgn+QHMq2BUH1yNphahv5oodzpk0/Tm2PeKA4spigkwnR65/G0kHVOf2NosFr92JCa1+8aQPXrxsJKiF7bbmdQEYqylN0/Jv9v6NszPe5QZV8+jDmp4ITx15F9yhpUFVs5mhcaWf9d4YKBm9wnK8l8cp2kIwAHCEIjLXy89utjo+pM2kWNkTKqEIqC/CHAF5ioZBij0ayzsrZomr8eGQv5ZOModfUQsSqukRai+OklFCjjYgA1sCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DnVzhk6/LaZGh+iJk+r7Fdhd3fVFc497Q4Ki7jEgHn0=;
 b=n4U5A4rrGdjy7tv883h3lCH2Ldl80NkHytVie0SbvOcXjUMLazkOMRChWRxfTnlhcTbjA0XQ/50FNoVrpGHa94Yi24tcWEOgvdxbC+BDsKh77iGJbftbykoAflnHJe9z7ALK74z7ksyMplw1ovkB2ahqV/p3ScKx4Nk3XEVNITNMOeiUZywQ0F64eXXraNroGFgOYr81D+Mm3I/BbCPItlzuoRcVRNK9g+967sqiceDBBOcD4HjJ3NF0dCLD5TWk3DMfuKXwIsSZBxLXwIshWZSkQSDtEelchRUnAH35FMi89lUd33kWrV+KCoRk1Z/tnY52lbCnenOHzOwpIhWUpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DnVzhk6/LaZGh+iJk+r7Fdhd3fVFc497Q4Ki7jEgHn0=;
 b=V1ZUM5URWFkqVwaPlQMihh4cW+zVDK+/3/hi8HqEKEtzQPDSt/ni8i9gSgSbVsp8i98xf9MUtkjT8GEp47l5tzINng+XZ9b16KlKfXFNqaJvBerscA91Jwe3BppPt8gvRGgeN5Sio4BZ39ZX/zZZk7TfyEYzoLyWYTqZN5gMDcqm5ZO/bBMoum7opKlzGXKASjyXScL48PYEsemKqaIRkcGggdYKgxw3W5GBMJ6xKkgc5qV5NHxNxQ8w8rcVNKxwCSmyEQ6TBKdi/qjoxuv7akgirJCR2ZpFSrMvQSubqe/fwVZrJqc/e6FeoR2dnUmEmsX4QkOKcpdunFisGB3ELw==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by SN7PR20MB5460.namprd20.prod.outlook.com (2603:10b6:806:2ab::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.25; Mon, 18 Mar
 2024 06:38:13 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::8615:efe2:7c8e:2041]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::8615:efe2:7c8e:2041%3]) with mapi id 15.20.7386.025; Mon, 18 Mar 2024
 06:38:13 +0000
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
Subject: [PATCH v4 0/4] riscv: sophgo: add dmamux support for Sophgo CV1800/SG2000 SoCs
Date: Mon, 18 Mar 2024 14:38:06 +0800
Message-ID:
 <IA1PR20MB49536DED242092A49A69CEB6BB2D2@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.44.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [9yvW7r96wnYazEM1f5QhtVaeZ89k1evkOjfMfiZ1BTU=]
X-ClientProxiedBy: TYWP286CA0018.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:178::8) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <20240318063807.1552359-1-inochiama@outlook.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|SN7PR20MB5460:EE_
X-MS-Office365-Filtering-Correlation-Id: e1e124c8-b631-4914-55c0-08dc4715fbf3
X-MS-Exchange-SLBlob-MailProps:
	RlF2DIMZ1qUQWS8lN22nULkf5597sA7Xg1ZGQ3m3O9mAyB3A2QLSFDAa/NRJHw8e4nND4HFa/pS+DBUwPnmkU+TNFJsNxAJINpRKOMrBAJhZJt1mTHkdvWVt7whrZFdZPnBJKb3HjJgdEAwqqs2JObCbYA7n/s7eWGaXlheUpVP8wQS73Zij99I1H9kGjefnTzt52ZIY8c0RYSp0Z8tBRa4VgDC8eBqTT2slcmV/Wab4/9xIY6dTynT96vn5XUOkWNfU696ng0VGJokZI4OcNPcsMya5EZ8jVddB4Ni4vuai20MC5wXCghJrOUNkwSbKdhvgg+bR7Cy9+/nQtA0qPjz9U/mkrGOTconFWFQHXRzioplsiu74tuU1e/yLLiKejjmKj64R8xT1tSa8NNBMWjjfIFS/SrYWKSBWKOH7WmGyMP3taHFDf/P25mhHS4Uru+Yhud2ylYNBWB4Gaph9mZoxGXCEa1IL5Jg2KLyDtkpMrssPWBPPvtcuryD4I08J3E50xLfhvg/Bz1wzXAtZfrTYP3kKy72Of9EXszhhoZjz0tcxAp5FMdEKtOrS3r/G2RI47GXMgy4gGGHidudPf1CcmUY1+VSKi19WZtgGBaiVk4aNhkU8/LmIRPLK69+6bWll+4Fa9d4taCPgFB9WHz7kEMbzZDfAvnbDsk5GtrSSJOz+kv7DmI7KaLyRrSjspvqhsnwlix+DsG4s4FGjzLAnI4ZBVEJ5+TdcGv+7ms1Bu9bZnqsagBczmhkBGQ/goNF010DZcz8GfHxSr53WmT3zCiJuz6a3E5bJWzcjdmTF6NZvDvyDxqoLChbAJnXxENhn9DOq6vUyZheSKwqx/cZO53Qj++qQ
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	nhuYjZOckOpO8UAHvDjIsEWIZZ/oLLnMlghRtpLdbF22IWZEH2dBZsMC85Q1ErCeVlhv358nscSOs69zS2lQLUa2JBOEdcU0amkOpPJTys4CD2P0K/yHO+dUj9agFAKV6pJwdogJfNFmrTXyv9zDH9quZ77qVfiyg0H5nt6ZIHujxxDekCDGqDlgvrNO1VhGftbdRFBwUbUSpHOcZnJ23UpQZ20WRp0ezeKPaVY3N824rWfGCSaHCuIhySY0IfFekf68TzltBPclimRvyKdrgZ5+lLTobjohHLAVBjoLsPjD+N424ezc6zLjN3gXfhDOzSVE0RQFEuZeYLplFe+Cek0otlvVfjcp5NYqzCmt0eH2SlA17v9fCZEvEOIw1SmSn7K1NgE8C+w0NkmAOfyT1zNqLi1NA5DrLflhXgry0ZMuvJANi43Pgw2nl+84EkUOxb6VfNM93/JzXRt6MKi9gAWKdixPspUqL1kfzwxmwOAPr92VpwiHRH9Gn8WPJOcmQ/wxVUxwpH+kGzNt6sgBOAQSqOl14Fjvi9N2Nnj8b/7E61kcyL+G5exLbZ6DjOdi7B9qcKrkR+5jVxiHSG2zrYMh9/ErK5dBGnAuCXHGvYaJV5UqdtN8ujkfbLs5NQ21jP9HJeRICZvDlgaVEg4GCmriYN67hhpzRs27kWYVqnbdRAO7iQBlzdBOkGclLyrq
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KrIvyqJ/bK6+NFzfeRiXoyI0J5dbl2Aw6fCHXZzCaoYhB/fM/VutptxJTeGf?=
 =?us-ascii?Q?piVLmp9h9cNwXNcAKP1fGaKAtUiczVo0Wkhm1sFXO1WLEpFDQc+6PI5D7YQy?=
 =?us-ascii?Q?si/KTUMdnYnXcN3QT5vddpbQuflIYHQQb4zMg/rfvjZc/emlj0Z7k8V5ZAvn?=
 =?us-ascii?Q?BKcmfHO927i1xZOCQp7MFIRbePr/IHWAmp+onPA/eLnoJgDFXM2JMKkcAevR?=
 =?us-ascii?Q?DQhS5e9VN4Jzo70PH0eRJGLO6qVBxqCeoqEBJ1tAewFhFpQrv7ncx2gh9968?=
 =?us-ascii?Q?ebA5oITBOHG9/i2yzCfb/Iiwl82lRJqKrJtVBKVrmnutue6IEgKw5YwGBQFT?=
 =?us-ascii?Q?Chy553pVYJj86D6EgFFls7FhrZOFaCHDTd0BZN77UEAknBputXXRTo6C+Qc0?=
 =?us-ascii?Q?XJMeyAJTmOsAPJ3z5wzVmvHHTn/T7KNSfqao7oHtT+82/p8OqOP41rgA6ixC?=
 =?us-ascii?Q?W5f0S587FCzZ52crEXT0oDIG/ONVe26bqE/jHQtX88K1r0MeRyFbr1tU2+bB?=
 =?us-ascii?Q?l4dztLCguy4/Gmm3PYz8s08aDl6S3v0VleEUcqUWiqy1VDQLt1bPOeJxMjng?=
 =?us-ascii?Q?hNDm9zAn5GiN2Lycw1wFcRvzFwC+w6/a3MZWYIBPmJWxhvxDKpsIsVDGlYG7?=
 =?us-ascii?Q?QJyVJC6spnrCBal53sMvv1bEGZl5z3csnBAxW+1ChWjuvqRM+KPZHnQyHsdw?=
 =?us-ascii?Q?9/AidGfI+P+AhLyNqK3zcg2iczrgnFIIjX6xwA8P7i4d/tzbkLAkitirAa4J?=
 =?us-ascii?Q?Eo4X1euvSF2TLyNTI9wvsee/nlvcDLEznLNaqSsei/42M4YPyIolZoOn4/Ea?=
 =?us-ascii?Q?2vVsYSgoIlnvcx8QotJTzgZcGuh47UE4p21L19pSG83Sy86WiF4KK7KEm34x?=
 =?us-ascii?Q?47OypEPe6WAjAEsS/tDkYgBiBBqlTTLeqMaprq3/5Dp/5bwOjs/8r7/A0JYk?=
 =?us-ascii?Q?P01gUbs079Q9UpAPK6wyShXdrGdOFLtGCE33t53/jJVM9EYfC5lIfZi+IBYr?=
 =?us-ascii?Q?MF8wledzPukCe8ycPKJke/9liJFD7Pvv3nnzj//DNiZR1yOICXBHG0i12Djv?=
 =?us-ascii?Q?9zwVyYDasNv04fQAyvc39l0+mLTb3BCJXyyfLz2/bXQZXDMyhnL+1FGch5bC?=
 =?us-ascii?Q?WJbFzCg6S/eHy9FnkModTn1wA1p5nThVzvXoXHUI39tYQ+Fy15bWVaWjPI4F?=
 =?us-ascii?Q?atlXDITj4uogrh2xaFkqVJUuIRqd7d9JKXuEzPUSoEjo0qi/1h7cghxBMWHp?=
 =?us-ascii?Q?LFJy0pFCfECfdYs40nJb?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1e124c8-b631-4914-55c0-08dc4715fbf3
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 06:38:12.9894
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR20MB5460

Add dma multiplexer support for the Sophgo CV1800/SG2000 SoCs.

The patch include the following patch:
http://lore.kernel.org/linux-riscv/PH7PR20MB4962F822A64CB127911978AABB4E2@PH7PR20MB4962.namprd20.prod.outlook.com/

Changed from v3:
1. fix dt-binding address issue.

Changed from v2:
1. add reg property of dmamux node in the binding of patch 2

Changed from v1:
1. fix wrong title of patch 2.

Inochi Amaoto (4):
  dt-bindings: dmaengine: Add dmamux for CV18XX/SG200X series SoC
  dt-bindings: soc: sophgo: Add top misc controller of CV18XX/SG200X
    series SoC
  soc/sophgo: add top sysctrl layout file for CV18XX/SG200X
  dmaengine: add driver for Sophgo CV18XX/SG200X dmamux

 .../bindings/dma/sophgo,cv1800-dmamux.yaml    |  47 ++++
 .../soc/sophgo/sophgo,cv1800-top-syscon.yaml  |  57 +++++
 drivers/dma/Kconfig                           |   9 +
 drivers/dma/Makefile                          |   1 +
 drivers/dma/cv1800-dmamux.c                   | 232 ++++++++++++++++++
 include/dt-bindings/dma/cv1800-dma.h          |  55 +++++
 include/soc/sophgo/cv1800-sysctl.h            |  30 +++
 7 files changed, 431 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/sophgo,cv1800-dmamux.yaml
 create mode 100644 Documentation/devicetree/bindings/soc/sophgo/sophgo,cv1800-top-syscon.yaml
 create mode 100644 drivers/dma/cv1800-dmamux.c
 create mode 100644 include/dt-bindings/dma/cv1800-dma.h
 create mode 100644 include/soc/sophgo/cv1800-sysctl.h

--
2.44.0


