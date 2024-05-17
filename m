Return-Path: <dmaengine+bounces-2061-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B27C8C8C1F
	for <lists+dmaengine@lfdr.de>; Fri, 17 May 2024 20:11:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DBE6283C2C
	for <lists+dmaengine@lfdr.de>; Fri, 17 May 2024 18:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D91813E89C;
	Fri, 17 May 2024 18:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="IV5ZbHFg"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2061.outbound.protection.outlook.com [40.107.20.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43FCD13E03C;
	Fri, 17 May 2024 18:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715969440; cv=fail; b=hCHEEGN6nLSBOIMTYCiYG5K9PDhMqw9SY6kK+C9ozpxPiCYiuRhS8W1H0/YnxEr5Z5EWAZSkm+UlWLCeRd23e4SXxT/KkI/W1jDz8uFwPy0DU7zdQSFIwBOguaM2djr0UBr+aEH8qMvO7Qn5WIJ2qb7bnYcAl93Nq8vrCWgUg1w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715969440; c=relaxed/simple;
	bh=mS55mB0B81i2jzK8aFUR+tBesadsu4zXCQs8Ez1y5Uc=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=nv1BHpBVFe7GBDAuQllm0kVTiHJJYNlDC+rQymgGuI+16jQxdh3on0mCu0HKR2RKYhZIFIRL6CvEnlP3qEeFcN1AKrQEGR22oAsfd8j+v0Ov5PxeNiR1HaEbXdVl2UQHOd+Y9hwap6iftjBaHDxfRAQFh636VoMwJMYJKo+6t/Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=IV5ZbHFg; arc=fail smtp.client-ip=40.107.20.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mUQwLQL+BitKkw1BBiT82uucblRz/simhhVilBCEAasLLbmM/WSgcGmRAsMHyiiZxTBPpeQvZIt+H0m9IvOCSJC99MUmupfRqtPkCviUD6tuWRpmXizeKRWOAdOm1iRveXyypfj5l6bCqpho8dG+YmEehUNgEZcPhUzyCvTAV3srFtahGmQi8JcQA/BYkfkye8b1YjqwPOmRjRwKBSNWRI0ZAeZOwRID0Kms8q/aN/9ZCRmiE4Rw35w+CPBmo7taXFt2fwdFErd7SookHPRl5LRytlimbnoNUvrADeZHG2yp7gpuvAf3rtgfNImy/mHxRaUSGTDHC5LWUJS7AOJDDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l4quWV2qkIm5xWoBSTGQnQ1nY52gQwn77fcAR/3/rUM=;
 b=fbX3gT71Zh4Yn6Prlz2/MZBWoyldRt+jFJFJ5Vxq/TLoxqH+53JjjxJffOrQEosVxxAgwXcnUMgJEwrxyoZiwI+MbESkh8hqh+83WlijUwuY75Zgz7BH4ixHa18bfz0bQqWc1g735bZM0RhIO613XeNxZJqKEkDyV693zS234rVhWZlf7ulOiTln/iyldYsKvwRx0D4dRTNR5aCYUvXS9dgjltFymGb2aZCjQJm2BMN0VWty8m7wQ+Y5wBEoToACV5XczoFFMawMOTZcS8zEqAK1wmoHJqYYlHtYUrhNBZ8PcZuQTu/o0Ej36nMR+sY8s27iTWSNv7QC6Kkz3WvGmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l4quWV2qkIm5xWoBSTGQnQ1nY52gQwn77fcAR/3/rUM=;
 b=IV5ZbHFgDHSituuWhEbrig6CHeQdB+JNDYjyhmM154pzII6ygS6WPCbjNtAcTYqwQY2lmPQVuPl1V8tNX41vKTYLfswR0a1Z6vodwV6hJPMLb03uUisLCUGSVVyB3lVO0DJktygdRd5T09nmt+BCcEMCpnt/9OOkXbl5kCNduIg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB8955.eurprd04.prod.outlook.com (2603:10a6:20b:40a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.28; Fri, 17 May
 2024 18:10:35 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7587.026; Fri, 17 May 2024
 18:10:35 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Fri, 17 May 2024 14:09:50 -0400
Subject: [PATCH 3/5] mtd: rawnand: gpmi: add iMX8QXP support.
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240517-gpmi_nand-v1-3-73bb8d2cd441@nxp.com>
References: <20240517-gpmi_nand-v1-0-73bb8d2cd441@nxp.com>
In-Reply-To: <20240517-gpmi_nand-v1-0-73bb8d2cd441@nxp.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Han Xu <han.xu@nxp.com>, 
 Vinod Koul <vkoul@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Marek Vasut <marex@denx.de>
Cc: linux-mtd@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715969417; l=3753;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=CT8TVOogkiD1sCNEuMtwYfAYmoevJdAWdpfcK3/H/Go=;
 b=0ySFvdr7+0aWxJEZ8rt/BXV/2UsIkccjO7gGQYlX6wnGAI/cAu2n7sJLRvpDKSkzTx1n5PrPc
 1iqLQON1vZLA1K1Qw6bHM2vFRzGXJ/E0+kJGB/TqwQml7VpCU7pdWp9
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR07CA0068.namprd07.prod.outlook.com
 (2603:10b6:a03:60::45) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM9PR04MB8955:EE_
X-MS-Office365-Filtering-Correlation-Id: c57aea81-fcfe-4282-aa6d-08dc769ca5f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|7416005|376005|52116005|1800799015|366007|38350700005|921011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dFY3S0N5SzhhamlDeEw4OEJMdHFqdVpNNmZMK1FNNnZoVDZMeWpWN0dUNGlp?=
 =?utf-8?B?Z2NRaWxQNlR6TWpmbkFmK21EVy9lQmM0SDh2VmMwUU9rNnFUTTVNcGlzUDI3?=
 =?utf-8?B?cVFBaEw3cTF5SFdXRW1rUEZsYUlORU4vWElaMGtTR0d5ZnVFSThYWXV6cS9S?=
 =?utf-8?B?TlFLNThyRm4xOXNZODBadm9mSGhvRTVkZWZUeElhTE04UmhuSVpaUUJiRGZ5?=
 =?utf-8?B?YzEwd3diQnNsZHgxbE42Z05lM1g1a01DblhTWWlDMXdZKzhhMS9QN3NYUFpB?=
 =?utf-8?B?dXFhRmxPbG5iRzRaMXFRL0ptMDJScStYNlZNbjlnbFprWGs2aEV4N1B0Uy9X?=
 =?utf-8?B?QlQwWnFRQUY1TkhBR2dhaHdOZzc5MEczWFdVRithcjYxbUM0NndqeGFySCtx?=
 =?utf-8?B?RTE2Z0RIcGJBVllLakRmaFJVVHlESVI1WGdiT0xEdnNUcmFjZEpYUFd1Y2dl?=
 =?utf-8?B?M3hVUTE2RGJIZm84Uml1SVRlMHNlTDlIdXlBTi9KYzhpZm5TdVRBRXRPTjZs?=
 =?utf-8?B?QlA0SzcvL0xGY3ZMRjRsaEgxWExVN2JoZ2RvL2hQb2h0cDZYYXZsT3hzQ1Ar?=
 =?utf-8?B?SkQzUWUzdDhoK3hxbmtOdmsxZmhNOGdLRGJ1eWh3RGlha1hzQ24wK0t0WjF1?=
 =?utf-8?B?UVU3MnZhSVNaVW9EYmQrOWV0MERmUG1jK2xBWTloTW4xa1djeThuTThXTlE5?=
 =?utf-8?B?OXN0bmZoTDhFMUpKNkp6bFZQUlZiaWMzTFJDSnowaitraitBZUFFQmJZaWxE?=
 =?utf-8?B?WFUzUUxCV2F2RnlKVmFtUFRhc0Irdi9nYnZ3UmxHL1o5aHlxbXp6ZmlsSHBo?=
 =?utf-8?B?eUNrNjZlZGUxQ3o1bEhRdHordmI0eTRrNjhBVHIxVzJqUW1MYXFlR2hLdmNX?=
 =?utf-8?B?UTJzYlh6RjhETHJ6d1Zzd1h2M2ZCWmxwbmlmT1ZxNzdHTDcrZk95eVJMQkxy?=
 =?utf-8?B?UnRWWkZwdHRXYXJtckxoTnRKZWwzQXNOVlY2REttSHc0Y0F0ZlpLL1Zrc2gz?=
 =?utf-8?B?RHdxU0ZXTHliTmJZQVZoUVp5VlJzN2ZwVEdSWjVHcVlSUmduZVFkamJFUUZk?=
 =?utf-8?B?anZrWHhkSURLUzVOK2xJdmNuVVVvYU9ESFJGdGpYcEtPaG52cFgwaFVYUjdT?=
 =?utf-8?B?bEthVzl5YStlUHN3WndoTGtyZFFVTndzTHAwS0Q2MjBIZFVyZ2NUTnY5dWRk?=
 =?utf-8?B?RXR6S2xCMFhJcTB4NmlvV3d6R1pMYnpoS2lhaU43MkhQWXZTTUR1QTVmeU1B?=
 =?utf-8?B?bzgzZ3Fyb0NYcmd5bEFLVmh2UFdGdWh0RnJIeCs2N0xRb04xQnZteE1odFJE?=
 =?utf-8?B?UjByZDZjNFkyTUJHTXNCQ0gxNk1tVndKOGFQRUhocjhKZFpMU1l1SXJaT1R3?=
 =?utf-8?B?cGFtVThJUC80K0hJZVdHSGxCMWp1NkswS2VNeHY3d3lvU1ozN05qU3JCaGtq?=
 =?utf-8?B?djVmN29VdFJkRFVTZGJNY1VkOGtIcDJjdW1QV2FQYncrYXk0cDNpWXp6YjNr?=
 =?utf-8?B?R1A4ZnRTNzZlUkVxYW5hWXJzajdmd0xqbU5SWjZkQU95MldxTDB1TnpMZHhL?=
 =?utf-8?B?cDhOVEpHekVQU1ljWFRCUVJ4RGE2OWlnc2RMcjRjYVJiMVJOeUdMVGpkT3Ja?=
 =?utf-8?B?dCtLVThkRkJxVGNmSmYwQXlwMTl1dW50Ulp2dE9nanh0cG5ZL2pTVjcvOTl2?=
 =?utf-8?B?RktpSkd5Znh6aW5ERUdpcVBaTVJ4TC8vcTdiSGpuSm5VZmJWclY5d1gybndC?=
 =?utf-8?B?cW9WN0JEVU5OajhUU3BYVXhWS2JZZEFWeHBCZjFVNUNGcWloNW1XWnh0RjQ0?=
 =?utf-8?Q?VlEuG96hWPCDnj/WiDhxX4CYX7aCe9GNcuVKc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(52116005)(1800799015)(366007)(38350700005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z1l1RUdTaU9QcWgrRUhsUS85c0VCV2JSQUZ2SUJXbUhLWUNrdWo1MzRDMU5k?=
 =?utf-8?B?aWJLM0NlKzhua2ZwTVFwclJqaklzMjRnUHY0aW1oMllxekIzQlJFVUlvUTht?=
 =?utf-8?B?ZkJrQ3luTW95dDdmdkZwTkpYVEcvNWtIN0syYkhUNmNXQXdlSXNFN05WNXlO?=
 =?utf-8?B?SEo1T0RWWm5CNEo1WGgwYlNuVUJteGtBTC9MZGQyTHh6VEkxckh4STNac1Rz?=
 =?utf-8?B?a1RtVGt4UmpXbWZoK1V0MEtEM0xRMzhERmJFQVpZTEZIYnFSSFg1RlFGSUVi?=
 =?utf-8?B?dUFVNGNhSXB2cDl0SVNqMk5CWWhzNm5wUGpxbEtlRzRXR2Nld3RnamNPODFK?=
 =?utf-8?B?dWdnSmd4SnBqa0JnZkt3TCt2VjI0TzNzRjJxOXRtUFZ2VFA5cEFVWnpkaFFR?=
 =?utf-8?B?WGtoQmwvWlVEZ0czRUhma1M1YnNWazlDeEtCNktoYWdKdW5WbFlIR1dpOHZL?=
 =?utf-8?B?OWVNWEcwVDFxeEJpZWtnNHRCZ3FPWnRKYTRuNnppS2dRbkNOOW1lTlN2NkxC?=
 =?utf-8?B?Q0s5ZU9laWZ3WTltUWFGSDhzM1FMRE1MNHVFaXllcW9TRm8yUGp2cjB2MkhZ?=
 =?utf-8?B?cFhBeWpmeFZCWEVlMVBIQ1k4cURIM2loak1nZVRlRWk0YldvZG5hdG1zTm1t?=
 =?utf-8?B?bHRUSjBEUlo1UGVMYlhKcXhqdHZ2UXhKYnhNY0ZLdzhrcDAyYTR4UlYwY0F0?=
 =?utf-8?B?bzhFYmUwd0c2R2lnSHF4K0FvdExnaXFqejJOc3dyTGpiMHhSSEg4bFlKNDd1?=
 =?utf-8?B?UzltR2prOHVKbzBzcVB0eEdYQWFVWTdLZ2xHcGlLRHhGYnhZbUtodTJPY2JF?=
 =?utf-8?B?U250aHl5cHJKVkNqQmlxQU0vYmtQbGNqK3F5RGRGRXJablZYMDcyY25TWXFZ?=
 =?utf-8?B?NUVyQVQ2YWZZb3dHQlN0N2J6RTFncER6bzgxaERNdTQyL1FXWjFicjNOamV5?=
 =?utf-8?B?UE42cWNkTk1rWTJDRWI1dithV05VdVoxZnV4bmlvVzVHMXlnT2N4SFE1aitY?=
 =?utf-8?B?dmJvdE5VZW5MN00wODhoM0drRGdwdFZQSG8zbGI1b3FKZW1MNWhFZ3JwSEVa?=
 =?utf-8?B?clJyTnBTQnV1YW13dnhyWVlWR0Q3UTJzdHI1RS8zVDBYNmc4RzB5SGpGRnhw?=
 =?utf-8?B?ZGJUNGtMK1ZCalpOSE5mTVZFMXhwTHprNkorSU5HZFl3ZjJPSDVZbE51UlZH?=
 =?utf-8?B?Vk5xT0lEWll0N2d3YzFiUm0zRGl1dmhxSkJ2SmZOclVuY28yL2JXTE4zMmd6?=
 =?utf-8?B?cGp1aDRLbGN6UlNNaW5zS096VS9LVjViK1RkOExHeURybXU2Yld2aXBpVXdV?=
 =?utf-8?B?S3k2ZVNJcjdwQTZScWtyQjJBbitjR1dFNVlYS0I3OXI2MnN2OFdNK0ZMREZv?=
 =?utf-8?B?QnN2dTJEVFR4QVVGYmpsTHh0eGVxeHJ0d3Y3YkVuMnNwNmg2WStUMW5SN29R?=
 =?utf-8?B?Q0R6QVpDOVMzVHJjRjhQRU8zVWJ3Y2xzQjlIOFNwblZhRlMzL2VycDBubTMw?=
 =?utf-8?B?bEJxVTBDV2pyL2FOR1QxYXdaZytVM3hHd3lMbGt0dEZWVUdIeHl0dm4xS3F4?=
 =?utf-8?B?L2piRDFPUmVGQ1d3UmVXeGRxazhneUJHWjQrVmRoVjVyS05tbnkxUXJjVkt2?=
 =?utf-8?B?Y1dJU3NBbmJ5dXJ3aXo5SUFUMFRTa1hKb20vNGRhL21CYlZKK3FYZUozN29F?=
 =?utf-8?B?V0l1bTAzZU9vVW9GV3U2QytQL2JvU1RuaUtkcWtPK3lmckpFcnJmV2NOYzEy?=
 =?utf-8?B?UkFGYTg3VGd1azcxTDZOUG01OHM0Vk80NDZJRndGRERkOWd6QzhMSktNNmdq?=
 =?utf-8?B?KzFYK3FaNG1yK2tTRFd3YUJuYzh2VFNyUTk4a1F5MHNjdjU3UlEzMk5tczJP?=
 =?utf-8?B?aG13czZRbkRMYzhzbjBnbm9CSE4yU0g5dys2dG41Rms3bWFrTHorb3JodTh3?=
 =?utf-8?B?TUdOT3lUZjZJdlZycThQOWt5eTMyd3ZRaWdRVE94L3V6ajRlZ0ZhTHNsK1pr?=
 =?utf-8?B?MzQ5N0c4Z2o3dU01MWFuTUxVc0JEUWt4a1o2Uy9ZSFJoNGhpank5ekNFTmJY?=
 =?utf-8?B?UExYQm9iQXdRdmtjNVZWdzlwaHZIVDlhVml4a3FtUXEvWnhzUXFzdU53cVJ4?=
 =?utf-8?Q?tntltz44QdLNKn6Et7dm1Z4ok?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c57aea81-fcfe-4282-aa6d-08dc769ca5f7
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2024 18:10:35.2184
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j+hpbiHWBVMw9wdJu5cFAEZvPIu2f4mxBGQy0LJodcyLAUPlrGMnbcNBW7OUycUHHg8NBvtXWp56HXfiwCrVdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8955

From: Han Xu <han.xu@nxp.com>

Add "fsl,imx8qxp-gpmi-nand" compatible string. iMX8QXP gpmi nand is similar
with iMX7D. But it using 4 clock: "gpmi_io", "gpmi_apb", "gpmi_bch" and
"gpmi_bch_apb".

Signed-off-by: Han Xu <han.xu@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c | 20 +++++++++++++++++---
 drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.h |  4 ++++
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c b/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
index e71ad2fcec232..f90c5207bacb6 100644
--- a/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
+++ b/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
@@ -983,7 +983,8 @@ static int gpmi_setup_interface(struct nand_chip *chip, int chipnr,
 		return PTR_ERR(sdr);
 
 	/* Only MX28/MX6 GPMI controller can reach EDO timings */
-	if (sdr->tRC_min <= 25000 && !GPMI_IS_MX28(this) && !GPMI_IS_MX6(this))
+	if (sdr->tRC_min <= 25000 && !GPMI_IS_MX28(this) &&
+	    !(GPMI_IS_MX6(this) || GPMI_IS_MX8(this)))
 		return -ENOTSUPP;
 
 	/* Stop here if this call was just a check */
@@ -1178,6 +1179,18 @@ static const struct gpmi_devdata gpmi_devdata_imx7d = {
 	.clks_count = ARRAY_SIZE(gpmi_clks_for_mx7d),
 };
 
+static const char *gpmi_clks_for_mx8qxp[GPMI_CLK_MAX] = {
+	"gpmi_io", "gpmi_apb", "gpmi_bch", "gpmi_bch_apb",
+};
+
+static const struct gpmi_devdata gpmi_devdata_imx8qxp = {
+	.type = IS_MX8QXP,
+	.bch_max_ecc_strength = 62,
+	.max_chain_delay = 12000,
+	.clks = gpmi_clks_for_mx8qxp,
+	.clks_count = ARRAY_SIZE(gpmi_clks_for_mx8qxp),
+};
+
 static int acquire_register_block(struct gpmi_nand_data *this,
 				  const char *res_name)
 {
@@ -2281,7 +2294,7 @@ static int gpmi_init_last(struct gpmi_nand_data *this)
 	 *  (1) the chip is imx6, and
 	 *  (2) the size of the ECC parity is byte aligned.
 	 */
-	if (GPMI_IS_MX6(this) &&
+	if ((GPMI_IS_MX6(this) || GPMI_IS_MX8(this))  &&
 		((bch_geo->gf_len * bch_geo->ecc_strength) % 8) == 0) {
 		ecc->read_subpage = gpmi_ecc_read_subpage;
 		chip->options |= NAND_SUBPAGE_READ;
@@ -2692,7 +2705,7 @@ static int gpmi_nand_init(struct gpmi_nand_data *this)
 	this->base.ops = &gpmi_nand_controller_ops;
 	chip->controller = &this->base;
 
-	ret = nand_scan(chip, GPMI_IS_MX6(this) ? 2 : 1);
+	ret = nand_scan(chip, (GPMI_IS_MX6(this) || GPMI_IS_MX8(this)) ? 2 : 1);
 	if (ret)
 		goto err_out;
 
@@ -2721,6 +2734,7 @@ static const struct of_device_id gpmi_nand_id_table[] = {
 	{ .compatible = "fsl,imx6q-gpmi-nand", .data = &gpmi_devdata_imx6q, },
 	{ .compatible = "fsl,imx6sx-gpmi-nand", .data = &gpmi_devdata_imx6sx, },
 	{ .compatible = "fsl,imx7d-gpmi-nand", .data = &gpmi_devdata_imx7d,},
+	{ .compatible = "fsl,imx8qxp-gpmi-nand", .data = &gpmi_devdata_imx8qxp, },
 	{}
 };
 MODULE_DEVICE_TABLE(of, gpmi_nand_id_table);
diff --git a/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.h b/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.h
index c3ff56ac62a7e..502f01a8338c3 100644
--- a/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.h
+++ b/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.h
@@ -78,6 +78,7 @@ enum gpmi_type {
 	IS_MX6Q,
 	IS_MX6SX,
 	IS_MX7D,
+	IS_MX8QXP,
 };
 
 struct gpmi_devdata {
@@ -172,8 +173,11 @@ struct gpmi_nand_data {
 #define GPMI_IS_MX6Q(x)		((x)->devdata->type == IS_MX6Q)
 #define GPMI_IS_MX6SX(x)	((x)->devdata->type == IS_MX6SX)
 #define GPMI_IS_MX7D(x)		((x)->devdata->type == IS_MX7D)
+#define GPMI_IS_MX8QXP(x)	((x)->devdata->type == IS_MX8QXP)
 
 #define GPMI_IS_MX6(x)		(GPMI_IS_MX6Q(x) || GPMI_IS_MX6SX(x) || \
 				 GPMI_IS_MX7D(x))
+
+#define GPMI_IS_MX8(x)		(GPMI_IS_MX8QXP(x))
 #define GPMI_IS_MXS(x)		(GPMI_IS_MX23(x) || GPMI_IS_MX28(x))
 #endif

-- 
2.34.1


