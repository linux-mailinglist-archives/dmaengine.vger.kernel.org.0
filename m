Return-Path: <dmaengine+bounces-1484-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBA7A88B70A
	for <lists+dmaengine@lfdr.de>; Tue, 26 Mar 2024 02:46:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7191F2C4F17
	for <lists+dmaengine@lfdr.de>; Tue, 26 Mar 2024 01:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 890B222EE4;
	Tue, 26 Mar 2024 01:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="rVq79Ow4"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10olkn2024.outbound.protection.outlook.com [40.92.41.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853B4208C3;
	Tue, 26 Mar 2024 01:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.41.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711417564; cv=fail; b=pREQJxEvImRsPnqbTnqwsWgSaEgFmw8R5C9MgNIh/DdxXufH96yc5zQm6PwJEQdH2eAG94Ry24zxh+J1m48BrHlNyCk+CXg7i5oAhu4sO8eKQvyd4mvk+5WAEtOq2TUEuiptrdy/txV8sv+NkBWbo5Mo0PjyZT3HL/IJ905MDFg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711417564; c=relaxed/simple;
	bh=dqWm5zAKq/GSHzD1vB9i+zTbCMCDCmHglJ3e8R4aWVw=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=DhpcLmcInUL5AJRBxTbntAgJbz8S4zYCifkhhxUg28HrFGfQ0wjg2aZs9hSSZL79S7zQ/SNJOtpV8W5hvSWg0SMcvLucJHAfqs2iP0xBVVFnRzbAM0qKI5EVIGS5f9XTN+Mdw3lvGtbCWi15etdv94bvFEl3E1pno2LqoM9dEGU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=rVq79Ow4; arc=fail smtp.client-ip=40.92.41.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z2M4cBHpDZPbq5QXS5LYR6WmsY+CcmrQTH8tX4QNKAtbQmlJSOo7DHdhlFuVzNrCWkQR/GLVB3PYLYhM3sGrjS+veIQGtjn4N4pg1nW0vjKXIcCJHPCo88S0OM/DT0JKy61rqWRPqC4HBlPU2NMD9d3gao8BsmHo5ugwTCkDnIZItH0+gFeBhG6n/RAU9O9BI86kh3CQ1j4FEaS9We3XMzOw64DLOoxFizhr9HxoES24mDX6FDQ68aiw/jH/rpOuIFmX9sBwEHfC7bXZf/muuQdBB/gmQOfFxkP7fm+SL2mIi4TwKB026Sa5Mgd4GbYAmbvygDM3L1CNbxwq6CK1XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MdkQt52g9uJtdXtq+jz2W+aZgvDttT9s15+lo7z9waY=;
 b=LNab+QzXgOer8H8c/22hiomnvCw4vZ1mgXm5wfRWbZ4moOLTAmCEgdPXnzZK1qVipJQmphm2xulIsT9TTAgWfGJZsnKVshrGxfFuV+aoXmtsD0bqoLc/QK+h46wBH0rl/VN/JSmF8+JRyGicvl0LLRBYcaRdY20U9xY/eZtg77O63PJtXEe3vsko1sObOHcFVFRfuI8K57jPt718g2MrWdbFN2gBIWy/dZnaGFjmf39eMEXH3yFlqlU905gd5wh8SX9zHrCsknhIqaMzLT8wDeIvwiSPchVyd60qoBQRN08QuB8mm6S4eWea+6m99dIDYTZBefW4u7+GvvzT+Y8jJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MdkQt52g9uJtdXtq+jz2W+aZgvDttT9s15+lo7z9waY=;
 b=rVq79Ow4raGli0ZNKtNTvLf/bMFFIyRFvedBbQu+YA66oUN7eDHua7F7SN2cVjzmB6r2VWcruMYCqLeqq0UcSMMGxargJWm/VXIQNVww7lj8E2lfnUHrefVoZV+IF/Y1fhjuELAUdWtHKBA/eDyGMMCcvnalSyoimS2NAAz1hBVk4mii8vCeRxCopxl8hd/EQJS8go5oVvTdSQQPXvN0OmsCgp0N4/yTiwBO/XVEuEpHCXjuxc47Tj3tBJjFB/cWwKNVxdLFJPwk4z6vLbpXXIxsd/DEdWsSEEWJG+m5XmSdtOhhn/Bj3mqcAGhfchgl97fsFyi/UDBzsjF7UqteDw==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by PH7PR20MB4964.namprd20.prod.outlook.com (2603:10b6:510:1f8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.30; Tue, 26 Mar
 2024 01:45:59 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819%2]) with mapi id 15.20.7409.026; Tue, 26 Mar 2024
 01:45:59 +0000
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
Subject: [PATCH v5 0/3] riscv: sophgo: add dmamux support for Sophgo CV1800/SG2000 SoCs
Date: Tue, 26 Mar 2024 09:44:42 +0800
Message-ID:
 <IA1PR20MB4953B500D7451964EE37DA4CBB352@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.44.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [Ju1t0qvI7T8hiqR8uq1Ul808I7/Wh2jNUdsJZP6iPS8=]
X-ClientProxiedBy: TYWP286CA0026.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:262::15) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <20240326014443.323406-1-inochiama@outlook.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|PH7PR20MB4964:EE_
X-MS-Office365-Filtering-Correlation-Id: 4dc25f8a-c435-497c-f99a-08dc4d367c76
X-MS-Exchange-SLBlob-MailProps:
	dx7TrgQSB6d4xbak4tYeMB0D40EITU90IEA4cw4u+gAPEBoWQiljB7PDMloCu9jbplGGDPF6WxHyB62/+AbTvv0mCcWRymB43/tOS41c7Oz/XWNhfSPezQiGPWi/vFIuwA0f8so+4CqUZQdCeUDQMqmKmNlNifmI6XKkRme71+WZikvNrwBN+7maLPAVnYOQLaQz+FEh2ysP6nPIRYnE257sZ1BoY4I6LkfzJKSz386xRV8/wRXYGkVOQWZphv78iIjLNLBpxwKweGNxHZrIhRFbg5v0cibfoZQw1u4/Bm+3Y9Yx2ri5gjpVC4DeBAnjSKPVvFf9vLXVwddQxPhROkWv6j0IoqeLaNhnkhuJFn8SitqeVwJ29/+LBZcKD2Jn1zPQkARMKgKKNsYmLLs7Q88E8MOWW3iMNk7VC2jdzu2ZRb5Nd/Dp1JGAnVEsqNNK6leE9huEZQZ6fnMVZl+zo4PTepQaQnhcJDiQrCJjNjRQv7li7d9y5hRWcE/00Rr39jkdICOMwbnOKz+U41G2llQfCv/7mDmG2FspzQo2aeM6I9IgmMkVvZGvD1VSk5FqpJphtT7tx+3QySq4p4bgb7JkZ9RNKmSWytmQX2qG+tjLlqGMqJINA+1RCjZavMbynVmlTVp7mHT9fOb2QUgHvCsFwY9i6epwSZjbAZO3DDbpd/7M0rgEijWLV8OGuwIObIJ1MRncZOW2XC7DVaiQHynbcxQ1vu7g0DLjSfzY/5NaEDQFfBO1JGBKPirX+EjEIoGt/0aEf5I=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+GwggRdNCdKG+7RPHyKzpnuTZF315HqLCtrv9Nfc63sLE/E4LPI+hs9DMIgr4OTPYn4z0TIL4lNKGm1kyWUK20vPiVnOiU/Q8mmER4WqMjLrhKhpq/27wWjP4M6MQND+FZ2I3O/iQXmbGN4fNqu5cLCjgoO3TkGB3P7Nl/+1bMiY2o4PaWGsW7BjzM5Idxw5ISmP5/KScSmVKhuZrrUfZJ1+dPejV87eDKN2UPtGjJo71IZmu8+gURQ+C31f4Twq3lGlXckXwtPPLeX2s8XOe9HzNc8bnGjS2CateBRikSw5IFBtI07rhuD6w5NuEVpKwR8u5hmn3ecZswgczVKScf5G5ohtY3iTTREUI9AD+pxpiQ8PMxObJIfEYs2V4Uu2XvPFcBXDvcm0vw5GZKbiYp02uLxEcFwUDW6qXmDWKO/Cm8cWuYXZJ/ATg6eSGsobfwz+hO4qGfpqly3QyGZd3Jsemh3NPS6GFCJzHPt8F9oHtMfumAVYf1bhdirxAUu38g7aEnA2ki2+/Gen6zKTv5fYH7e88feAyaMuG+2zKRpir3TlX6Li0eTqaH89QpZ+dO9AOgLdVjg01aQGmg5ZiHToPHXviTQTL9rquMwjwkDDuXXQAMAs2udi0MPnmAJl
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CnqfK5UOHwl+g4X2CLzXOXyg38u+BxiFi2DUwyMDQ6k03fcS3VOCNHMKkGej?=
 =?us-ascii?Q?rIAJYdIxYP3Eb8q5Ys0yHmPQPfOoMD4a55a3nm1qkWRwTgoPF9+6BXETWQ3P?=
 =?us-ascii?Q?GPQK0RY6prBMqs1H8J/bHyzgi7aZ5azI/OC4lVB2s3S5bqNtU+tjKSoWIN1Y?=
 =?us-ascii?Q?x0viinpMfmtQKtTuqlI8lwxnaR/erd6vboqi6nPfOGyw0phzysSKuJgLcYVT?=
 =?us-ascii?Q?mCTHaYdsk3gOC/XlSUEOuBv4mUptEVQwaqksaj/ksMQ7voUXbV84v6F8ShWS?=
 =?us-ascii?Q?Wy9ptW71lOfGYV428qSMsE2sX0h8ATmn7+lQwt5OWAPW8u+njDkXm+g9AJ3r?=
 =?us-ascii?Q?qf1ItjIj2sBvXi35HphLi2ii0rI+WoY0jR7Dbt32zjDWfG/wqAYpSbU11Dgm?=
 =?us-ascii?Q?Kc3d398S+wRjlualQbAJC0JDWMqBfK8UpIwfQlZ+3s6A4HrhJSUaoQEUYXnZ?=
 =?us-ascii?Q?nAufenaxTSXxTCm01r2J1hghaWJAfoOC5elhTHB4zjOAbUgUCUkysm0kOI1W?=
 =?us-ascii?Q?ZuZvWWelAzrIJ5614oJ6OoZgvKANt7pWUCdTfM4UYimOBO+XWlaquUpzQ93J?=
 =?us-ascii?Q?FDvH3DW8Ep5++idVF9dv4lGNu/i/k4c6HoKkjbRfJXQtbyQgwNdhE/teq8HM?=
 =?us-ascii?Q?0iXcjueWAOdnJAzfuzA2vhgwjvzZq3tPN2KtJ+p3uPzVZpTckkQibm1eesYl?=
 =?us-ascii?Q?Ru9OrZjWD3bP3esD822WxPxJc6tMSrHwvq/zhcQc0Eb0DF81ED2vvD8CZYFz?=
 =?us-ascii?Q?+RGPqkUD6mHC4RIpBNF6KRmDGsJUtp82xiul6vGZ29boQ830U2vEdf7ajMKT?=
 =?us-ascii?Q?Zd30qJnlDie2C6TmM3Ze0HlVGYNwrEWLE9RqtFbTTZMb3Y+lFXPYWCJjfDdS?=
 =?us-ascii?Q?bWHJdC22W2OmiRtTs2E5CBDnajinM335QyDzmwEwPe+y4sV+v6e6cb6qIf8h?=
 =?us-ascii?Q?L19pCJI++x0xTYOS4EbKEDDBd5OL6bdb+XDRFfChH1UpJerqUZMuGCBTzzj/?=
 =?us-ascii?Q?/xYDHrJxq8Q51UM1bs17bDmQcobl42EZB2i/r7X1Q63pWFearMV/hQYtu24C?=
 =?us-ascii?Q?kAa0Ww7zAsWZ95SGxCxJcjKxtb4psTtWtd1FkhuxVr9OYGmHLtaVxlv/Qtc0?=
 =?us-ascii?Q?vUOvQbZK0wamNyG3d3HUpmBzgwKHZhd09ABuBAicVtacgsjcrPQeD6sFAC0+?=
 =?us-ascii?Q?C2k1Fai2uHnIuaiabJ+0ET7n510WNHcSiqmYE9fPvQJW1DG3pS8v+DL53cGO?=
 =?us-ascii?Q?6nxK/znxAK+wDB5mcvYW?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dc25f8a-c435-497c-f99a-08dc4d367c76
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2024 01:45:59.5968
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR20MB4964

Add dma multiplexer support for the Sophgo CV1800/SG2000 SoCs.

Changed from v4:
1. remove the syscon binding since it can not be complete (still
lack some subdevices)
2. add reg description for the binding,
3. remove the fixed channel assign for dmamux binding
3. driver adopt to the binding change. Now the driver allocates all the
channel when initing and maps the request chan to the channel dynamicly.

Changed from v3:
1. fix dt-binding address issue.

Changed from v2:
1. add reg property of dmamux node in the binding of patch 2

Changed from v1:
1. fix wrong title of patch 2.

Inochi Amaoto (3):
  dt-bindings: dmaengine: Add dmamux for CV18XX/SG200X series SoC
  soc/sophgo: add top sysctrl layout file for CV18XX/SG200X
  dmaengine: add driver for Sophgo CV18XX/SG200X dmamux

 .../bindings/dma/sophgo,cv1800-dmamux.yaml    |  48 ++++
 drivers/dma/Kconfig                           |   9 +
 drivers/dma/Makefile                          |   1 +
 drivers/dma/cv1800-dmamux.c                   | 268 ++++++++++++++++++
 include/dt-bindings/dma/cv1800-dma.h          |  55 ++++
 include/soc/sophgo/cv1800-sysctl.h            |  30 ++
 6 files changed, 411 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/sophgo,cv1800-dmamux.yaml
 create mode 100644 drivers/dma/cv1800-dmamux.c
 create mode 100644 include/dt-bindings/dma/cv1800-dma.h
 create mode 100644 include/soc/sophgo/cv1800-sysctl.h

--
2.44.0


