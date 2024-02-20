Return-Path: <dmaengine+bounces-1056-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FEFF85B91E
	for <lists+dmaengine@lfdr.de>; Tue, 20 Feb 2024 11:32:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4B171F2492C
	for <lists+dmaengine@lfdr.de>; Tue, 20 Feb 2024 10:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22E8320335;
	Tue, 20 Feb 2024 10:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="me1ZzHy8"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10olkn2095.outbound.protection.outlook.com [40.92.40.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E893612D6;
	Tue, 20 Feb 2024 10:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.40.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708425144; cv=fail; b=XZUkMUbv8AgVEmcbKdBG57mZSErkZci3YOqN5dEVoJNho3LB0HdBYh6/SuSM8zfHV0ozef8iwZQ0A0IyL1PMcckGs12xVM0bB1WbhbIpDKM4anFOjFLMh6TWZ2cJHvkqFMyYXLwfAN+R2EHZFUuMwg9iOGrce+eHwXnVJkAsxhs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708425144; c=relaxed/simple;
	bh=OK8MmAOIJqglFDP7C1gBVQWNBBbNoZIpUEohoIQZ6eQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nkQS0d0Dc3rUJfWqaGNEH2WJ8q6qBaZpBcCGnzvIx5mXAtsCNcl42VMeIWYu2OxBki4hVofLPlfLzgw6HN4PB27H2U5SYZ3dFK69853J3DX4MafWHZbrTwvi3AK2ly/8PmNfTzonv0eSNsGX6JaHRBxZjHW30Trkahcb4CfMf2U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=me1ZzHy8; arc=fail smtp.client-ip=40.92.40.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kv/s4VavxEDnpBNGUlOAOW0JV8LtSGzFaaE7n+UGoKuWPYz4lsIy/c9GB6gM0lRmsQpER37R7B7VwY0FdY33jT867TKcZHx0s8gd8vzgyRFrIGhVplRlyZI5qB3jEtpn89YwKSegntIgtzrUMmbdA5mp5iYpp+UpCE9lQRWZckrAyCYYuRCItHSoYAZIBk0NcmjPEqimAs0myRdzE7jtgVtY9Uw0awKXezwjjL59cgdLV0gwZnVVFQUy9iECtDIbO8wy9hRaUjHxZkebVG+6WnQ+sv9TbgNGjr9UpYuuhEqZx5u7d0KH8uJ3SAspugDHTGA1Xii1YcVQhGYwMSNytQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OK8MmAOIJqglFDP7C1gBVQWNBBbNoZIpUEohoIQZ6eQ=;
 b=QOD+4fUheptuE4mezXINorVft9EjleFUr+PDMwY4G8/ki6gdgIg9GtkNRS8ZEhdfKmqro59+m1ggn2UhXHuYmoJbZit+ZJ8EL+sATP0J0I52CxIVXisl3rSQgT9Gt+5RSiSsRml8jBcIP6pcx1Ds9kEHpc1hX6R2O5kqHQhI4eaZ3DgJhMS707u3WrCVxR+5hBigOHTE86W+2C8UHhrcpHvJuy6Cc6DOQlEWdwSifbXtGMh1wtz+RNFAIYOqGR4z4SAQim1As0bjz4zKkF199/K97eAZceWo0YKFm0T7cexe5Cn7OxB4g9hOb9Wnk4XVWOvdirKaJCRKuREqVtW82A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OK8MmAOIJqglFDP7C1gBVQWNBBbNoZIpUEohoIQZ6eQ=;
 b=me1ZzHy8vHsF4whtqS9GtzLVimdfxE26QNs+PYqMzB8cpXUnCSSQ5CCIKI0EPJPZvV9ZaulD3aEeqQI+r/GnjG+8BEd7IOV7nUibg91fbtGqQaXgm6f3/iwZfDKmaUylIUubKuP2goY3fIXsec5mE6RYeIi/R4KA5pcrKQD7EgVq4eTY6bI2VzSOOQUKeh6toxBvaghRWpCojCg75bURB3x1cHbawN+rXgoAH22RNtAwfycFZQ+gVoMiEHZlYUmJYfF0/LfW7uvDwglrj1UiG5v2qlQOniq5/mVZMwiSEYME3EAypdshu1x94y3/csLCZB4mPNzmQzNwXL/mVccRuA==
Received: from PH7PR20MB4962.namprd20.prod.outlook.com (2603:10b6:510:1fa::6)
 by BL1PR20MB4588.namprd20.prod.outlook.com (2603:10b6:208:390::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Tue, 20 Feb
 2024 10:32:19 +0000
Received: from PH7PR20MB4962.namprd20.prod.outlook.com
 ([fe80::4719:8c68:6f:34ff]) by PH7PR20MB4962.namprd20.prod.outlook.com
 ([fe80::4719:8c68:6f:34ff%6]) with mapi id 15.20.7292.033; Tue, 20 Feb 2024
 10:32:19 +0000
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
Date: Tue, 20 Feb 2024 18:32:16 +0800
Message-ID:
 <PH7PR20MB4962F2D436786CAA7C63414DBB502@PH7PR20MB4962.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <PH7PR20MB49624130A5D0B71599D76358BB502@PH7PR20MB4962.namprd20.prod.outlook.com>
References: <PH7PR20MB49624130A5D0B71599D76358BB502@PH7PR20MB4962.namprd20.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [HFtQJBlvR8l34p1PlI4KJkdQwun/OcUNhKJC3U07O/c=]
X-ClientProxiedBy: SI1PR02CA0042.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::17) To PH7PR20MB4962.namprd20.prod.outlook.com
 (2603:10b6:510:1fa::6)
X-Microsoft-Original-Message-ID:
 <20240220103223.878337-1-inochiama@outlook.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR20MB4962:EE_|BL1PR20MB4588:EE_
X-MS-Office365-Filtering-Correlation-Id: ec79c94d-a6cc-43d6-b928-08dc31ff374c
X-MS-Exchange-SLBlob-MailProps:
	9IecXKUgicA5uJUIDiKdNQ9oDDb5HLJA9te5yK/eiqx2PLFhc3RKJ3CI7rrTWwnlEM1NnnTLME1sFC/n8hxPwzOIfJF7rMbZbXlQb9BTDPdGpRV6opqQ/X1RvFQiVmw6sU9aVP7+VXAJ39B2oaQ96XT9soEkuyIKy5LbsDbCj7JtRe0p31kqAEr9yAExxgMspu856uSWUaZwacF20MyLTwf7NGzQ7RUrvnOOXmqXhnuw8AZliOMAhVyjVvSFrgnRI3kDQN8baANaklpPONpPBYkI91BH2Bkp+Tmp70H3yQzJj2+vZzhC5CosMkVtbp1CArgKvRz+4eijInnqarfoNDPHtLUvcpoCGAntWbTg1BBInYnUbgRjQqjN49ClqCx1X33jqIM1IGMUJQ29YFDwIo8btEd9z6QuLYUddwlgPtIxDAXKnjzrFFPuab/+jTaM/srbDC1qTxn7WBpes2X2scof8WvE+75gXocxlFX1oKyDHf5ZHEIUJyk2hAQ0dm8IrVqru1Cm0Hm6UWi+7HmBJPMM0ZMk7Dm6Q7Ao+XErLue6SugPgcfeUKMRHlUGAdisK3pAgmSpjyTa65/CGoKghwnB3Lrh4EOD1bWELhqcimL4EJS6PMBU0KJYnHTZX/m3iyw25Qmv1dGMeU2IOD0fLSgoyrG7sfTOSicTJnPGMCGOX7wtIAUULMZWpHEVTXjH375Wu/xADNmkqURnSWEL0h+CPCDhBx5fIc4WBnmfxR1rPaVTfcGxmA==
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8MIgZ2F1EZo/Vutq/YPaiTDSXrEgqLihAFqMKPwf0czoVZEDEFXV07Bs/eL5TTL54OpuFFCx9z+cX4wL4by8s9Ta+g3coNZK5XYRjbt36+0RHMTDXQzvCUJTQ5TYNCG//uNP7lq+oevoWOHX+L43EVrDRgU+xKJuwCfUQ0tM3z1P72M394E4wZf6XfdRCZVx5hqztEx6HDsJjIWsQ5+IYMrDkrvVqXh27A12geaBWrzS5xn9KKBsQDTn4Np/7DiCRUO1kxAHOBTVJJCZBcYXkUNXKsn/eH55Yyr4xqiMxOrUhtxLVbMYnX3isIyI/UQ899lXd+z5h32bkPoRCw+iVs5DxWJ06qpVBAolOFNSKg17GxfnK2c+2F/fVwwCC1BS2sqyBs8tQi4qTmzymAwxiJZG2FIMU8FZdaDrLDqWB7I2SBkiOIYBjJYkvMesEE6jCb3jmdt9y/95bIvINbU+wq3snqaj5LF/wta1SE1TppVG5MMWyOs1keRCkd3n8SAnUPoE5cEL5h4EaK3XoP/vlyFWdJyYlRuIRkmxLFgnbbEYN2bhvJMEyYJrWkqiP+6q3XiBwpuAApwmgiMLRXmeSrvpoEp4PhJdmneWf1C2ix4VXWItUHV/O12TLtMJQgMgR3yhOZtggpyZwNhzaeBN2Q==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3AbcZLEsc+pAZZwai4LP8ajNpD59PqpoZJuC0RqvesZMg7pL0IHSsSYTImbC?=
 =?us-ascii?Q?A/PNhKQZSRaYGmcCGzgHywhSyUBq+53Smb0RabLhuSeXeSqejydXTeqEYvuH?=
 =?us-ascii?Q?W2trng1MvnWf4WZhJOG8RrF9C9u445An5ND/3YVVxV8pH6RjZvCd4z/5FcZy?=
 =?us-ascii?Q?L2OB41V5ie/SKLMPSvIea1fa4e9hyT2unO1gJcjGn5SeBRHT3xB8qv6+O1/+?=
 =?us-ascii?Q?pWUC6ox6xoWBBkIQswtHZVSp+Tc0Z9N6XpPIBEv+D89D0tA/gR+4w11XMzpk?=
 =?us-ascii?Q?qbSYPtFaxdh98IK13sc2AXbRjApddCCbqxO/ftmdC6jVfhGEUUo89VNf8AVf?=
 =?us-ascii?Q?ZgQ9m1iG/isozktn4KN0vIJRmKQ7LqfDifTg+edxl+Vf1Ne6am7moYP2u0Fi?=
 =?us-ascii?Q?bgHkWKMRflWbqGK2YG9e2vgkqXvFJ93QKmS04axL4flVQIrw59jZK3SwBK1B?=
 =?us-ascii?Q?1TqHVm/rOXogQqoTlS0r/Z7iHNQUUYCm8PCfCBGh+hhFAgwPp9jJ5QR+d+6E?=
 =?us-ascii?Q?+2XSzAZEZIF+Jzz66Lq6k6Tfq8a1yfy4y5VyQ2z9lBT6xaOOlI0dMMP8Dc4y?=
 =?us-ascii?Q?UlUzCgUKfem6fZ5FzOfc56sS+58xb5PWP1uPKnaqGNh3FNW2Qi1LXiu2dI2J?=
 =?us-ascii?Q?j8pVrGG1xcTVkiZydjfuEhYSs2FjjA3SAXo4+vJmI4gnDFRij3UYGu1jJfrk?=
 =?us-ascii?Q?+HCBXvCB4vcNJLR6ZqBO/G8GCkykjCJVNTJVg3OB6qDuJp3qy8Odjv4L1AhG?=
 =?us-ascii?Q?H/BLVR0TLp8SXE6qwzmGP94U1QgFxEy6nr1WFb9JLI7uCH5k3hdSe4ncObr+?=
 =?us-ascii?Q?YYr39M55v9HQISasBv9edSYoP5AvbSK+r+r3C66C18zvKO5ulKqO60/v7s2K?=
 =?us-ascii?Q?fFZB15hNGRmXrE2KnvGzPSbhI0atOgDjXsH2CyICU6fr1egDTXKf98P6JvQi?=
 =?us-ascii?Q?xBN1x2xk6r9AUZJ6DsT7+l8OBdUm9phNNfkxF9vQSN5SUVqrkdTlGnOkZAH8?=
 =?us-ascii?Q?92AMiUvmSHaiKUpnMKcjZKEnr9AaRK5qwbH64TJC0y81z4s9llSDC5MT+kcw?=
 =?us-ascii?Q?WPqK07IQcbStXBcE5on2rCmjG2mt028M+CYFiX824YynvEfxlisFY2hVVXEA?=
 =?us-ascii?Q?nW2bEfWa6oj1EXi3UVm+XrrVuKPmVSX+GfR1BRF1xpUm5lpBG7/HXxKCc0Py?=
 =?us-ascii?Q?A+pXEj783egW5Gr6LjamXen+mblzBBFUtPqvp0fEdATyUnnP5M0A5agGbK42?=
 =?us-ascii?Q?iAIIjj4hNSK43wHK4iZr?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec79c94d-a6cc-43d6-b928-08dc31ff374c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR20MB4962.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 10:32:19.5893
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR20MB4588

Please see the https://lore.kernel.org/linux-kernel/PH7PR20MB49624AFE44E26F26490DC827BB502@PH7PR20MB4962.namprd20.prod.outlook.com/T/#t
The version includes a wrong patch.

