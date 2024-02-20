Return-Path: <dmaengine+bounces-1057-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18B2785B928
	for <lists+dmaengine@lfdr.de>; Tue, 20 Feb 2024 11:35:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7425F1F21A45
	for <lists+dmaengine@lfdr.de>; Tue, 20 Feb 2024 10:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E336657B7;
	Tue, 20 Feb 2024 10:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="IllB0MCU"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12olkn2109.outbound.protection.outlook.com [40.92.21.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6E864CC8;
	Tue, 20 Feb 2024 10:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.21.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708425292; cv=fail; b=KwJKilX+NMYPgU5W39rrMVUocgdW4otJ/2P5lopFYhlIXhZvxPe/NODpdxgAHlSz6xO5mZBBlMzdW+TFBRpBbHdWCplSfco8JoYYmnjIMKTYOwQAJb4e7E5Im8mAeN/6YKgueHxFMRWM+1B2G/YEXlBuqYUFT8A00jCsKukmSkQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708425292; c=relaxed/simple;
	bh=CVY8xUbwpqBvGfssx+4GZTXfURJeWpRuzAbLyTeN3pE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uuSzw6PJa5C++BYzO7k5JPDGjUSjvnf9MwAhZPxY8HByNvxC9wu01rQRnO/qctnPCchc1vwgyPSFwi4K1hVvvc4rcM1d+T2p+catduLlXTbvVf3yBiRh5A94Imz5fPMYMonWhtkGm01Hsvc/iuvt23jvmM35bL0ZRvnszyqrg54=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=IllB0MCU; arc=fail smtp.client-ip=40.92.21.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UzKeG6m8Su/k8GxkKLg2Awu13XB0B0VMfMLDHr1jWK0dsf8HSFUv8m7Ieuw1CX5iMtYVej7hFQZc/LNp9QUOYzgYOnADVieNtqMXXWwM00loQ24yJhaaBNH4ME3DwYHz8igAi0RFx9QOg/XJsK90YObS0gLVZ7M23vI/yrlmcJa5R3GGcj86Ju2L63d5vKiy6+Beoh1DqpbkX51adMkusrjQbmXC9EtsZetK4F6gOzZKhMc+6Tiq8A8GNVlpCE8efl0FoU4hZvP4mnRs19tHZSP8WVOhmTIYIpCCAH2aDvtkRXtU1LII6+OEw5uIjKgA2SRQdCTwMAly88cLsLdajA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CVY8xUbwpqBvGfssx+4GZTXfURJeWpRuzAbLyTeN3pE=;
 b=Ornt+nK5pG9UJBY7/O8D2ZQsDN2WmkPwYyWeiDNx7IJGnPxGafigxRxiFhpTfbMOima7IH42KAOUgMsdu671dV1Pe9Xp0mG7R88OtHt+R/M+H8SkeuUiwSNg94x8hc8ncStgs8VQEDITDUUYktCoCLQPuh6FeNdLz9WKQuJujya/QRpO+6TW35ZAOhjdqyFCY3LyTq6fTBoHBnHUL8/GUm+E7UggIw72AWM4K8cqpLOxd/tTAd5Q7K+UoDvF9RnU8SjTzkHlwk/pGe9m91o/OZorRlJVzQTWa5a+WnjYxtrlZVak7/0LP6fzZqmud4bDe9UXACRSdMeHsemmU+/BZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CVY8xUbwpqBvGfssx+4GZTXfURJeWpRuzAbLyTeN3pE=;
 b=IllB0MCUG2Kw0e8b2SAnVB/fzN/XrnakDXNdVWXZytfYriFLCZQFuoBldJoKf9aT7oLwCWNBmskxrOndNyH6losOz0OVowGy9bMaZhL6O1ZN7NhywlVi8es8YNYUleS11O6SXQ0CUi8Drw7BK5EJnYG8s6cnTdGrh3UipPc152NW3zZWbfXp+S29/vCDFuWF8405Jo7qsSatIZ/uuPhaYBf1yN4FWOM8GX/IWd2C9RFgjPTKXYmXcaMLl94GREV9bEofxiiYy/7jJSmViGaOy5nT5TdhPG2+y1DTZCJLNCTg6gKD0C7xJmnmj38lDP6fnipA7wxa4tmrrz1XU9jUNQ==
Received: from PH7PR20MB4962.namprd20.prod.outlook.com (2603:10b6:510:1fa::6)
 by BL1PR20MB4588.namprd20.prod.outlook.com (2603:10b6:208:390::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Tue, 20 Feb
 2024 10:34:48 +0000
Received: from PH7PR20MB4962.namprd20.prod.outlook.com
 ([fe80::4719:8c68:6f:34ff]) by PH7PR20MB4962.namprd20.prod.outlook.com
 ([fe80::4719:8c68:6f:34ff%6]) with mapi id 15.20.7292.033; Tue, 20 Feb 2024
 10:34:48 +0000
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
Subject: Re: [PATCH 0/4 v2] riscv: sophgo: add dmamux support for Sophgo CV1800/SG2000 SoCs
Date: Tue, 20 Feb 2024 18:34:55 +0800
Message-ID:
 <PH7PR20MB49626325CBC141BBADCF7CD3BB502@PH7PR20MB4962.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <PH7PR20MB49624AFE44E26F26490DC827BB502@PH7PR20MB4962.namprd20.prod.outlook.com>
References: <PH7PR20MB49624AFE44E26F26490DC827BB502@PH7PR20MB4962.namprd20.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [1AmMGoGM+QQLMi2P9gMg+41imQjyqI+0ptSpV437VuE=]
X-ClientProxiedBy: TYAPR03CA0013.apcprd03.prod.outlook.com
 (2603:1096:404:14::25) To PH7PR20MB4962.namprd20.prod.outlook.com
 (2603:10b6:510:1fa::6)
X-Microsoft-Original-Message-ID:
 <20240220103456.881772-1-inochiama@outlook.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR20MB4962:EE_|BL1PR20MB4588:EE_
X-MS-Office365-Filtering-Correlation-Id: e347cfe9-6482-465e-e408-08dc31ff8ffe
X-MS-Exchange-SLBlob-MailProps:
	q6Zzr5Fg03EOMvE42zEF4MG1gCVyCDvWWHkgKhHD35P08kxcf7zgFVssG4b+e7GFi+p3OK5+XCV6soVF5ZZHWrg50gsRhLQMhob64H4Tlo7UVzuF11ajPaxSh0h3A9EMwLKR4RHV5v+1Dn/ZH8YSoaj8yOQQnmXn4WQ0Mvcsb49bDOdAq4wiU06Vy6WPNSgWrPsST2lRE19N/pWGDd8nrlx6fimMmO49rWdLIA/LBMp0mZhsFPQJkaKbdCRQcYyInUtIMD7oizJu3bDlIWTgvVA+HAD2hQn+mn7LNx/SPzGk1NNZTEDkY67QqVvtt7rAdyDdo0Tz+OKR71M2h3MCdT8Tu5QGSk/aT9DAMxZFzlGQB/BowOdbbYfB/vvaDlyzynthuyf9tX8vAh4IpILxXXA6g6zoGShdoDmnHoXr930UNM71eldiAWi7ulXcktumAS5sz4j/NAdabk5nyHG8ysAlJbUJYwGwDqlzcTDW12Yr37NlBVx9NihRm97/+vTCqD3U2Y0Jy7HSZMl3sFhNGv3zaoYgEWlKhrdMQoOYgrGpxoO9QjRSFHUj6SYXIgYpExAO2S3HkjcpKEpagzZSCljyFYUeMC8C7tqhuap4xY9BYpCNiz0ohuD/xwAX69FtWyMZXi23vVu9jaRy6ahOkUG92YwW3TmwCDmh8d0NNIfgBFeVFTGf3p2eufnF7pHy
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	tJCdBLcUJPcajGjuVHZAECO57XzXI5YOnffHPLg4EUt/GbeAPJVqPE+YCSf4+RZQ2KZH/UK0AHwphRtkRbgOfG931eSl2QdOgL4fbji/HLO4AlcIFZsf0+L0XHAj8q5UqrYG1WGD/C86m+yn+8IzhJFb/RndRty+I9v06ArQkI0GTVGDE0bSFaab0qBaOC0+T7NL7ExNSasdQ1vTIzpG30AbwhAX0nrS3pNWHYwyeSfRJP16mODfYVj2qwN/YsnZFUrfg7Q6Ubf5Xip2YLwXrGESKgeki2sOI9z6KorvS0Ds6sh7FOugyiYI7Sh6cF7kIcJ9PxWURjRjZAgdQqamkB2sFcDsML85G2aGtrYlabRyqyd6ZDPzHG5Jk3GfkjC+3qjFKMkMNUc8EDqpfvdFbOVzfvsrMTA2LVtopjcZT4z7gwlS0+pnym3x7LL9dwdEps1LafIcdhTNuBxMgilkYnYWkUCpxx3Fl7Xo9lzlcoQh/YYfMJ5CAoRQVOGyOTDQfXdI6vJ5LNe/yFnAzd9sm97uL2Nl9iU+TN0AOq/5Vd1XXDNgxmO0moOwSWBjosx+d57YqLXSLWJGu0V8nAVnMVDpIvSOiVr5yt3qG6lu09e3GkPDpTNkcWoQkavSNygE
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QXabtRZBq9dz8zmageMRDiwAw/zew4iyLq+XYrvnC32SkKr67VhSPzazcIsv?=
 =?us-ascii?Q?ONmHByoxIOm7l3M5EdFrDOg80UUDDCJHgIosTrxyVyGckmUIVy0etD/YBdr1?=
 =?us-ascii?Q?ubIsia1fQYq7rNQym/L4ARAHxLfXAbT7haIew6u2CbeiaKANf1PFXrgUPLOC?=
 =?us-ascii?Q?sCKM6/nUrAkhVzEUpYmv0n7M1ly6IaNN0dHJPoI96pNJB+Pv9aDuvHJOeBDT?=
 =?us-ascii?Q?ixRjfDsuSF8PQmz1OcDwXC9rQrE3AXKvgM6+uPNFw3eWt9t3nnCOVdV4vC3/?=
 =?us-ascii?Q?rGH6JI7Qmqvc6eJNBZadSWpuXF/prsuvXeCiYTKBpYqcHgAxz5B+7hbRtX9J?=
 =?us-ascii?Q?7xAadtoE3qJ0VEDRo8DXGhIEouqnADIOFVu+mbadR/Gk3pJwuKNDlw5KPI2B?=
 =?us-ascii?Q?HLAw3IsbSj6hFVq73vsHvdu0tZLnAz+4rRMZ/XtUcwhOTHC1iQ2t1Zl5AP2h?=
 =?us-ascii?Q?qELFIkvaFE+vioy9DlliKuD3eNBzgA3wFHKJ6nh8kFjTnvKdQOLql/cTFS71?=
 =?us-ascii?Q?E697C6ACxRBJtsgYQAg5opFImASXWk854YOI6AI2rDwN1+6/1d/ydXWNSaGq?=
 =?us-ascii?Q?77V1v7N2vAJ7LiTzQ/CKhuHkHBNyVLFwqxox29DsYo+B8h27Wtx6spQSZN4m?=
 =?us-ascii?Q?+kUz4NyDTC8xC6lnKSS1V9TOHXJM63Th0/92duP41pehryldvL3ZJNW7phVM?=
 =?us-ascii?Q?KrU2686oZFMysqNXhq1JKbiSq0kJScgxv3FPtlNv9ITxbFeViLv9PdeS0Ukm?=
 =?us-ascii?Q?6Cdk3TFpkF1FCUyoPdrZ5F7aLDxfp0Q3yVdtzzT8IxzJfOA0F7HAhOLoRCY5?=
 =?us-ascii?Q?JVXdI9GUv7oZgVzQFfBuJX+5CsXbJE2OwYeIwoPgau1AZnX6D+Bmia+M9/mW?=
 =?us-ascii?Q?TFL3fTZdnRvxCii+OAZCBCFNRqFndulXbT6/vMfYkezq12wMfIrXFEfLXvSr?=
 =?us-ascii?Q?7siGNKG3m18pqFsdqYbYjVNMWlnPlY/FL2+hN0Guie2+bl5DkU4W6xeqY9QL?=
 =?us-ascii?Q?tWkYsCo6P7VL6TEIrJSPD5jJXZOmLxqdq2t16d/SMNOraKPZ3Nvrfj/W/xCi?=
 =?us-ascii?Q?hk8vbHlC1r7WvOZkk+uxf3smaZLncum88Oamd/QBymVPcy8kGhEmtKxLv/Gw?=
 =?us-ascii?Q?TpbM/Tu2pK4VbN7xs7vqQ2SX37Oskl9NOCeAYKWMcvrR4TmPat5dEW8x+RZV?=
 =?us-ascii?Q?h99g0MQa1tjU+iTt+gR1SX/4P4F5S5kx/TzSR9fJy9d8YREGAB2KbfO0QTQt?=
 =?us-ascii?Q?rXuGKtmdr21K6Q60566T?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e347cfe9-6482-465e-e408-08dc31ff8ffe
X-MS-Exchange-CrossTenant-AuthSource: PH7PR20MB4962.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 10:34:48.4034
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR20MB4588

This should be the v2 version, the cover have a wrong number.

Please ignore the wrong changelog. It is "changed from v1".

