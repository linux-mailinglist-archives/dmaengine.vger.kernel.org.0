Return-Path: <dmaengine+bounces-8185-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D5586D0C24E
	for <lists+dmaengine@lfdr.de>; Fri, 09 Jan 2026 21:14:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DE42830146CC
	for <lists+dmaengine@lfdr.de>; Fri,  9 Jan 2026 20:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BADC365A1A;
	Fri,  9 Jan 2026 20:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="OB9zUgMi"
X-Original-To: dmaengine@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010045.outbound.protection.outlook.com [52.101.69.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF532EAD0D;
	Fri,  9 Jan 2026 20:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767989633; cv=fail; b=ZUKpWZDTPUwZFvTyYfWTbJnty95RIAP7w941fKyUz1GKlGCnlxIapkD1/DJtwmHtQwvomAJNt1Jcl3ywmD6ZsrPgZzZgbAhjA4psvFTMFJ+PtWikpICeads4dTqaR2LOT17c9VOda6ziWzIichaOq7Jzwa2TlRiVGZUFY+mqKbE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767989633; c=relaxed/simple;
	bh=jYTX0+7snk20wpHBGDPM6IjzAL+qkdCt80cFHX1JYLU=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=XCBHKPhvqnE/GJ9br8KUwk6G2piDyKDnHBvVNez+2+sQ4nPpBmoxcpitHu9DNpDA/CVL1lJc5Hlbyd7DSiPxbrtMB0pyX/A9DA3NEHH8nS9YZdN5sZ5u/u5l9Bdn91umlfyioNWsfbiGfSrCwQoP885wlmAKraxysZieIWfEZUY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=OB9zUgMi; arc=fail smtp.client-ip=52.101.69.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g4NDAoQS2PGZ4WSd2p8brBAZOcQ2xjKlhbpadtq6XYH78rN0yF6lkAneYTZAM2SaZ0wYksFReHkwGWkcDhUgmVUVX0iIWlPqtPOQuPu6vCMgZCko9ZsjkrdSjtKz3c0tybRJzModR9JNHcg8KbuXOEhhkynbb0FS05Gt42WRYe0afGmW3hG61rikHAPNA9EMjfMXKAbBYAtJNVVmKPMvzbqK4A5GXxhXVZp5RY/IGNCzSteK/Wfv3o4ZiRwAlLeRglSnpovUz4yveyFBInQzAAV7W164Bto/OtwQdxkZw060LPo3Sc1b8h+EQLpJVXXMEO+eFVy4a0Q9DZt8J1Dz3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j1Ag0u40UZv5zvNEJfpOmUlmj08gZYFq2eKFgQWI3Rc=;
 b=TnhkEaicyCm7DKyF1ZxWI8/joQNKQD9Zh5CU98+8HnjNjoC/EU+THlPs/8bVLC4moXO2POmhfLnJsusSlwGO9rlw+S+MvFFMpbW3RV9IuIYwMf/idH10dWCz2gpg4D13HM/yBHn4k18H/4pchuVxUKGafx6ryLoQgwid5IHs2Zx3jGPxDMjdWHGkB5vkLhbrBeZqrbAMzIdd/0Jfx3rVajkrj4gNX0bzykWO0OjwRHK2iYeo8OBE18rzGQUfypWC8RIyzeirtmzSbY4PkNSMU0hW5s380TQys2ryoZToOqkVYn8CiFLAU/Bdn68mO0d8RInwA8r5eQfmVOPSa6Ck8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j1Ag0u40UZv5zvNEJfpOmUlmj08gZYFq2eKFgQWI3Rc=;
 b=OB9zUgMiF+jvYweTqISeCeWxrEcsSRgQPAhAXb58uNtmfgC8UJmPqIEpKnlhmGfrnS2Zd7E4CzZmIVm7qbVPG06WqOf2TFmwXjZpTYPc5MdtI4D36cS17nQhywYS/+HeVktOyrW8YtK6X/V3ZjaNeGm1d6DF5f8+KT2plXH3XPCauwN77RDSmLOAJgo6ldjCiSokV3MmkfAy1garc4pmUyPF05zGGdMA3MdW7xLtX3RLwMxn0BKR+mP9u/AgooKXNKKiAdtPidvMkboQWUBYfCuPMTL+w1oLRkAXqc0X9ZAHHMz4Ej6nR8PXeP50WwPp6NEXAjmHLGfs/OKstpPW+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by PAXPR04MB9106.eurprd04.prod.outlook.com (2603:10a6:102:227::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.5; Fri, 9 Jan
 2026 20:13:47 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9478.004; Fri, 9 Jan 2026
 20:13:47 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH RFT 0/5] dmaengine: dw-edma: support dynamtic add link
 entry during dma engine running
Date: Fri, 09 Jan 2026 15:13:24 -0500
Message-Id: <20260109-edma_dymatic-v1-0-9a98c9c98536@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGRhYWkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDI0Mj3dSU3MT4lMrcxJLMZN1EU3MLE+O0NIOUtFQloJaCotS0zAqwcdF
 KQW4hSrG1tQC/ddDzYwAAAA==
X-Change-ID: 20251212-edma_dymatic-a57843ff0dfe
To: Manivannan Sadhasivam <mani@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
 Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>, 
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Christoph Hellwig <hch@lst.de>, 
 Niklas Cassel <cassel@kernel.org>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-nvme@lists.infradead.org, Damien Le Moal <dlemoal@kernel.org>, 
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767989623; l=4960;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=jYTX0+7snk20wpHBGDPM6IjzAL+qkdCt80cFHX1JYLU=;
 b=SSIrYdHmXZNLff6p11sSpwdEyW1cFFskk47SjhhiGA+UHDKOQb8tTGHeJZbHNv7H/cfEPgAFz
 4rYFCHUUPE8C0+KGYjjp+V9lgULMoovWRr+rTyt7PWcru+HnqDKNUc3
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR05CA0073.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::14) To DU2PR04MB8951.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::22)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|PAXPR04MB9106:EE_
X-MS-Office365-Filtering-Correlation-Id: e6394b3f-6255-449d-c18c-08de4fbb98af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|19092799006|7416014|376014|1800799024|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OGtvQnVhMUJJVUJMMUF2TEY4VU50Wi9udHlqcFh5YUU0MysrSnNCYk85NkNz?=
 =?utf-8?B?SmtPbmdnOEkvNlVtTGNDRENvK0dkQ3hmT3AxUmMrK21QQS95d01oQmZ5KzE1?=
 =?utf-8?B?TG9Sd0JzY1dXUDJ4Mk8yTnUyRGExcUYzMGJuRXdrNld1emJ3djV5ZDdocWJn?=
 =?utf-8?B?VUdwUytQMkpNR3FuR1k4WVBRWTlqZjFoSlhWTEptQ24yMFZERlNFTk1FeEkw?=
 =?utf-8?B?SGY3cXV3UjNQcjBiTEI0NlVsOFhybCtkVHFRS2JMdHN3em9HMjVMQXNQT0U1?=
 =?utf-8?B?TjF4cHJpQVNnK0JMQzZXZHlEWkVkbkFwZVhKS1IrQnVhQm5KV1NkQjcvOXVr?=
 =?utf-8?B?M29adldqMHZ6ZDVUNnBTSVJ1YTNuMHZYK3U0MEtGOEZjMUxtUTJzanpuRmU2?=
 =?utf-8?B?ZlJHV2tVT0RSRERaWUdOZE84K0h4cC9uUk5EL3RoSldOckNLUEdmbVBsM2th?=
 =?utf-8?B?b0RESUJYUWxKYmljMEI1aW9EdUVVL3RCS3ljTVNQWjFxVVN4RElKMVVwVERE?=
 =?utf-8?B?dEdyNzdzaVF3bTd4bEh1Y2F1dVhUSGk0TndHdGkzZlEraEZLc2FpaG5hZTNu?=
 =?utf-8?B?WFIvZzdIclVpWG5taVY5Z2RDR1I2NHFvYWZ4MkRkTFI4SmhTWFRqWmJnNXBq?=
 =?utf-8?B?VnVaanFBbzllaXNXMGZ1aHFPd09QYm5CcVJZSXp1cUwrckdyNEx1VWE4Tytq?=
 =?utf-8?B?eVIwLzVFNWF1WVJLd2VKWkVWTFpjWmkwY0dPbUwvT0FIM25mUGh1ZFVTTk1N?=
 =?utf-8?B?TCt1Q1crdTBuWUsxZjdDcGVITzlydXBRTGFBMlNudDJWQkJLNlR1VHJjeWNG?=
 =?utf-8?B?N1UrcnMvQzVDUEx6Q2dtTFcvTVhLQWFhbFQyaUVJQkJEU0JjN0p6UmdyQ0lI?=
 =?utf-8?B?MmdzemRGTVUzNzA3WTAvVTRMN3VvK0dRT1RSMmdLb0t3a25iT2lyVmNNUDI1?=
 =?utf-8?B?QXpCZ2kyTXo5TlE5NUk4alM4NldYQ3hFUFRJdGRLN29IVkdHbU40MndvZk9u?=
 =?utf-8?B?Z3BVUTlBb3o3cDJBT0VsS3dyNFBxb3EvYVFCQjR4dGprR0Q1SnFPcUV2Y1Bq?=
 =?utf-8?B?UDhwRHhBRHpoa09lM1Y3Nk9tSVBFaHBMM1NFdG91T3crSEZLeFhGdDA3RUtW?=
 =?utf-8?B?eE9uc1MxRnpRbThJMUNEekowS2wxK0hIOFpIdyszNllTUjI5MUFCZE9WSWgz?=
 =?utf-8?B?aHprdGh1YlJjS1hoUERoUzhOL29BZ0tUendid2FEOWl3dExOOFBkVUdGWnRB?=
 =?utf-8?B?UmFTblp6WVVNRUpJZXVmdDBadXdMaXgxbWZsaVRQVUJvejZ6MUxvZnRQSjBj?=
 =?utf-8?B?TVZKckhreGVRdEM4R2FFNEpnZGRwVEJkNFJ5U0x5TEhQWWs2b3dJVVJFVXd1?=
 =?utf-8?B?eU8yQWtZN3hFV2Vpcm45TzFHZVU2eUx5N0JkbHN5T2JhZ1FFYTFmRHo0WUI1?=
 =?utf-8?B?RzRVZk5nam9GaWtVaVAwbk9sZlVMejR4ODkrcGVoeWxmUW1Ed3dPUmtncEN2?=
 =?utf-8?B?M0Zwc1NCMHpZdkljWTVYU1E3b2s4SFp5RWxYV2k5WG0zL2NndmJBT2NlbEN3?=
 =?utf-8?B?czh6V21wZ2NsUXRZZmg3TkpCbEJETGZYN1h5U3I5dVF5Zkw4YzdnUVZZcTI2?=
 =?utf-8?B?TFVhL05teWxBYldROHdoUUxxT2hJd0dGV2VUTDh1MWpUYWhMdlBCL3k0S0g0?=
 =?utf-8?B?b083dkxIVXFmUXF2ZTUxc3BGS1FPOFJJWEV5Q3F6WDVZcWlseWdScVNvTVhO?=
 =?utf-8?B?OVVnZHZpa0VObGluVmhlcXpCWmxJN3drMFl1M2JVVTluaHFuenREZmlrWld1?=
 =?utf-8?B?R2tpbUppVmFXSUltMER2aERnSXFreE1CaFNWMnZETHNQRmV2ZWV2cVJTTGI1?=
 =?utf-8?B?RitSejRKRlJ0dDREUGRUbno5M2FoQTNLeURHR3hvQjNHbG52QkpLaVpRcHB6?=
 =?utf-8?B?TkVUY2NSSEdRMno4bVNkb3FiV2Y2SzZWUkQxWlBMT2V4RlBneXhFVW43RVRO?=
 =?utf-8?B?dVd0dDMrSTQ4VjlYRzZGYUpsOWVhTVlkYWJ3R3lpczhmblJBaDZLNHhxK1hV?=
 =?utf-8?B?TERSOHpOY2NkbWZQL3pqK3ZNK3BlWDFuTm42MTdwaGxTZ0prUWRDZ2N6UGRl?=
 =?utf-8?Q?pcwc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(19092799006)(7416014)(376014)(1800799024)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MkxiUGVZMitXVE5wRWZvbWw0UTJ5ZE5YaWlsSGdHaG5BR1hxaks2SExDb2FL?=
 =?utf-8?B?cHZQelJlWEg3eVppZEFkL0doLzAveW9PVUwrNXNlNjJiK2JWaFVRUjVXMXBn?=
 =?utf-8?B?RXh2MVNUd3piWkJRa3lLTVpzNG9Ibk9ETy9tU0VudHE3cnFwbWlNajNNYXRi?=
 =?utf-8?B?NkVPcmdiRUpScFl4d1NKNC9ZclhXNUNTZDh3QmhNSHM3U0xRNFVBODNCZTBa?=
 =?utf-8?B?enZaZHV1VEgvT2RZclU1Z1FRUDQrMWxjQzFYT2tIc1dQL3NuSG04NlRQUDNm?=
 =?utf-8?B?NTE5Tyt4aHpmNG5uZ1BiNFlIbjNBbU1LTUwyRTd0dWZtZHRPZXdMbUtRUjJi?=
 =?utf-8?B?eEk2UUk1U2xsL1hjdDVFRGlPSk9WV1lIaHpzZlpaa3d4UmVSUEJqcUc5b1NJ?=
 =?utf-8?B?aGxlb0pLdU9sTmJ4bk80ZTVCeWxzQ3Y5ak9MaW5hYTBXS09BRkVmNTlMK1E0?=
 =?utf-8?B?eUN5aUJsWWlHT3Myc0tHWklJTWE2bUdjVHhJSEdmOEpRUGNFakE1dWZyNUhs?=
 =?utf-8?B?VzN4U2F2Y2FrTnJVcW9JRERrSVI4VTJqbnhrc25LaVdDN1RJSCtBc1BpY3dp?=
 =?utf-8?B?RUo1V0pvbEZ0VWtPQlA1b1BWc01ZWnVTYlQreDREMVpleFFjMXdoampPQ2hk?=
 =?utf-8?B?aE9zOW9GdlhtZEY3aEtRd1ZSWGIyWGxHV1dZYktaMWU0Nmd2Ujl6WDNoRmdz?=
 =?utf-8?B?Z0U2akxSRUUvTzhBQzd3aGswcytLLzVrQlVua25CbnB0cGQ5a2NiRGY0bFdj?=
 =?utf-8?B?c0I3bGpmUlNHeXdBVXRGM0F3NGJYeVFuL1VLQ2hMb0JFbDVjRnY1MkZDZU9p?=
 =?utf-8?B?M096OG1LUERLMjgwcitEUVZEaWNtNVRGaEoxUkluS3VYSWxLRi9icEFlUzRM?=
 =?utf-8?B?d0JIVXcvQXFKbzB3elJBVlRPejU1d1JDMjFja1paK2xyTURpOVg5YS9IMFYw?=
 =?utf-8?B?Mi96MjlXWmw1YjVoWW0xUnFiODlJcFNXQlo1eW1zWDRDL2VybU9rMjIzcmdK?=
 =?utf-8?B?MSs4d09zVlhDREZSVHpWaURuSGdqZFdRVHUyb3A2K1FkRnVkTkZDREl2TWFS?=
 =?utf-8?B?ZjJaZGFQcFJqMXpERzZJbTlvb00wVS8vaWc1VXpSYkkwQzl1TVZjSHlLeXZZ?=
 =?utf-8?B?b2xGT0ZmNjZvdWw2N3BpeWlvZ2ZhSGloZi9ueWJ0dmF2a0Y0TlYrTER1T3BO?=
 =?utf-8?B?UFF3SWxpMkk3QllEMWpSN0UwdDNzREVBa29TaU9Eby81N1gwVkNyMUsvT0RD?=
 =?utf-8?B?WDJIcXMxZXpSUFZJVitEV25oY3pkNnB5N2MwN1lrakJjbGV2Zm5DL21xVi9s?=
 =?utf-8?B?TWZDakdka2t3YnpSQmw1NDRuZ2RBOXE3OHg1K2V5WkplZ25ndmd0ZTJlRFFH?=
 =?utf-8?B?bHlQVlNkY2lGbW9UQmZOdzZmK1BSYTBqdGMvZ0pLM0piWFRJYUJNTFM3N1FU?=
 =?utf-8?B?YWttckR2OVlqeWhQU1F5S1Y2YzVoZVFnWWU0bnhrMWRoTEVxYXpFdWdqZlZu?=
 =?utf-8?B?RUlrQjhxdjhPUEhZWEVtTk5zaUhUeTZGMkFDWlJxNnNkSzdxZHRIUzA4SGU3?=
 =?utf-8?B?Ny9Qak1yYjRPR2o1K3l1TnNjNzRUekVJajdSejVKbmRRSXpyQkpVQXRPV0hO?=
 =?utf-8?B?a0VaN0tvVjAwMldxNW1YZWdsbE5WbmlHK3RXTHFrbm5LRWxrclNoV1hrNmtq?=
 =?utf-8?B?cSs1N0Z3UGxoUWxwaWZmWEtoWVowWHR3TWg2Z3hTV0pjRFdpRUVpZ0VZS01r?=
 =?utf-8?B?N2w3a1R6Y0tUN1dVeFh3UVlrL1AwUjRZY2JwekNEQ2NMR3VIdzIrUjNxU1Z4?=
 =?utf-8?B?Wll5TFlCQkp6eE10cXZsUXM4V2RUNFJzaXcyT3lyWmZ5Q3BEaWRyeVI2cnpK?=
 =?utf-8?B?MFZvblV6T051T3o4T1BXQmhKNzd0dVI4RGRCdFQyTkRUaXI1Ly9kTGhqSEo4?=
 =?utf-8?B?MC9iUm1UbHNJVFZDaWNtM21QNE9sNzJ3ZWtvOVNkdXNSK0NGWnZKU0pNbE9z?=
 =?utf-8?B?YWRzRkNvM2thRWpnWWhwd2VGd2EvWHBZbnI1ckczUENjMElSM3hPb0tEV0lC?=
 =?utf-8?B?aXJJUTk3MXdRNWNDUVdQaElXRkUyQWRMYVlsU3p5c2xwVGlXd3BiWGpJM04z?=
 =?utf-8?B?YWFFM1lTWitjRUViMkF6SUhYS1Iyc3hTNHMvL1c4US9hMUZIMVZnRVpCTS9l?=
 =?utf-8?B?MVdPK2VmcGR6VllydEUzbFltdEhycXpUZ2J3bDNSa3JTeE5DakZtUHRScndy?=
 =?utf-8?B?TXY5dVNsYkhScUpDZ1hCVDU1Tm5XeEtuQXplaU41WEVZODhlRUV1d2s2Y2xw?=
 =?utf-8?Q?06SbvXZp9bxnIp6xDD?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6394b3f-6255-449d-c18c-08de4fbb98af
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2026 20:13:47.5421
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hr+R1uH7l2z0ZPG6Qzypl5TmzRymZB2cF5eZiv66/X0G/VdlRHTvVsBROGkCaogc/SDjEg8B/peI7JE419l8OA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9106

Patch depend on
https://lore.kernel.org/imx/20260109-edma_ll-v2-0-5c0b27b2c664@nxp.com/T/#t

Only test eDMA, have not tested HDMA.
Corn case have not tested, such as pause/resume transfer.

Before

  Rnd read,    4KB,  QD=1, 1 job :  IOPS=6780, BW=26.5MiB/s (27.8MB/s)
  Rnd read,    4KB, QD=32, 1 job :  IOPS=28.6k, BW=112MiB/s (117MB/s)
  Rnd read,    4KB, QD=32, 4 jobs:  IOPS=33.4k, BW=130MiB/s (137MB/s)
  Rnd read,  128KB,  QD=1, 1 job :  IOPS=1188, BW=149MiB/s (156MB/s)
  Rnd read,  128KB, QD=32, 1 job :  IOPS=1440, BW=180MiB/s (189MB/s)
  Rnd read,  128KB, QD=32, 4 jobs:  IOPS=1282, BW=160MiB/s (168MB/s)
  Rnd read,  512KB,  QD=1, 1 job :  IOPS=254, BW=127MiB/s (134MB/s)
  Rnd read,  512KB, QD=32, 1 job :  IOPS=354, BW=177MiB/s (186MB/s)
  Rnd read,  512KB, QD=32, 4 jobs:  IOPS=388, BW=194MiB/s (204MB/s)
  Rnd write,   4KB,  QD=1, 1 job :  IOPS=6282, BW=24.5MiB/s (25.7MB/s)
  Rnd write,   4KB, QD=32, 1 job :  IOPS=24.9k, BW=97.5MiB/s (102MB/s)
  Rnd write,   4KB, QD=32, 4 jobs:  IOPS=27.4k, BW=107MiB/s (112MB/s)
  Rnd write, 128KB,  QD=1, 1 job :  IOPS=1098, BW=137MiB/s (144MB/s)
  Rnd write, 128KB, QD=32, 1 job :  IOPS=1195, BW=149MiB/s (157MB/s)
  Rnd write, 128KB, QD=32, 4 jobs:  IOPS=1120, BW=140MiB/s (147MB/s)
  Seq read,  128KB,  QD=1, 1 job :  IOPS=936, BW=117MiB/s (123MB/s)
  Seq read,  128KB, QD=32, 1 job :  IOPS=1218, BW=152MiB/s (160MB/s)
  Seq read,  512KB,  QD=1, 1 job :  IOPS=301, BW=151MiB/s (158MB/s)
  Seq read,  512KB, QD=32, 1 job :  IOPS=360, BW=180MiB/s (189MB/s)
  Seq read,    1MB, QD=32, 1 job :  IOPS=193, BW=194MiB/s (203MB/s)
  Seq write, 128KB,  QD=1, 1 job :  IOPS=796, BW=99.5MiB/s (104MB/s)
  Seq write, 128KB, QD=32, 1 job :  IOPS=1019, BW=127MiB/s (134MB/s)
  Seq write, 512KB,  QD=1, 1 job :  IOPS=213, BW=107MiB/s (112MB/s)
  Seq write, 512KB, QD=32, 1 job :  IOPS=273, BW=137MiB/s (143MB/s)
  Seq write,   1MB, QD=32, 1 job :  IOPS=168, BW=168MiB/s (177MB/s)
  Rnd rdwr, 4K..1MB, QD=8, 4 jobs:  IOPS=255, BW=128MiB/s (134MB/s)
   IOPS=266, BW=135MiB/s (141MB/s)

After

  Rnd read,    4KB,  QD=1, 1 job :  IOPS=6148, BW=24.0MiB/s (25.2MB/s)
  Rnd read,    4KB, QD=32, 1 job :  IOPS=29.4k, BW=115MiB/s (121MB/s)
  Rnd read,    4KB, QD=32, 4 jobs:  IOPS=38.8k, BW=151MiB/s (159MB/s)
  Rnd read,  128KB,  QD=1, 1 job :  IOPS=859, BW=107MiB/s (113MB/s)
  Rnd read,  128KB, QD=32, 1 job :  IOPS=1504, BW=188MiB/s (197MB/s)
  Rnd read,  128KB, QD=32, 4 jobs:  IOPS=1531, BW=191MiB/s (201MB/s)
  Rnd read,  512KB,  QD=1, 1 job :  IOPS=238, BW=119MiB/s (125MB/s)
  Rnd read,  512KB, QD=32, 1 job :  IOPS=390, BW=195MiB/s (205MB/s)
  Rnd read,  512KB, QD=32, 4 jobs:  IOPS=404, BW=202MiB/s (212MB/s)
  Rnd write,   4KB,  QD=1, 1 job :  IOPS=5801, BW=22.7MiB/s (23.8MB/s)
  Rnd write,   4KB, QD=32, 1 job :  IOPS=24.7k, BW=96.6MiB/s (101MB/s)
  Rnd write,   4KB, QD=32, 4 jobs:  IOPS=32.7k, BW=128MiB/s (134MB/s)
  Rnd write, 128KB,  QD=1, 1 job :  IOPS=744, BW=93.1MiB/s (97.6MB/s)
  Rnd write, 128KB, QD=32, 1 job :  IOPS=1278, BW=160MiB/s (168MB/s)
  Rnd write, 128KB, QD=32, 4 jobs:  IOPS=1278, BW=160MiB/s (168MB/s)
  Seq read,  128KB,  QD=1, 1 job :  IOPS=853, BW=107MiB/s (112MB/s)
  Seq read,  128KB, QD=32, 1 job :  IOPS=1511, BW=189MiB/s (198MB/s)
  Seq read,  512KB,  QD=1, 1 job :  IOPS=240, BW=120MiB/s (126MB/s)
  Seq read,  512KB, QD=32, 1 job :  IOPS=386, BW=193MiB/s (203MB/s)
  Seq read,    1MB, QD=32, 1 job :  IOPS=200, BW=201MiB/s (211MB/s)
  Seq write, 128KB,  QD=1, 1 job :  IOPS=749, BW=93.7MiB/s (98.3MB/s)
  Seq write, 128KB, QD=32, 1 job :  IOPS=1266, BW=158MiB/s (166MB/s)
  Seq write, 512KB,  QD=1, 1 job :  IOPS=198, BW=99.0MiB/s (104MB/s)
  Seq write, 512KB, QD=32, 1 job :  IOPS=352, BW=176MiB/s (185MB/s)
  Seq write,   1MB, QD=32, 1 job :  IOPS=184, BW=184MiB/s (193MB/s)
  Rnd rdwr, 4K..1MB, QD=8, 4 jobs:  IOPS=287, BW=145MiB/s (152MB/s)
 IOPS=299, BW=149MiB/s (156MB/s)

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Frank Li (5):
      dmaengine: dw-edma: Add dw_edma_core_ll_cur_idx() to get completed link entry pos
      dmaengine: dw-edma: Move dw_hdma_set_callback_result() up
      dmaengine: dw-edma: Make DMA link list work as a circular buffer
      dmaengine: dw-edma: Dynamitc append new request during dmaengine running
      dmaengine: dw-edma: Add trace support

 drivers/dma/dw-edma/Makefile          |   3 +
 drivers/dma/dw-edma/dw-edma-core.c    | 215 ++++++++++++++++++++++++----------
 drivers/dma/dw-edma/dw-edma-core.h    |  42 ++++++-
 drivers/dma/dw-edma/dw-edma-trace.c   |   4 +
 drivers/dma/dw-edma/dw-edma-trace.h   | 150 ++++++++++++++++++++++++
 drivers/dma/dw-edma/dw-edma-v0-core.c |  39 +++++-
 drivers/dma/dw-edma/dw-hdma-v0-core.c |  17 +++
 7 files changed, 409 insertions(+), 61 deletions(-)
---
base-commit: 020f6d8442f35105660a29d0d236d3f8650c8142
change-id: 20251212-edma_dymatic-a57843ff0dfe

Best regards,
--
Frank Li <Frank.Li@nxp.com>


