Return-Path: <dmaengine+bounces-8279-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 221FDD25A3C
	for <lists+dmaengine@lfdr.de>; Thu, 15 Jan 2026 17:13:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C6EA83094FAF
	for <lists+dmaengine@lfdr.de>; Thu, 15 Jan 2026 16:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 946313BB9E1;
	Thu, 15 Jan 2026 16:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="OcqbENA4"
X-Original-To: dmaengine@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013033.outbound.protection.outlook.com [40.107.159.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4FBD3B8D77;
	Thu, 15 Jan 2026 16:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768493248; cv=fail; b=XBnqbfxfLwnKnfawyt7HpvPLFIzfx9eaS1+qTthYUPXfWaB3jfj0mZ2Wwh1B/e9j/HePO+sAKzS8/fG6M3AI7C/Ez6yviLkfVRsd+dOXrYY1M3GjNjG3Cntc+ebEDx4axQJ+grJaYLiobxweFiWW8hDkHnrQBVm5rytQx6sIlZI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768493248; c=relaxed/simple;
	bh=cbsn3t39yK8of+fZNme1EvQkk7pZNivd62vB+72ztjQ=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=a/QdJTLRV/+O8eYj1TTixbjq4GnCGtUmHRqaYyJKOkfE7AaOnHE6mEOPJ5fWcckuKoufr0y1r823+ArP8XVZDkA2Os1Wut3wpyyd5c/a8UVjLnU11WLEp+p97N/IaqAaxazKH8yHmT3muAWEiAddJdGO0j4SCDTWpzypFeiMWt8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=OcqbENA4; arc=fail smtp.client-ip=40.107.159.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iA/Bfn36xoCiajWwIKoxXDsfnrojTKcg+hL1EyTR+oZ3amQy8l1uXzskYFgUJFIXD3wC7RGrbC8XKpz6yMXdSOc7kT5tr5twTjJohnWDnCZYeFykinFdGFAW6++yY07Ooz+7E6LN6iJt/8qxM7xFm9C/QDoJ9ZY2FamgbhBYcdHp6P8C7kpUNDuS0c8BPyorC03zgWtgUyeQ0rmA7WVtmuD+gQVhgib4uLD9WVhdhi4pOEJPnrjrCFFs13D9cL12QKad/l6EV43Dau7HEKmn4SBOKOLUi6B0yDUhJgYi1ZyKNKW/COdm5SwR0rzjIgEoe1+2Wrp1yxcuQOlp90UJRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TMM5es72wPxjq0pX8Y8HB5Ao2DVyjs9fhZyBwtRM1vg=;
 b=seE+z6Ccf5mgdn6RSDAtpA/Ls5k0zHsXdtkWQsoyrYftc+dMzkAbblg+KmGC8xXe7XK9M+HQF1i3ZRmNPB8uQNKB2lrduygydzUHKxY8a0qIdis9SqFgElAu9SNSGL8oS/CbE4ZzSEqiacFM0rQZBxYxtcr3WhCQarg1ODbuoQW29VpmlqY6iNh1O8od3DCcZCO20Z/tCQb5S1n5LjVQ8VDO85CbtmG1p9OA9SN9LzkC9GlCjwPBHUz3AoSDYT6FP7Frb6HpWeUOG9J1ciOBDYmHjKQObfn1lbt3uuLE6C8UbyAFIFh2hqFOSuqD7DhN6Lt9b4o1kh81bVOYIgjSjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TMM5es72wPxjq0pX8Y8HB5Ao2DVyjs9fhZyBwtRM1vg=;
 b=OcqbENA49aFwFZBCSfG3KoF+6BnBiH73W9fiYMkCwR4lvQ0N6l1jBonVfRUi6gz9/vZD+8vY4QgEx89uQ66GtGnY9WaQqZSa8mbBXV+1Q5KTGd0oYf2LL1LPzLFNGBAE0r0Cc8WztSRbPkE7UiV9GiEd+cj8cF8raIU4EKmPYileArpdlEXd0B9whYrK0JgkPIUO6ezx4bKpKHN5WoHOvy5CFRxLniyrNAR7CE4FBxpiOlAWaipGwCbQPasJBxTwMdeLloXjJgfzBT/wVMUeyqxpmkdiPE1Pz6oNn+68c1uj9bYKTZMJBM4GE9tUYPVReVT89Dl0XEgNYkQT99FSNg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8948.eurprd04.prod.outlook.com (2603:10a6:20b:42f::17)
 by VI0PR04MB12235.eurprd04.prod.outlook.com (2603:10a6:800:333::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Thu, 15 Jan
 2026 16:07:21 +0000
Received: from AS8PR04MB8948.eurprd04.prod.outlook.com
 ([fe80::843f:752e:60d:3e5e]) by AS8PR04MB8948.eurprd04.prod.outlook.com
 ([fe80::843f:752e:60d:3e5e%4]) with mapi id 15.20.9499.002; Thu, 15 Jan 2026
 16:07:21 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 15 Jan 2026 11:06:44 -0500
Subject: [PATCH v2 05/13] dmaengine: mxs-dma: Use managed API
 devm_of_dma_controller_register()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260115-mxsdma-module-v2-5-0e1638939d03@nxp.com>
References: <20260115-mxsdma-module-v2-0-0e1638939d03@nxp.com>
In-Reply-To: <20260115-mxsdma-module-v2-0-0e1638939d03@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768493221; l=833;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=cbsn3t39yK8of+fZNme1EvQkk7pZNivd62vB+72ztjQ=;
 b=FxhA7542e2KutjkH4tUYOeDF7ip72gZ/8T2Pj/gAJHXV087SDoS1am9YybVqcCLS+6KqOd//f
 2WmZWsLyrUSCAMX8EJLPVcLDqX70eluWTKmJKv6LnIp3qaY+pxQy4a2
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH7PR03CA0018.namprd03.prod.outlook.com
 (2603:10b6:510:339::15) To AS8PR04MB8948.eurprd04.prod.outlook.com
 (2603:10a6:20b:42f::17)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8948:EE_|VI0PR04MB12235:EE_
X-MS-Office365-Filtering-Correlation-Id: c0b0afcc-f72c-4a2b-a8d6-08de545029ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|376014|52116014|7416014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NjBoM3BMcjRlRjNmTW9SQXp2cEVwS3dQUFRveEFXc3dxM2JkQ2l6a2tXT05C?=
 =?utf-8?B?Vy9GNlFjTndZbENSeXQ4SzBlUDAwOWY5eGt6cGw3eDZBZUZnQmdyUTNQdjc2?=
 =?utf-8?B?R1h1dysrd1R6dnFOblJLN0dtYlBhT09JM3dqd0NkaTVFMjF2TW0wdGRCQkpv?=
 =?utf-8?B?Q3lUaXVJV3BJYTlOSzFoZk5PM2wxTnpTc09OZGFNR01BZFJzelArOTJkZmxq?=
 =?utf-8?B?TjluNFJ6OEtXNklUcU1hT2ZTOGVPWkNtMEgzOVJ2WHdkU1lzZis5WUxFRDRY?=
 =?utf-8?B?amluWEZUaUhHUkVweWl2bWkveW1qRFBvd1pCZ1hkRUFIczhTOVBvNGZLVndJ?=
 =?utf-8?B?N21lMFhST3hkaDVNWGtXbEVRczdWWi9vanRYcGE2MmhiK1NORGVtb3FURU9h?=
 =?utf-8?B?MVpNdkVRSURmK1RIK1N2Y2EzTlpEaFJiVzNnSkUvZGl5OWpHUll5aTBJV1RO?=
 =?utf-8?B?S0EzUys0Y1dTczlQS2ZYYkNHV2FOdVpnQ2xua05Nc1dsaVUvMTVQMGZ1VkR3?=
 =?utf-8?B?ejlDOFg5SUl0MndlaGg3MFhJZHBIa0NpTEQ5emhSRXBXNi9qQVM2ZUxjV2RH?=
 =?utf-8?B?RHBidVhUODM4K0RDSkk5VU50ZFk3SER3eHdpaHhSOFhSNklLczUrN0RXVUlm?=
 =?utf-8?B?MEVhYVJqaUlqazE1dWw5MkxRMmRvMkFnSDRXbTU5bUpCZU45RHFsQmdiQmp6?=
 =?utf-8?B?elJqQkFjZ2RQN1NlOCs3YzF5ZmEzZXRyUmVMY2ozK0VKZlVhcU5PMmM5aXVZ?=
 =?utf-8?B?a1VSajlQSUFQOGdqV05Td3JFNytaL1ZYakFLQnJ5Ums2aDJKc2xxOFZKelhz?=
 =?utf-8?B?bzRZa1d5T2dscW9RVmVZdnNoeURUOCsvbWR3cUsvL3FZNHhOMTlWZGJjcGk4?=
 =?utf-8?B?TDhaNGYyeEgvSFcwdHhCVHZudlhzaXdIK0VTMEZlckdmbHVaNkYzdG8yMThG?=
 =?utf-8?B?UkpHaXVHWUhsb2VzR2NYY3FhRk1kUmNKN0puTlNHRXhvc0F4cDlzSUtmUG9P?=
 =?utf-8?B?cVVjMm1MQzBjUXk5RUJrMFVUVzkrWkt3K3RtMWNlWVNGR0lrelY0cHpZQkhq?=
 =?utf-8?B?aERDQVRhN0ZYSWNvdlpMUGJIcjJDclBXd2JwaXRpUkM2UlRtL25TenNnV3NS?=
 =?utf-8?B?bGs3dXU5ZTVCYmJnOG52blplWlc2dk83ZllBT3FNWGFxYnQ0NU1QNUgya29B?=
 =?utf-8?B?dEhQTDFVdUoybDVOV1FpSjdBUlNtN3N5V2poR3k3OEdVTjk2SVQrWjdqWDly?=
 =?utf-8?B?Y2ZDYlFLVmFod0dVMjA2VkhWOVJkbU43cGcvdVpKUm5HbHNXeWlncGFrZWVh?=
 =?utf-8?B?ZjNlOU12N3NodUVyWVJSVWw3R1NZOG5FZWQ4cS84anRabk52NHdRN2hrNkd6?=
 =?utf-8?B?L0hERWh5R3p1ZW5uWUVNa1d4WDFWSGhuS2hObFBpT3RpZlQvTGtuMkR5NnFu?=
 =?utf-8?B?ZUN5THNOWE9PbGY1UENEbHBQejZqUGdzQllDWHlwTW41ZnhabU5KOGJiTk1m?=
 =?utf-8?B?eEZ4RHF5L2lxRzMwOTc3VkVMYStzMzhOYjR5aHJLRjlrcFVlUmhVdEE4TnNO?=
 =?utf-8?B?eXI3c2hUeDR6T3p2bThmYkpuT0FheURSMk5NL2VreW0rSitmRDkwVEhGZ0dp?=
 =?utf-8?B?bytWMWg4UHJBV1VzT2htNXNLOXdBM3F0dFIwMEkrSTJINjlqR25XWFk1OWto?=
 =?utf-8?B?SktmMmtSV0dNbFVMdEdBSFdKRUJ5N0RzRGp6elJ1ZE1WRFVFbUhUc2FabjZG?=
 =?utf-8?B?YnlPRE5sbVBYZUd4cjVmRnJyNGN3aEJGOWpsanRsT09kWTRHNkhuaWs0NDd6?=
 =?utf-8?B?QzAzNzRMZC9uTVpPRmFuL3d6K1M5dzFVODNXTWR3V0NGenlJdTlvbFQ4N2or?=
 =?utf-8?B?a0hzTDhVWjNZeXk3Qm5hWWJXZ0xnc3Fkb1F1M0tDNEMzNUwvS2lCMHdhTzN4?=
 =?utf-8?B?TjdGaFJINzRJRU1oWUp6UkpkMldJUDlQLzlVYUZPYkRoY0lyeXRMYXJ4cFI3?=
 =?utf-8?B?a1N5aXpGalMrS0VoVTBLMndINGlIMTRWT3RZREpqTEUxZThzNzdqRU12YjRp?=
 =?utf-8?B?dmdZZmFETFdxU09oNGdKVThnOUdpUnFVUXN5RVUxeGNKR2lLNUl1bjdrZFJa?=
 =?utf-8?B?Z1lXUmsxOVYzVmRjS0ZBK1VNQTdqL0ZvU3c2ZExwZ09CUTBqL0ZaRzE1Ujl3?=
 =?utf-8?Q?KTQt58lVeosXPYk2xm6IZQk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8948.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(52116014)(7416014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VDRkWUtHS1VOdXdDZG9OS2dRR2JSVHg3R1AwYU9ZZXdDeVR6bjhndnYrQmRQ?=
 =?utf-8?B?a1E5NVltL0JURGllU0Y0VUttNGJVNmNHZDJXaGUrbEQvSWJTcU5FUlZiUHk3?=
 =?utf-8?B?YllPM1djdUh5MldRelcxdCtoZ2tIVjNWTmFRTHJVVU1FQ3lnRW12d2NvaUNT?=
 =?utf-8?B?WWUzUW40VGZLbjJUc2liam9OOWl5WXhUVWdFdktNcjdKeEZrMGNUd2FCY3o0?=
 =?utf-8?B?dXJBbS9OVDY5dW5uYVBNVVJFMnZsYUliMGg4UHV5b0cralNoK1VIUWlvdEVG?=
 =?utf-8?B?MXpaYjI1dkFyQVpOQjY2WldidlNCYXZaQUV4dng2VmFvbW5VOHBJa3hqTmJ3?=
 =?utf-8?B?UWZyZGhKejNqQS9LMEdCQUw4dEpyWHkxQkZRVkE4U3poQnc5NmQyV1JIMmQ2?=
 =?utf-8?B?emhnSy95Zk5RbmZMcDE1dGxscHpkSDErSWg3b202b3ZDc3RhYlFHZ1ZoOUNt?=
 =?utf-8?B?NG42VWwrbEkxNjBxb0Q5cGU5UW9rN0NFbEM2U0x2ZkNDQitBQkpQNS9TSVYw?=
 =?utf-8?B?Tk1pTHlSNUNZTUZCU0NqTDBYZC9rNlJxRUV0enlwdWk4VG1xVlRYank2cXJT?=
 =?utf-8?B?NWNHLzlMQUZXOHZNNy9JdmtGVG9CRHN4dzdOZzQ0MDVzMjZGdFBjMzAzb3VQ?=
 =?utf-8?B?cmVEdG5rQlZiWDhMWjViOC92NXlCUWZYUGdMQ21Ic1hwMmNxeTE5ekhuZ1Bn?=
 =?utf-8?B?SGMwR05pRk5mRnhDUEhGcGpBdUNpQ1Nsem1KTTMwUURhVXhJMzhZZXJKUkJX?=
 =?utf-8?B?YVUwZFNVbUZjek9DV2JkYlpTUXRid2FDeXlrSnZmUzNnZjVGV0F2L2p2Kyth?=
 =?utf-8?B?c2VEa05lYkJIbXdwQkFUNTVmaHpiOEZ0azcrL3dISUszTlBGN0o5STdmZ2Zn?=
 =?utf-8?B?emRkenBUdzg3TkRWdW9BbFVzWmgwRlJlSE42ajJHdkNBWUhBeUl2QTJnNHRL?=
 =?utf-8?B?SkROdUZrajJ6M1BGOG50aUQ1MXlFUnQyTzQ1WWtTZUJYV0hGTXJTZk1aclQx?=
 =?utf-8?B?Z0xoT3pRU01oTUc1QnlnMG5TY3NadFA0T3NXYWFUQWVPWUV1ejliMHYzZjR1?=
 =?utf-8?B?UysrT1JOTk9hZVFSWWljSzhYZlBKZVVjOC9CbGNhZlNPWStJWStoeWRCNldi?=
 =?utf-8?B?NkU4NmxLLytaOHNDQnJCZW9EYTN1dmtPaVl6NS9obGphYm9QKzVZd3FkMHZH?=
 =?utf-8?B?aTFiak4rODFwYnlaTE15UnR4bTllRzNVY2Fldm5PazdEQTZYS1NpdTlNKzVL?=
 =?utf-8?B?dm5ZbnB5dVhBejlKTGlWNWZUMzkwbjJ1NnJVQTJqbCt0NHF5UzBjb2w5WUlK?=
 =?utf-8?B?K1lNcG5XRFJqT29MT041RWFVZ01uSmhpZi9oS1Jkc0FhV3RvUmFiZXBIazdE?=
 =?utf-8?B?YkxYbUQvZG92czcrTFhXc2h5aThPRzZRblkzeHRuTndDUWJKTmRuMmhPSjZU?=
 =?utf-8?B?NXF0bzVFTDdkTjhaMmFaRXB1RUVYd09nUE82c0hXTUFJdTdxZEpNVmRHRVlB?=
 =?utf-8?B?RVZENmh0clhsMkNpVzYvVUs0VW16cFZRazB2eG9TQzRPTmZqY0psWFNEYTZs?=
 =?utf-8?B?SThvK203WnAyVTB1VGpjSkNnK2F4bDJMNUQvUDB6Tlc4SGcxM3hBMjNDbGp5?=
 =?utf-8?B?QklDbFJEaSs4a2RUUkM1blBiU2kzSUJ5a0pNb096TWdkOEtrdjN3K0VQOGdh?=
 =?utf-8?B?NHdSeDVpbFU5b0JRWXJtcHBlVko5d2EzdVVqY0VhN1hYU21meTZNcFhJSmhP?=
 =?utf-8?B?Q3Yzb1llTll5TWRFM0pGNmlReXFSVnlsL2xoRm9abVNuMVowRlNZcHdyTTQx?=
 =?utf-8?B?TFg1STFQR0hvaUhKcWVRQnc5cGZlTUMyMTNaU1NoN1dPUkpLNkJGblUzaENa?=
 =?utf-8?B?UFVpS3hjdldvZTY1bXZQaS9naGp5a1VFL1ZFcjFEZTRjUk9DNnZCdnpYTTd0?=
 =?utf-8?B?SkNjUFJsOVpYa1AzTXpTUWNrQUtTNklvbklTTEJObTIyVDVoTlVWV0lPZ3lx?=
 =?utf-8?B?dXA4Q0FwZitRcDZpZXdVWTJYUTE5dlgxQzJlcXJKVW5STU9ab3Y4UVlPRVpp?=
 =?utf-8?B?ZHVFaVY4TTdFOTBDYWh4K1NrNEtTak92N1kvL1d0ZUVNOXRUdlhNQUp4ZFdN?=
 =?utf-8?B?aHBVVWlERThFQVlFVmxGQkpsVnVwV0w0WDlBVm9ON0h2MHpUZlpObVkvU2Fr?=
 =?utf-8?B?UWhhZWJCZWtoeWxEUjFFOTNER0I3b3Q0RkdFTFhLWjZsT09xOWprc3pLWGlB?=
 =?utf-8?B?Yi9Vb0pCVFh2alBnSWZQTE9rYVBNSHdQNnNTSmFBMTRncWdCV3dkODlpTGRJ?=
 =?utf-8?B?U3JwYnc0RGRNOGVGSHMvTlYrNXZ4US8rOFdSR2NoZndwQnZhY3Fndz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0b0afcc-f72c-4a2b-a8d6-08de545029ec
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8948.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 16:07:21.2144
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SGOukALwH3GgnKnbAm9J+FIqMrHeIiQXHfzzJeJbLEFo4CNMeM2LCu7rgRKskNIFsFnvsEpbFBxzVw6FrxLdBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB12235

Use managed API devm_of_dma_controller_register() to prepare support module
remove.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/mxs-dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/mxs-dma.c b/drivers/dma/mxs-dma.c
index c1d4c6690df1af476aeafe77ff7f78bff1e413f1..e047a41a8df2e84e0c68b112f59cc79c0ab84491 100644
--- a/drivers/dma/mxs-dma.c
+++ b/drivers/dma/mxs-dma.c
@@ -817,7 +817,7 @@ static int mxs_dma_probe(struct platform_device *pdev)
 	if (ret)
 		return dev_err_probe(dev, ret, "unable to register\n");
 
-	ret = of_dma_controller_register(np, mxs_dma_xlate, mxs_dma);
+	ret = devm_of_dma_controller_register(dev, np, mxs_dma_xlate, mxs_dma);
 	if (ret)
 		return dev_err_probe(dev, ret,
 				     "failed to register controller\n");

-- 
2.34.1


