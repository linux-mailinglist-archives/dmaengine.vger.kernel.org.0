Return-Path: <dmaengine+bounces-10679-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WIEoNTc6D2otIAYAu9opvQ
	(envelope-from <dmaengine+bounces-10679-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 19:00:39 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 760165A9C71
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 19:00:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C517B320F3C3
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 15:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5FDC360EC2;
	Thu, 21 May 2026 15:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="kmjzUblU"
X-Original-To: dmaengine@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011062.outbound.protection.outlook.com [52.101.70.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9E221B9F6;
	Thu, 21 May 2026 15:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779377589; cv=fail; b=DYR4jIBqZNbO84pmlzH7jt3mJioi7vGh79SoByiltOnCr4TqskuMrFdZ01YZCtgfcGkvKuXKgJ7lytbJu1xJe/jUG7eAhC/DlWvGOrRvdy+Ty6YZuzPUWOuyZt5s9/45V5FuQU6hSElE7RQ545SLGr18OuuLGKq256wu0VDmxw8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779377589; c=relaxed/simple;
	bh=a9A53SM+VdFB2RLFWLugieOW5hEiFRT/j6jsWD40wPc=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Y7I8+wYAJkvLQQEhyytrXuerfcausGpi8lo0zlK6Xo16eJkMicUpS+kWEMT5XmtOxraHX40yR7ShclIlIQ0dv4SHW3eFma2APQCwz9hrJBJTVIvb36cGDIKaNqsx4FfuSOm2pHKwhpdkKkHTP1ZoACw+EJM7KdpROF5yZCL8xGQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=kmjzUblU; arc=fail smtp.client-ip=52.101.70.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FqEv+Gs83RMFJH63ZuTPLrGbwpdikqS9yCFaInxd3yJJMuL51wneMx11HETt8N6gQUYRNlaZ8NnpvQvhblKnj8QobWhfDG7G8vtaQ41I6uGV1h9dHIPnX4piFMZF8fkfzn0HIk8Jx+eBAJ4vKnOvwxnrF5SAJNTdWyD8hVjve0vp+X/fkK2z1zateu6ss6ijmCTlRMKAO0V+Z784j5Q4yo+cPyVAfiXeSyhbq4NY0DdShw35/nzaxejcCOstNQBOedvzIoyYFNQjdDN/c63IQKYgAN2EfcTKY+ncECXvYcYESxMwXBG2k9uN6Q/Nhm5rq2YSQMsUPPDJzBuXjxqTYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+k+bZnLmJz+9qzRK6FRbQBZKkvK2YVJRWu1DVhIt6vY=;
 b=felVaMBLUMfXSPB0HYWf0B4tM0yQgiX+kOzhD78cuNTK6koo46AbgwXJWvcEOa6jRqeu9JtHNii4jt04V0r0Buu96umeCwN0KdlZhYXWV3NFdaEaKBVZGuwPzauhtecu23Yua/kNG81QG1KQGyf/eRjxpVByLAKZm4v+BlT5ynNVLnnjpnTrhINsrZUGjXnYzuTLuKSy/lZQru5bDj+78PSjSq8IppOCEGIdvaGHn83n0pV7BqEsh6fzxDrcD2IPcbTEMxsEThk+w3qSkzt144QE4w6KHpvMECdr5ylHcsj0wlNK+tX/CDuC5qXSmsB5jCtzQFS/NDajwjn/kAMykg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+k+bZnLmJz+9qzRK6FRbQBZKkvK2YVJRWu1DVhIt6vY=;
 b=kmjzUblUfvEhQL93oa5kjDn3aBEhFeMcoX7BRxfWay4JaNem4olCuudLN/cdR/3vUmEq9yUPsrDplPRwIJjwEe78cuEnvBsgMAd7pbKhSiD+jXgq/huxWmctOwq+vVkbUUVsF0SN0n8dzN9uobXRZ4h9867bZoM+vamhLN01wFUN0s936LKOc2/pZ/qjufd8kt+mKBAPfMkGwLyKgpWtoq597Z7um7tkEecX303bMkGM3iL2QJyceqTRZcv94/VWgHekBPBnZWwtTImsexoV1Bvm5nz1xPR8iqBLet0fC0ONVtsC/iLlPZsoMWc33tIQnkkpXAdZLQONZAvz1QAjSQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU4PR04MB11791.eurprd04.prod.outlook.com (2603:10a6:10:623::11)
 by AM0PR04MB11853.eurprd04.prod.outlook.com (2603:10a6:20b:6f9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Thu, 21 May
 2026 15:33:03 +0000
Received: from DU4PR04MB11791.eurprd04.prod.outlook.com
 ([fe80::11ca:6b74:3234:d7de]) by DU4PR04MB11791.eurprd04.prod.outlook.com
 ([fe80::11ca:6b74:3234:d7de%4]) with mapi id 15.21.0048.013; Thu, 21 May 2026
 15:33:03 +0000
From: Frank.Li@oss.nxp.com
Date: Thu, 21 May 2026 11:32:47 -0400
Subject: [PATCH v7 1/9] dmaengine: Add API to combine configuration and
 preparation (sg and single)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260521-dma_prep_config-v7-1-1f73f4899883@nxp.com>
References: <20260521-dma_prep_config-v7-0-1f73f4899883@nxp.com>
In-Reply-To: <20260521-dma_prep_config-v7-0-1f73f4899883@nxp.com>
To: Vinod Koul <vkoul@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>, 
 Herbert Xu <herbert@gondor.apana.org.au>, 
 "David S. Miller" <davem@davemloft.net>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Koichiro Den <den@valinux.co.jp>, 
 Niklas Cassel <cassel@kernel.org>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org, 
 mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org, 
 linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779377571; l=7275;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=NXX3wZLVHLdMncF3RB/2/LEEAsVKc1piFcsNx8qgrf0=;
 b=O22KehRdPyoeRfe/ePi+OFneuhUoLvP1YAqwp6r1LAsRlt2Vmn5cf7Ne064RNlnraUAByDt/R
 SVlH8otFPjEBD794qsDvDqGL8Xl0ni7vA1yLuN15LH+8QYnh/xQUkFO
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY5PR17CA0032.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::45) To DU4PR04MB11791.eurprd04.prod.outlook.com
 (2603:10a6:10:623::11)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU4PR04MB11791:EE_|AM0PR04MB11853:EE_
X-MS-Office365-Filtering-Correlation-Id: 77415684-ae4b-4cab-42a6-08deb74e3f5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|7416014|376014|7136999003|11063799006|56012099003|11062099010|18002099003|22082099003|6133799003|921020;
X-Microsoft-Antispam-Message-Info:
	t6+9lC58/gGmsOAkcjEAoRCi8vRMqDiXLNbBhuteQsIViW6ptNOplEysYuNNEjFjnkTOIOqhbb1N8dOddPjiVZgwRSAZrZNObWMArqKJkzm7eikJI0eeCu7N6FMBKP1q5X0VgGgJf1r97/MGr+qye2U3vipWVj1104UyYX8fT2i+wXMQXoV8vU2hDqzJAxrzAyblSb5k+D3Kn5XDp8zY0eSCDhqxu7K7wKU+9bcT/Q49dxzCASMyKsqqhD4erfSSWySG3+WWfpfQcVJvtmkUJy1NO6st84DxeqHWRYuYIMB0vtASIVIE+eyt9fHPjOWS1cYud9m+zQApah6N4sfS2djp4nQF0BtK40ussBt4IecfQNwK52fVj7W0o0jLWuyEAgdTT8RdbCqzC0Vwgm/hWp+L+L+DRNBlKwo7m0FMiHpHFXmp65R8PM2EORdHwB17cXTTEKBfWqa/1LAT+NjJRSCMd0EfjqFw0T043FxOIJD9pjcqdrcPpZmAwpDx3Hhh5LLKAT9D6ivDkYQZjgWOMLpdA1VLH4m2E4lf43Lg4O2Smqha6F1GFXtL6KQsIbLjdd1oenZ+kiu1zpUdNEfcirrY8S+clNSrFEVjsbLxHgy4YlbtfeGQ9W+Rj8yVCc5ld0SDcx17eW8t7BwfMUZxhhNPXU1vXQ2k8KqRd/PMtBKJguay01eCOWu3Jp3EphMfGqpKKZ+tS8fNp4IfTFJOJSXjmmqyUH1DU92uZ0u/IKk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU4PR04MB11791.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(7416014)(376014)(7136999003)(11063799006)(56012099003)(11062099010)(18002099003)(22082099003)(6133799003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UUd1ZGhaSXZ0Q0tWdUxiYk5ZVDRkU25vSWQzQWZlaE1UT1prc3ZtZzgraDgy?=
 =?utf-8?B?aGNpcFdONnp1RmFycS90MnNWUmEzQ0pqMGZ6b1IzWFlZSThXQ1lJdGZXNTJ5?=
 =?utf-8?B?OERrRm5FY0MyNmZPSGVEMjlNZTlTZ3IxS1g0cVJ2UzNJNkVjOTJURkhwUG9w?=
 =?utf-8?B?bTBlTDZubDN2K01ISU0rVnZMY09wM3lBeEo3SEJZTmtGMWc1UTRTeEMzdW5T?=
 =?utf-8?B?emRPWVM2RGtXTklNbktuN2lJcXRsTW0rZ0lqWm9IQ1Q2VC9TNEc1blVzUk91?=
 =?utf-8?B?cHFYUVc5MWJOSzRWWTYxTkZIV05aS3FRQVNJZi9SMThGL2x3MVg2b2VjVXF5?=
 =?utf-8?B?cGlLRVVhb1F0Mm42NDh2UG1vVjdzOEgwSTNpWEh1Zy9lRGt4YjAvU3o1ODdk?=
 =?utf-8?B?dFgzMHRNWWZKTnBTRVIyNEkxdk02eGIvOUJibExZZUJIMCtjMkJCbzFkNFJW?=
 =?utf-8?B?SkNZTi9DUm0rdGRXMElzVVBZWEZ3Nm5SOXFudWdMTHdEOWgwVFRYbWhSTkw5?=
 =?utf-8?B?bjhnM1FSN0lhYTNMQTZ4WTEvcGxsOXBYSnFac2t1d3BoaEF4dDBqanp0S0Zz?=
 =?utf-8?B?MXJrOE1tMlduemU0UW5XM1FDR3BEZjZBOTA3Tk9CalZBL08ybE9GMXUxSkZI?=
 =?utf-8?B?aHVhL3pJbUppcUdCSTJId2dybnJZeVZ1Tlp0R1BPWUlEVGZkN3kzZW9EOWVP?=
 =?utf-8?B?UjVhSCt1cXR0VkZHdDhKQWkwaTl3c2I2WkV0eE8yQ3RjNWRteTluMEdGendR?=
 =?utf-8?B?a3ZwVXZxcFg5RzVRK0p6Mjh3eDhmWEtlSlhmR3padjNHUVQ3bzlVeU1qWGRU?=
 =?utf-8?B?bmpaeVQyMmhKMnRFY3c0VDhKZnhjalJpQlBKdEIzVm4rSUw3aXBxeDN2Ykts?=
 =?utf-8?B?SXU0Tk5iTk9XUDd6VVNWSHFZNjJjbFVPc1J4WTdtRkw0QXNtekJRaXJacVNY?=
 =?utf-8?B?azJieE5Pb2JrdmFLZVBtMmtRejlwSVdNMmxtV0JaaTBRQXk1ZTRYR2hPYnZo?=
 =?utf-8?B?UFZyTDBEY2ZnT2pVZWU5S2x0S2owUEh0SW53eVJBRWlJZVpCMDM4UGIxRE1q?=
 =?utf-8?B?RjQwak1aT3ZtZkpBU1ljQWhyRzI1QTZ2ODZKbURjR2RpbkR6L0ppMWtMVG1i?=
 =?utf-8?B?MjlBcUFNVk8xS1RUbWJMQVRjUGg1R3dXU29EdTJvaHpuditNVVgyRGg5RkV2?=
 =?utf-8?B?dUo5Vk5BWlFPdDQvWG5rRy9xQXB3TWxDWm9sckRyYkpaa1owMUhtdVdyNWpJ?=
 =?utf-8?B?aThUTGRMTE4zNytVTzR0VmtGZnFsZjNWNm93a3c1Ry9LbElkc0N1RXNkcFo4?=
 =?utf-8?B?bk9Yd2lqTzc2M0x6c0ZjMWk4RHNuZlFmaURtd2lYamRsT0hJbE5yZFphcEp1?=
 =?utf-8?B?cUtNTHFjeHBTZ1hIUEtmSkZ0QTcxQ1dnTVBIK0N3SW5ZQzFtbHV4RU9tdStO?=
 =?utf-8?B?NzZZRGpLNzhRLytlNjJFcVRjOHVGbmxCam8xM0hXREZIVGFOYVl3dUtZbEpZ?=
 =?utf-8?B?UWFBaUljc28yS04wMjhhWFFQREE3MTFZNmRXREpZVDYrU3BVd3B2WCt0TnhN?=
 =?utf-8?B?UWVYSGRCcjAxQkdwMlB2Y3VrMnVqWXhac0xtd1Mxc21SNGtKWXZ1Vkdzc1hW?=
 =?utf-8?B?R2ZHOE1WaWNCTEF6TDZacEp6dEEwQ3E2VkYvTlVhRnFrai9KcTNBcDl4OUVZ?=
 =?utf-8?B?TElhMWQvb3NOYkE1RWRTZjB6aXc3OU5vWnVSQzd3cjdpUW9UWC9zTUtYU2d3?=
 =?utf-8?B?VGFlYmthZHpFUkdyU1F5WHVuV1ZKUmJHcyswaGc4L0FBWjd3WEdKSGd6eVFS?=
 =?utf-8?B?RmtRWlgrdzdSYmFuVlJnVWMzMmpkNjZiODBiL3dibjFYTGVQcDkyMVBnWjNq?=
 =?utf-8?B?cVVETkFXVE0wSzhSdDlnTmwvRnVhbVVsb3E0eGthRzgxQnFETExpajRxQ2ll?=
 =?utf-8?B?djl4dXhja2VBME02STY1MTU5VWZzVjh6cWM0Q3oydUZTODY5clI4RXNHMXBl?=
 =?utf-8?B?U21ySVlaR21zSllwZlBOVmpGNVljZzZOT2RhY0MvMG1nQ29JWVBjNkk1ZXVj?=
 =?utf-8?B?VzEzUStSczF3WGpxRmZtTURWa1MvME9lbkorUWczcCtRUkVDUU5wNWJNNnVT?=
 =?utf-8?B?ajEyaG5nK2lwaUZLQ3RaVkN2cVprdGFnSFg0WFU3YVcxOUFxZlpvNlprbmxi?=
 =?utf-8?B?aEt5RTJaTjdkbk9sWmVLUXFhMHdrbE9hUk5RNnpBQmJoeWdWZUsxSThuQ0pu?=
 =?utf-8?B?UjdWaE9jaVkwd1lud2xDNk5qZFd1YW41WlBvVm5uWllOTWJWdnBXNkFiTWM4?=
 =?utf-8?B?a1gvbTM3bGFqRElxZm1EM0tMYkUvbGdlR05YalJuMXFOU3ZQY3d3QVVpb0J5?=
 =?utf-8?Q?34GY+qF96TM4CzYmgYxGciUgSMvcO2gutSg+2?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77415684-ae4b-4cab-42a6-08deb74e3f5e
X-MS-Exchange-CrossTenant-AuthSource: DU4PR04MB11791.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 15:33:03.4128
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hUAphdEP07fpZBQSBUPcdym5qcb1N4zwQsliOTJIvyBFEl8w+/Dl0P+vYFb2fHbeQflxAi3RG5cgQnHzMDWjZ6PJUMhz42NgAARAcI1oTdeLjL1EfMltur4M0Dqu3Ozg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB11853
X-Spamd-Result: default: False [0.44 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10679-lists,dmaengine=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[Frank.Li@oss.nxp.com,dmaengine@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:mid,nxp.com:email,NXP1.onmicrosoft.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 760165A9C71
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Frank Li <Frank.Li@nxp.com>

Previously, configuration and preparation required two separate calls. This
works well when configuration is done only once during initialization.

However, in cases where the burst length or source/destination address must
be adjusted for each transfer, calling two functions is verbose and
requires additional locking to ensure both steps complete atomically.

Add a new API dmaengine_prep_config_single() and dmaengine_prep_config_sg()
and callback device_prep_config_sg() that combines configuration and
preparation into a single operation. If the configuration argument is
passed as NULL, fall back to the existing implementation.

Tested-by: Niklas Cassel <cassel@kernel.org>
Acked-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change in v4
- drop context in device_prep_config_sg()

change in v3
- remove Deprecated for callback device_prep_slave_sg().
- Move condition check before sg init.
- split function at return type.
- move safe version to next patch

change in v2
- add () for function
- use short name device_prep_sg(), remove "slave" and "config". the 'slave'
is reduntant. after remove slave, the function name is difference existed
one, so remove _config suffix.
---
 Documentation/driver-api/dmaengine/client.rst |  9 ++++
 include/linux/dmaengine.h                     | 63 +++++++++++++++++++++++----
 2 files changed, 64 insertions(+), 8 deletions(-)

diff --git a/Documentation/driver-api/dmaengine/client.rst b/Documentation/driver-api/dmaengine/client.rst
index d491e385d61a9..5ee5d4a3596dd 100644
--- a/Documentation/driver-api/dmaengine/client.rst
+++ b/Documentation/driver-api/dmaengine/client.rst
@@ -80,6 +80,10 @@ The details of these operations are:
 
   - slave_sg: DMA a list of scatter gather buffers from/to a peripheral
 
+  - config_sg: Similar with slave_sg, just pass down dma_slave_config
+    struct to avoid calling dmaengine_slave_config() every time adjusting the
+    burst length or the FIFO address is needed.
+
   - peripheral_dma_vec: DMA an array of scatter gather buffers from/to a
     peripheral. Similar to slave_sg, but uses an array of dma_vec
     structures instead of a scatterlist.
@@ -106,6 +110,11 @@ The details of these operations are:
 		unsigned int sg_len, enum dma_data_direction direction,
 		unsigned long flags);
 
+     struct dma_async_tx_descriptor *dmaengine_prep_config_sg(
+		struct dma_chan *chan, struct scatterlist *sgl,
+		unsigned int sg_len, enum dma_transfer_direction dir,
+		unsigned long flags, struct dma_slave_config *config);
+
      struct dma_async_tx_descriptor *dmaengine_prep_peripheral_dma_vec(
 		struct dma_chan *chan, const struct dma_vec *vecs,
 		size_t nents, enum dma_data_direction direction,
diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index b3d251c9734e9..defa377d2ef54 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -835,6 +835,7 @@ struct dma_filter {
  *	where the address and size of each segment is located in one entry of
  *	the dma_vec array.
  * @device_prep_slave_sg: prepares a slave dma operation
+ * @device_prep_config_sg: prepares a slave DMA operation with dma_slave_config
  * @device_prep_dma_cyclic: prepare a cyclic dma operation suitable for audio.
  *	The function takes a buffer of size buf_len. The callback function will
  *	be called after period_len bytes have been transferred.
@@ -934,6 +935,10 @@ struct dma_device {
 		struct dma_chan *chan, struct scatterlist *sgl,
 		unsigned int sg_len, enum dma_transfer_direction direction,
 		unsigned long flags, void *context);
+	struct dma_async_tx_descriptor *(*device_prep_config_sg)(
+		struct dma_chan *chan, struct scatterlist *sgl,
+		unsigned int sg_len, enum dma_transfer_direction direction,
+		unsigned long flags, struct dma_slave_config *config);
 	struct dma_async_tx_descriptor *(*device_prep_dma_cyclic)(
 		struct dma_chan *chan, dma_addr_t buf_addr, size_t buf_len,
 		size_t period_len, enum dma_transfer_direction direction,
@@ -974,22 +979,44 @@ static inline bool is_slave_direction(enum dma_transfer_direction direction)
 	       (direction == DMA_DEV_TO_DEV);
 }
 
-static inline struct dma_async_tx_descriptor *dmaengine_prep_slave_single(
-	struct dma_chan *chan, dma_addr_t buf, size_t len,
-	enum dma_transfer_direction dir, unsigned long flags)
+static inline struct dma_async_tx_descriptor *
+dmaengine_prep_config_single(struct dma_chan *chan, dma_addr_t buf, size_t len,
+			     enum dma_transfer_direction dir,
+			     unsigned long flags,
+			     struct dma_slave_config *config)
 {
 	struct scatterlist sg;
+
+	if (!chan || !chan->device)
+		return NULL;
+
 	sg_init_table(&sg, 1);
 	sg_dma_address(&sg) = buf;
 	sg_dma_len(&sg) = len;
 
-	if (!chan || !chan->device || !chan->device->device_prep_slave_sg)
+	if (chan->device->device_prep_config_sg)
+		return chan->device->device_prep_config_sg(chan, &sg, 1, dir,
+							   flags, config);
+
+	if (config)
+		if (dmaengine_slave_config(chan, config))
+			return NULL;
+
+	if (!chan->device->device_prep_slave_sg)
 		return NULL;
 
 	return chan->device->device_prep_slave_sg(chan, &sg, 1,
 						  dir, flags, NULL);
 }
 
+static inline struct dma_async_tx_descriptor *
+dmaengine_prep_slave_single(struct dma_chan *chan, dma_addr_t buf, size_t len,
+			    enum dma_transfer_direction dir,
+			    unsigned long flags)
+{
+	return dmaengine_prep_config_single(chan, buf, len, dir, flags, NULL);
+}
+
 /**
  * dmaengine_prep_peripheral_dma_vec() - Prepare a DMA scatter-gather descriptor
  * @chan: The channel to be used for this descriptor
@@ -1010,17 +1037,37 @@ static inline struct dma_async_tx_descriptor *dmaengine_prep_peripheral_dma_vec(
 							    dir, flags);
 }
 
-static inline struct dma_async_tx_descriptor *dmaengine_prep_slave_sg(
-	struct dma_chan *chan, struct scatterlist *sgl,	unsigned int sg_len,
-	enum dma_transfer_direction dir, unsigned long flags)
+static inline struct dma_async_tx_descriptor *
+dmaengine_prep_config_sg(struct dma_chan *chan, struct scatterlist *sgl,
+			 unsigned int sg_len, enum dma_transfer_direction dir,
+			 unsigned long flags, struct dma_slave_config *config)
 {
-	if (!chan || !chan->device || !chan->device->device_prep_slave_sg)
+	if (!chan || !chan->device)
+		return NULL;
+
+	if (chan->device->device_prep_config_sg)
+		return chan->device->device_prep_config_sg(chan, sgl, sg_len,
+				dir, flags, config);
+
+	if (config)
+		if (dmaengine_slave_config(chan, config))
+			return NULL;
+
+	if (!chan->device->device_prep_slave_sg)
 		return NULL;
 
 	return chan->device->device_prep_slave_sg(chan, sgl, sg_len,
 						  dir, flags, NULL);
 }
 
+static inline struct dma_async_tx_descriptor *
+dmaengine_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
+			unsigned int sg_len, enum dma_transfer_direction dir,
+			unsigned long flags)
+{
+	return dmaengine_prep_config_sg(chan, sgl, sg_len, dir, flags, NULL);
+}
+
 #ifdef CONFIG_RAPIDIO_DMA_ENGINE
 struct rio_dma_ext;
 static inline struct dma_async_tx_descriptor *dmaengine_prep_rio_sg(

-- 
2.43.0


