Return-Path: <dmaengine+bounces-8256-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EA90D2196F
	for <lists+dmaengine@lfdr.de>; Wed, 14 Jan 2026 23:34:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BBB72300A3CB
	for <lists+dmaengine@lfdr.de>; Wed, 14 Jan 2026 22:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 077063AEF36;
	Wed, 14 Jan 2026 22:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Cao6qMjM"
X-Original-To: dmaengine@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011030.outbound.protection.outlook.com [40.107.130.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845AE3AEF2A;
	Wed, 14 Jan 2026 22:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768430044; cv=fail; b=VjCbOaLluRxJPYlO5zVYVdUcZt8n+fT2KKuJe/K0eXiq6haRwoNStoLNBDRBi3JYKpWXMFJAFHyXm/Ay3X+NCx0RnuPk53CFULEBf5LzD3aQ2vnhhgNaNggdEcTDym3EQuX6FTNgqgRkPKhgpPT5Dus+ALyWHZbNvs0uz98/gfs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768430044; c=relaxed/simple;
	bh=RR9Ax86TTvlbwbHb9epq/PdeBINY94uLfXqRf1EWO/Y=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=P6YFV5Tu5uyNoyI4oYPHYuCFiXh4PHUB3fMfRW5b4hdS0qLUfndTXiG0UtMi0Ibq/e1TNnrHUgdLVNkfjCjHZL3Hy7K+uNkvnVl57zNVpw8zjhcO9iL+rM9MywO6Pyj1F3Ii3o8mjXDgRwVF7G5boS18rezZfpU82XkD5WYzBkM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Cao6qMjM; arc=fail smtp.client-ip=40.107.130.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Za9xIRb+3+ECfqhwmPWSbZAmjdChupZrIFa6qK85KgFLhb297VSZdFbjSB4gTOYKeXW6FU0sOpDmq3lgLVueEWRPZBgBPBFJoNXG4xXuqx6UTMU+RkSxmw0Ij7S38G1qMXV7r2HG+7U/+N0N8W7estiBSATUT4E3GY7yRNvzKZqQpNaisgFygEWZIrIajpf8hIvofPDSRliPC7J/qyV3HfUdWyedubGw+hxZB+QnOXSkka9hs2lJXQE2YOPEunUR2JLG1RtAAXmbheGkyPTMF+F6p/fyXlrz68kPnmaA38AvePHEWzCqAfwGjdElkn0qYDVu7wfPJ24hIyu3frKA/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xuEBbQyXRjZdh5DUuXuKYtBWFtkDrIgtXWkEi/rwDeQ=;
 b=FQjbyBhOkfajIncXlnGSOUzNcKRU4yFFdPeshgpYLIM9ygshc3NFcbkSehuowYY0iTm3WTQ/Wgt9c4p+42GrOVWEy0LiHISDSkhLuzsJNxJwyPYUIgw1XVLpUP+qdNEkOh6AmGr4Ira6WBNt8K5OgZUqdYlRftGBhtGsPoazZB5Vhra4wnTtW3o+cyujraVGKhZ/JdW4RUsiNohIEPF6OhRy5I5/6wYzXKCO6tDCJRD9gFj35q7UI62y0/QHPW5BNHShSmL/5BlPfM8xj0Y1mDPe5JNc3fkvVsa6oLAAx5WJRv2ysVTJWGSBzCpb3KdosSkZtQS5mMChXj5ekOvNlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xuEBbQyXRjZdh5DUuXuKYtBWFtkDrIgtXWkEi/rwDeQ=;
 b=Cao6qMjMS28UMBV97U0Azs7t2m/6HHKWe/85md/HOANBJm4LB3S08ybVmHyrFezhL9mYdsftJsV5zXXUsJ4dGKKm7crwkbk4t2faImJjk7ZQkrG6xTK9DXd70BIEbeqEwPdgqT1gtvbLm2jQV71TwMBlFOXDZbXJl+ufAit4P1Gg5aQFi2YjNOwDosmyUARxnQonwQdAD5e7Xpq1OCJnkddy6jIc0SNmV/VFTLImSdBGeMvYH/3DicWu5f2ClouRnCgAdA1vW18xx01zIEXFGtbeapePKvrigukCuThfekb+2OZ1dCXl89hJ0ve9YzlRY7lzG1zsC45CGMStW5c64g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by DB9PR04MB9554.eurprd04.prod.outlook.com (2603:10a6:10:302::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.4; Wed, 14 Jan
 2026 22:33:46 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9478.004; Wed, 14 Jan 2026
 22:33:46 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 14 Jan 2026 17:33:14 -0500
Subject: [PATCH 02/13] dmaengine: mxs-dma: Use local dev variable in
 probe()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260114-mxsdma-module-v1-2-9b2a9eaa4226@nxp.com>
References: <20260114-mxsdma-module-v1-0-9b2a9eaa4226@nxp.com>
In-Reply-To: <20260114-mxsdma-module-v1-0-9b2a9eaa4226@nxp.com>
To: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, 
 Vinod Koul <vkoul@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: dmaengine@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, Shawn Guo <shawn.guo@freescale.com>, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768430015; l=2461;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=RR9Ax86TTvlbwbHb9epq/PdeBINY94uLfXqRf1EWO/Y=;
 b=gaOP0FNXve3ZRbemvvGt4db/JdRUCDbGYckgN+zt0NzfnXPf8J1yLDChtbjIzdRHZj4zCqqrm
 PoDdBTvAnbyBTBQfpbsjm5C1bK2uxe9Op2JsaiDo6uZOhvaivyHT4kp
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH8P223CA0005.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:510:2db::19) To AS8PR04MB8948.eurprd04.prod.outlook.com
 (2603:10a6:20b:42f::17)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|DB9PR04MB9554:EE_
X-MS-Office365-Filtering-Correlation-Id: eb592654-6f72-4264-d666-08de53bcfb1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|366016|7416014|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WGY5WWJPQ2lQd2tQMWxoa3FwVWZOMWhaakZWUUpuelhXMnRaUW83UFBoRlBW?=
 =?utf-8?B?SzQ3blJybkZ1cVpXU2VxV0pVL1dOcDZuVDJ3LzdHYlc2U3lUYU1nQWNGS3lr?=
 =?utf-8?B?OEloZzVkRnpUK1o5cU1TM1RiWEcybjhpR2loQzZDZ2tKVlFWVXJCQWN3Q1Ro?=
 =?utf-8?B?ODdVcEl1TzhGM1hadHhJUjZPeXhnckVQMW0wM2U3YWQ0NUZLKzBSQUF2WkVh?=
 =?utf-8?B?emJsMzVPaERFQy9XcjJjcmczKzRmVE1TYzdjQ3MvUzhjY3RxKzdnMFNWMzFh?=
 =?utf-8?B?ZTRYZERkR0hlOHBUWXY3YW00QzczZXozTUZlbWRYVXk1NTNLQUQ4MmFwWDVZ?=
 =?utf-8?B?cXdYOWw5NEdNMG1EcFhORHMwbVc1VmFoc0E2eFB1VEJ3VFJ2aU9GdEdKSWxP?=
 =?utf-8?B?VUhYcmU2QkxuZ3BvUGw1emZpOEtSNG9md2I1TmI5TkxtbmxycmN2SExWcGxJ?=
 =?utf-8?B?VnEzVko1MVZpUUVtSmZkQjRZUTRJWkZmQVRNSDU1SmcxYXpyZTV3aTFsSW9E?=
 =?utf-8?B?TkhzVUo0dUlYN2w4aExrZXMyeXh5K3hLcU9qSVdNbDR1WDlsYnlHN3BIL01L?=
 =?utf-8?B?MVFGVHg3MHF0dFdaSHB4NCtwcFdLaWVJS1ROa21hVGVLMFJYWk55YXJWZE9D?=
 =?utf-8?B?VlRyMERyN3N5dEFPbjN4ZGs5bjdmS25ZdDZnZkJOWUwzUUMzc1lQSlVEYXF3?=
 =?utf-8?B?M2JFN2RSTXFsbFZUZEYxRUpONC9hY2ZybkRQd0JVV0crc2lmNEhldS9ZY2RK?=
 =?utf-8?B?VlVpRTZ2Q0d0V0I0UndCMkFXbXE2Wi9IekhITkpmaW05akRleDNvNXdpSHNC?=
 =?utf-8?B?V1l5Rm9oZ0FGdi9IRi9hZm1vaWZnaG5wdTJtR1BhcXpxMkV6NFRsYWkrOXk2?=
 =?utf-8?B?VmE0STdyTytkVGh0bnRBemd1MGREbkQ0ZEc3NnBnODE1STFZd3E4SjNmcDcz?=
 =?utf-8?B?eldBaVhvT0VJZHlxd09HYWxSNFk5WTBiK2g4TkFPdUhUanQremtpZ0MwVUdI?=
 =?utf-8?B?MFJ4L29QNHc4ZmFoYTR5VTJBelB6aW9nZ29ZMGplODBydjZNSWJxSkllZEtU?=
 =?utf-8?B?OWNhU1RtRkZ4ZlBRYmlMWW5OQjlrTzFwaS9NejZUbndyUjRjQ0RWRy8xYVJV?=
 =?utf-8?B?UjMyYXBZYXVMb3BsdDF2dTNodk5oWlNvSm1kSW1MZThiT2VNdVp0aG1FTXhq?=
 =?utf-8?B?cjNIUWZCbWppN2MyblhoMDk0K3RLR292SEpJVWV2NFRHbUdDZ1M3cE1XdWpH?=
 =?utf-8?B?V2pOUThQUDhWYTV4WjRaSjJMMHgyTGZVTENla3JRTVd5S2htYXVzYStrQzBV?=
 =?utf-8?B?N2NMbmptVGhERnMyZy91a0ZKUExOdU9NYU5YdXFVdlRObWNhVGVZanhXN1p0?=
 =?utf-8?B?WEk5bStJcDRLWUZrM2xueVRnTzVpdS9Ock4yWmtWSnZ0Lyt6UUY2WEE5RUQ3?=
 =?utf-8?B?ZnoxeTUwTnF4dzhRV3paY29WODh3QnRFUWlXeFlwOFVsVlNHUXA3ZnNuWlds?=
 =?utf-8?B?Z1paUTlPTHZQbDhaa1RRMGNXbDdIVk9rRElUVzVITExnOGhUOHlodXVNZFpy?=
 =?utf-8?B?K1JoTmhVRXJiVWI4ZXRNeGVMaUtNZ3djeW5WVlZySEUwcDc4Z0JMM1FzK0hQ?=
 =?utf-8?B?bERycE1wemhZZjlrcEdsUFk2Z1NBdEpNRHo5QTJDNHBSNlVvY0dYSEhTb3h6?=
 =?utf-8?B?TmF4c2dZckhBbFdtWmdNME4vbEplaS9BTjh2VjNrWklFcVF4MktzdDFLazFx?=
 =?utf-8?B?dFI2M05VMHVyMkZyVWZvM1lVNHNSUDg4ZmdSQi80SW9NZlRleStGeTBaUm05?=
 =?utf-8?B?bWN4RFBEVVBaemVkNHpKSlAzMVFYTWZGc0h6RmU5Q29YN2d4dnhaOCtMM1Iy?=
 =?utf-8?B?K3BOSklxb2UrYlplbFZGbC9sTzlNa1ZIZTRpWFJKOFI1eFV6dHZmSzFqL3o2?=
 =?utf-8?B?dUpPblZNeWdQOExzdEN6dUJFekh5SFFuVHRBUEU4cnliVTdoMXFjcXF3a3VU?=
 =?utf-8?B?MXREQUw0TW1WMk5UM25TZ2JIdDI3cjdsSTFXV2Nod2l5OWEvMHZLcUc0NFlW?=
 =?utf-8?B?TVJIT25hM2lGQmJxeXB0bHlIWk1VV2tGLzhuSGpDdkxYNm5jc2FIVCtlTy9p?=
 =?utf-8?B?ejlzeHVjNVZSa3l4cGdYT01xWGNMK3c1ZmxKby9FajFvMG5yb2FiVUluckNT?=
 =?utf-8?Q?XNPuOqUtlY97gdFtTYgqgpk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(7416014)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NXlqV1dKYi9nQWVueS9JK3RERlVsMTZhYWRtUldpb2lWMENGejhPUHNvMGZI?=
 =?utf-8?B?dXlyZlowOFE2YjV1dUVqSWJiU1lsc1RteTIyN3RlMklidTNpTFRMRE9xK3JS?=
 =?utf-8?B?c0psOE1xNDZXNVBtOGUwNkV0NTVkQmZIVFRBUUYrZkllc2V2anozTWlZTzFP?=
 =?utf-8?B?dUErT0xyUDZ0WmE4bnpTQ3g4MlFjS0Z0Z09CWGxWbGRPVUlrL3dOa0tubTBl?=
 =?utf-8?B?RjI5NWZXWmFmTkhua3BEam5wRGRPckd6RUJyRVdoUHpxaEREdThWZWhKV1hW?=
 =?utf-8?B?a3dBRnlWNnNsRmRsYXQxSWJRamdsL0RKVG1DT1RDT3dNMUd5ZUtjM1BtZnFW?=
 =?utf-8?B?YnVlbWxiZGU5NVFNSFByNkZqU08zTHk2NzNzM3VoSVhmZkd6K2ttMHovVFV3?=
 =?utf-8?B?anFudURtcExYcWYzN0F3SFl3NCtjbFd6aW5lK0NaZ0E3VE02MittYUVyc0pu?=
 =?utf-8?B?TzFIc3RvWmVkUmZ4Zno1MGM2ejNoaFBXcWhvVlcvbzFNWTJCWGpNV1A0Zm9X?=
 =?utf-8?B?M3NJVnZmbHhwTzdBWTIzVVV3Z3BncnNNQTNzc2NIdGt4aGtxSkpUUTJ5SHJZ?=
 =?utf-8?B?anBNVTVwbVhTSHdZWUFKMWoxS3A4cFRadmttTlZsVU93T2hoM1U4R0JBck5D?=
 =?utf-8?B?Q01oYkxsZW0yZFNBcU9Od2ZqaXVxelRweTVsM01YZS9yNldPVjZYNFhiU2RP?=
 =?utf-8?B?VWNZUkxDOFk4VGhlZnBWV29wdm9vVE12T3pWY0k5eHJFem9pekF0azVnZW9l?=
 =?utf-8?B?R2Y3bFA4anplWUdYN3FMODBnektTT3hyS0Y5THpOZFdPZzliNkF3WHNCaWJT?=
 =?utf-8?B?ai9HZnA5cUF0RHpheklhckdWaTdoYmRGcjBSR0lOYnAza3c0UTRLbStzUmRF?=
 =?utf-8?B?U0xkVHV1T2lPbUpBY2paa2ZPaytWTVBQNXhFVFhGSmxSRXFlMlRSblFxV09r?=
 =?utf-8?B?SGpyWjdndEpXQitWMnRGSmllTUVqdnpMZlI5SktFc09vVFV3Yi9CbUhRNGli?=
 =?utf-8?B?VUJOOWd2dFdEall6ckl2dytxaHdYR1htaG45cTFvek1pUjlwY083cWVHTFVv?=
 =?utf-8?B?MjZrTGlvN2xQSlpqc3h1Z01xWGI5ODlxZFFxN2pSUzhOZmNlMmhGOTVxVlJM?=
 =?utf-8?B?N1NvYVZhRk9zUjdzWTRRTnd0Z09md1VETC9qWWk2ejY1Um1qM3Y0bkR6TnB1?=
 =?utf-8?B?OWUrTENzRk9YbWE3NmVLSmpCT1NXaW9JMWhDUW42RDBaVE9oQ2dIL3Z5SkxU?=
 =?utf-8?B?RnZkWm5NdkU5aDE5MXBzb3gveVc1YnJGYjhJTmNMNkRNMi8yYUZmQXJSeVRS?=
 =?utf-8?B?dHV0TmJuZEVhV1h4T0ZENmR0RzRUNm9JNVVmRHhVdVJ0MU5xUG5aSU5qeDRz?=
 =?utf-8?B?bFd6RHhTY0xMVGtka1l2ZDFMWDN3d0RKa1NXUlVBYUlBOXZRS3NValBNL3NG?=
 =?utf-8?B?VGZ3dHl1QU5PaFNqc2tiWUUzNkloZHJla1JsOXkxdmFncklLR0o4T2t1eWdW?=
 =?utf-8?B?MlQ1bnRuYnFVODhoaVB5US8yUHp6Y1daS2VaTzE5R1VkVlZ4b252NEMvT2Yy?=
 =?utf-8?B?aldWRHFubks4OG1XUUxGOW5Wbm5EcXpFUjRCT0pWeGtQRW03WENCVElDcDBY?=
 =?utf-8?B?akFRZTh4MnZRTllESmJDemMxazJHNzFGeHN1cmE1ek53Rld0VWIxZUxzOUFz?=
 =?utf-8?B?MlB0NGlIQmpPOXVFODhOMU1TYm1jaFZPd2JkZVRrQnluNlNhZEpqNUdwdjhJ?=
 =?utf-8?B?ZnNmb2dNOFRWUlEvSlVxenY4eXF6b0NhSXFZWG9VS0FvWmlhd2JrbGpmU0VI?=
 =?utf-8?B?bVdEU3dhaUJQOHRXbHFqUG1SUjc1dFd3eVlrTWRQUHN4OTBlVWZ5Z29ydFds?=
 =?utf-8?B?b1ovOSttWTIzOTNBQUFEZnNJcDVjd1kwcGpNS09Md1RVUW80ZnJMOU5OQ0d3?=
 =?utf-8?B?VU5SZU9KNXN1S2VITHBQaWY5L2UwWVBueTBQOEVId0RCakRyTlBZT3NZZVpt?=
 =?utf-8?B?RjdNNThZUFJ5a2ZydmdpQ0RyMmlRRkJ3bGMvTG9oK1doSms2UVVEOGlMeWlk?=
 =?utf-8?B?VG15TWRsMFN6NXVBTHlYWHNyL05pNWhzL1BReFFsQVF3ZHRseVNKajM4WXJQ?=
 =?utf-8?B?cnFibHIyYWNneEFyMmc3MVVqV3hWdzJpcjdNNWY2RUhZQXNBTnV2bERpSWkx?=
 =?utf-8?B?MStEcEpaK0kyeGRjWlg3RERKbXJrbEc1Sk15MXFpaHRSZ2ZUc2N6RGJPcDBx?=
 =?utf-8?B?cE9VTHBQV1Zrc1NXdXdabnpsZ2gzSDBCZWNjZXEvVGtlZERqcHh5dDFNSXhr?=
 =?utf-8?B?cHhlZVUrR1kzWkxpVnluUEw0OXZtQ01PeUZDTlo1akZGU05HQWRnZz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb592654-6f72-4264-d666-08de53bcfb1d
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8948.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 22:33:46.7893
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ck/bsfc5YYwqFUyUWaG5NwMxJHOh/WRF7iMRgUI4A3EtxiaJiwbdt7DGDEV/zXxKJRbfI5ULi/2BDy/XkWEVGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9554

Introduce a local dev variable in probe() to avoid repeated use of
&pdev->dev throughout the function.

No functional change.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/mxs-dma.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/dma/mxs-dma.c b/drivers/dma/mxs-dma.c
index cfb9962417ef68e976ae03c3c6f3054dc89bd1e6..c7e535c91469f0d819d6fe7465725736dc6128d8 100644
--- a/drivers/dma/mxs-dma.c
+++ b/drivers/dma/mxs-dma.c
@@ -744,20 +744,21 @@ static int mxs_dma_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
 	const struct mxs_dma_type *dma_type;
+	struct device *dev = &pdev->dev;
 	struct mxs_dma_engine *mxs_dma;
 	int ret, i;
 
-	mxs_dma = devm_kzalloc(&pdev->dev, sizeof(*mxs_dma), GFP_KERNEL);
+	mxs_dma = devm_kzalloc(dev, sizeof(*mxs_dma), GFP_KERNEL);
 	if (!mxs_dma)
 		return -ENOMEM;
 
 	ret = of_property_read_u32(np, "dma-channels", &mxs_dma->nr_channels);
 	if (ret) {
-		dev_err(&pdev->dev, "failed to read dma-channels\n");
+		dev_err(dev, "failed to read dma-channels\n");
 		return ret;
 	}
 
-	dma_type = (struct mxs_dma_type *)of_device_get_match_data(&pdev->dev);
+	dma_type = (struct mxs_dma_type *)of_device_get_match_data(dev);
 	mxs_dma->type = dma_type->type;
 	mxs_dma->dev_id = dma_type->id;
 
@@ -765,7 +766,7 @@ static int mxs_dma_probe(struct platform_device *pdev)
 	if (IS_ERR(mxs_dma->base))
 		return PTR_ERR(mxs_dma->base);
 
-	mxs_dma->clk = devm_clk_get(&pdev->dev, NULL);
+	mxs_dma->clk = devm_clk_get(dev, NULL);
 	if (IS_ERR(mxs_dma->clk))
 		return PTR_ERR(mxs_dma->clk);
 
@@ -795,7 +796,7 @@ static int mxs_dma_probe(struct platform_device *pdev)
 		return ret;
 
 	mxs_dma->pdev = pdev;
-	mxs_dma->dma_device.dev = &pdev->dev;
+	mxs_dma->dma_device.dev = dev;
 
 	/* mxs_dma gets 65535 bytes maximum sg size */
 	dma_set_max_seg_size(mxs_dma->dma_device.dev, MAX_XFER_BYTES);
@@ -816,13 +817,13 @@ static int mxs_dma_probe(struct platform_device *pdev)
 
 	ret = dmaenginem_async_device_register(&mxs_dma->dma_device);
 	if (ret) {
-		dev_err(mxs_dma->dma_device.dev, "unable to register\n");
+		dev_err(dev, "unable to register\n");
 		return ret;
 	}
 
 	ret = of_dma_controller_register(np, mxs_dma_xlate, mxs_dma);
 	if (ret) {
-		dev_err(mxs_dma->dma_device.dev,
+		dev_err(dev,
 			"failed to register controller\n");
 	}
 

-- 
2.34.1


