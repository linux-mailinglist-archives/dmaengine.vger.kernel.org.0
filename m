Return-Path: <dmaengine+bounces-7600-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AC79BCB9F21
	for <lists+dmaengine@lfdr.de>; Fri, 12 Dec 2025 23:31:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0A0B03135CA3
	for <lists+dmaengine@lfdr.de>; Fri, 12 Dec 2025 22:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2C2431352C;
	Fri, 12 Dec 2025 22:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="NHvUre2S"
X-Original-To: dmaengine@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013044.outbound.protection.outlook.com [52.101.72.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9813128BA;
	Fri, 12 Dec 2025 22:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765578395; cv=fail; b=IQHw/0JnmYEZdxoGlIcTxkFq2nKJFXi9EzImXOlFGoQqZDBiO7N4lI4O5FQVu+8gCZX8sDHpdXahoQscMOy9tACbHRkHemb5Gl3V5SC83XAYDDCVZZiOp7oKS3/EQ1NhsNrrKEWYBze407e42yto5QIVS6u2xFEas7cUw1aZUDk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765578395; c=relaxed/simple;
	bh=y6Uq9Bg4Xe6dbOedWWACzpCyNK2pRTm/Lx8Uk7Dfiu0=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=BIPrhDfXyXyDDyAYi8H1gjNEA4RuraWLAlBkxtk7sU1fiWVfMBzH4QUSMQ2ll7zrtTQD5I3azrW8R6OgAori7mbnxC0L4unOBE+4tLwEjg3s+vZ3Ezn/lUTPciXcLkf9NwOXnlboeKQIezXvKtlsRygyun9+kpeKJ+V2BXO968g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=NHvUre2S; arc=fail smtp.client-ip=52.101.72.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wFJVCb2MIdQbQY8vrK3DnHlF0z8ejmkCXkwe8twDprm8lMxp2O2pvQitrJCduqxjlyt3mwijd++GnvxEHUShN263kX3eE19PCszR4DVGaCtmWiVcK851ZjhP1U3aUcsjrxH3chYSVgogWBVdOLc4NPZWT2rL/9J31iQonESvnsjm1AVFn+EwVeyb3dcd95TNfUIWIGzEqp3+cuCADOJKRZLQaGL5NZaYkP9q15j6NShDVqhQ+VC35HFEmVF6CSAh6I2aK+woGY6kpqDHWlBjz5e6uh4zdmSwvcyIP3Ps0bhGZc03Tcv4N5hxn8LqREetYIHgGzPX2fnCnAo9tQMkWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=weoozgR8Q9caQC7Tqr96ledYb6mW1MxU9Yf2hcUyoh4=;
 b=ioI2oQkbhK0gtsXL+KM0Uoof73zvznLoK+5v4CJtFr3Y4ZbjDHNBsOVXwuyI6LoyvJJJg2D2RuvGDpqATn1QzTpp36BeiTwU9UxZehA/Mj7lAEspOL2y58aJ/2kzvzy6FGqvarSmuB8NdY1kNvtxOyzdP1tsWarA+tmaY0k+xGQMD3n+Qu1oR8RxedRxlbWPmqLkz3cq3dWY3kdkdBxc3pRtZilO4nKaeiLMaryqSlHv1uif3BPdVCnVZqnvcSx7lnlMrv7nAEUooUCXSLf1j0LTsf/wZ8qehBqbubpUKIVr1fJU4c99GScDVntp/ipa1TrUYq5P0MtPwZUlc9r4iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=weoozgR8Q9caQC7Tqr96ledYb6mW1MxU9Yf2hcUyoh4=;
 b=NHvUre2SIG6kzDm53LAVzgleg9yGARzn5bXqp91hv8z1xreurR8EvNEXdTyvIkMV8/XD4nW+ECoTZPdZYpwWro6nYp0TeBFIS198wezQsi+VoilErfF5UI084rdQw3iVoSmDUZDuOBiXaS9kwzwsQ8tqiXO0V01aQBKzavbcFlYN9dewnReCXMhzsqNuVf5puECY3NIlixyPJZ9zdcE/bfs43Lwmgb2xzhHXsUOomsx06U061j1ddcwqZKdxKixYCFGlev5U7u1yTXnu1ebrhjxw+a/e4bJfSN2u2kyw1jLgm090SMlgIfzBASs/eD3lrcqlRRLqqktTM9WJxk4msg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by GV1PR04MB9053.eurprd04.prod.outlook.com (2603:10a6:150:1c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.12; Fri, 12 Dec
 2025 22:25:38 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9412.011; Fri, 12 Dec 2025
 22:25:38 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Fri, 12 Dec 2025 17:24:48 -0500
Subject: [PATCH 09/11] dmaengine: dw-edma: Use common dw_edma_core_start()
 for both edma and hdmi
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251212-edma_ll-v1-9-fc863d9f5ca3@nxp.com>
References: <20251212-edma_ll-v1-0-fc863d9f5ca3@nxp.com>
In-Reply-To: <20251212-edma_ll-v1-0-fc863d9f5ca3@nxp.com>
To: Manivannan Sadhasivam <mani@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
 Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>, 
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Christoph Hellwig <hch@lst.de>, 
 Niklas Cassel <cassel@kernel.org>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-nvme@lists.infradead.org, imx@lists.linux.dev, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1765578298; l=7897;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=y6Uq9Bg4Xe6dbOedWWACzpCyNK2pRTm/Lx8Uk7Dfiu0=;
 b=gDi17abJx2W9s2C/mCLMVXAJhfVcqLxE7x19o0s1Q+q5fqAkUeBd7c467O40AowTfy8aUn4vS
 UqXGhve4ilUB4eACckzs6QpnUPRUUw1F8E5tcPRra7F/Vtrk/1FilTM
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY5PR20CA0025.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::38) To DU2PR04MB8951.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::22)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|GV1PR04MB9053:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cc658ef-951e-49fd-0b67-08de39cd607d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|376014|7416014|52116014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MTIwa2I4aXBwcFhpM0E2TGhxYWpTMFI5UmcxVUVhZExJaWFDWUNxZU42V0F5?=
 =?utf-8?B?N20vZGtnMkxPcDVic2xlU3E5b1lkMlpQZFhteVVCZDlXQVpJYTBtVG1Kdkhy?=
 =?utf-8?B?UEhNZXNhT096d2tUL3p0MUFQTHNZUVhEdzc3ZHIrSHdWRSt5TnlQMUlTRG8w?=
 =?utf-8?B?d3pTN2Q3TlZ4cElMS25HamswUkcwS0lCd2hMZjlTZytkMGFDODVuaEtaMyto?=
 =?utf-8?B?QityOERDb1R3OUNKU3phWEJGazFGQmNmR2RSY0xqdU04OVF3Ry8zaVVvY2F2?=
 =?utf-8?B?WmVMYjNESGl1Z3BTSUJYcUExQWtUQUZkWHV2VlZHQXY2L2JONkhGR3pPUEI2?=
 =?utf-8?B?SHQzQkNqWjZMT3dMWDhKRlUzS0RXeHFzS2QwQy9JZ2RSVU1QVjFVTUVJK29x?=
 =?utf-8?B?MkNxVnpyVjVBT09xVDRKV0pLWmthb2FJejV3VE9PeUpOdWZLMEthNDlZM0Fs?=
 =?utf-8?B?YlNzYUpwZHdaTktoL1I5OUJvOFF1cXdTMTdWTWpRRU5rM2oxa2ZvbEd2Wmtk?=
 =?utf-8?B?VWhTQjFKaURUTGF5L0NoTUhNZklvU3NRek5Ta1NadUNpYjN2dFNQbzJUTVJN?=
 =?utf-8?B?NWNFeEdaQUdYSmQ4dTZLQ1lHbFdtZEYxRzE3UEIvSjZsZy9UbndXY1ZUY1Ny?=
 =?utf-8?B?enJUTnRtdmlES0RnQlpZejl2Uk5jK3l6akxIZGoyTnNZeVV0MmhoSmhKY3Mr?=
 =?utf-8?B?K1IwZVJOZlR5NDBuQnZoRGpHZEhwb2Z6ajlYa2wybzYrc0Q4U0JJRWF6TlBI?=
 =?utf-8?B?TnNpMUt4ZGtmd3VLMkdVMVYvZFR6dWRjUDJEbXNrOC9HTGNKRnIvY1VCTWM5?=
 =?utf-8?B?YnZTei84ZkFsV1ZVMWRhVFNhcEV3TWttQ0VOcEVCWVpGOHhjRmh1ME13dkJR?=
 =?utf-8?B?OFRZMzJaT29jMkxOTlMrb21xakpvclRjK3dIbktIUng3S1JwaFJHSjZYUlly?=
 =?utf-8?B?ekViNkk5d1ZqVTI0SDhDOWY0NkZPMUE5TmZIRndhY04vK2lyQ0tBemtqTEhF?=
 =?utf-8?B?b2pUUmZoV0JQaFBVRDlYbndyL2pIRFdFdHVzVjdpU2ZFOThzMFFHaXYrSDZQ?=
 =?utf-8?B?NDdZZVppM0ovdUZuOWFYZ1g2UnhJKy9IbG90eVY5UlpnRXl6QVJPV1Z0YW9B?=
 =?utf-8?B?T0FSVk5uSnh1K2oxR2IyY0ZSV09HTGZwSFhtbkFScCsvb3lNUWw0aTd3R2d0?=
 =?utf-8?B?eEZMWnRwNnBoYzNsWXFUQzJ2UHJWZlhFMVhDQ2d3QnlpVDBpeXBMVnVkWnFQ?=
 =?utf-8?B?OVVGTFRFU3g4MDY1d1dJYkZweHQyZ05qVUY5RmZJNlRrL3NmOUw1SzNzamRr?=
 =?utf-8?B?ajE4MVJzdzJ0Ym9PdUthZDJpemlQRXBuV20vZGR2V21NT0p3ekJGWklUekto?=
 =?utf-8?B?MjE0Wm1NZVFnTmY3MW5sS2RhWWZITERxdm1yckkwL0JIeWpwMnNBcTNPcTVz?=
 =?utf-8?B?a0VoYzVqQkFJcmFJS05CWFE5K3dVM1V1MWEwYzZRM2lkSEl5SWt4THJQNUZS?=
 =?utf-8?B?MisrRDgvSXhZZ054SHc2TGt0dnlId0kydHpKYUxZOTdVL2JMVUN0V3daUUdt?=
 =?utf-8?B?cXZGSE1KZXJCTkxQMHhLVVhqeDJmODJjeHJvUmZhSnA0RUJkOXAybElwazJx?=
 =?utf-8?B?djhWRC9TblFrcThXRG1BZGFhYTNqUU1oREZQeVphenF0ZTF1NVZFZEhSaytX?=
 =?utf-8?B?dU1RWjM1dXpRSTRCVDc4ZjBrMWU5emZ5VXhFejBnR0wzamlrRHJ4cmVzMVda?=
 =?utf-8?B?QUNNRytrTi9RZUx4VFA3aEczY3gvd0pXdThtUnBCeFFrTTZnbUYvV3huUUFr?=
 =?utf-8?B?Vmw4RWlvK1Jlc09La2o4RlpQVE1TVmVOTnpGY01oaUtLRnhlQXptMmJUdGwv?=
 =?utf-8?B?Y3o4d0tOemZETEd0RHVzZWt1WnFtMkJnaUp3a1phR054TEJITy9lWW5ielZr?=
 =?utf-8?B?NFVDZGVvem5Sc3BYb0daUWt6TzlzUzFBL0s3MHROK21iM0Fkb2NKMS93dkJ5?=
 =?utf-8?B?ZkdwUUdNR3d1clFROTBSa2VNSTBraW1uY2dVQTFnUDlmYzVGOWoxVlU2Vlgy?=
 =?utf-8?B?QnpMNEtJM1plTWc3OXNNQVJ5K29iZ0VFM3FBZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(376014)(7416014)(52116014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WUlNVXpKSjk5a0NEeEtrWU8wNTZTQjlabS9KY0ZOQmxsdjQxTzZHNmN4UkRn?=
 =?utf-8?B?anBpVGRYQmRNbkZ1eTZqYXJ3K1dRQk9GVkJTUDNVaDd5Y3hZQ1lheGJMOGdK?=
 =?utf-8?B?K3RNUENRbU1DRlBET3k5V3pla1ZxTFBYc1J3Z2ZWMlVEYytNN2ZrS1pYdUMx?=
 =?utf-8?B?TmQzZ3lXY09HQXJ6Rk8xK3NZeHJQN2ZhTGpmWWpNUlg3cmliSEkwSlpWOTZY?=
 =?utf-8?B?cEVvQzB0NWI1SUpJVE40c2JCOHNCNTdCMlJDREpsV1VQRE9YQXhvbnJRaEh0?=
 =?utf-8?B?eHpycDh1azA3bGc1a1RVR0lEaUJLS2w2SXBEbWVnZy9WUldjdEtxMmpoNHh1?=
 =?utf-8?B?UFo4VnNHOXpUYkk0eDVKR2JBaFluRVFsZzRBeE1ET1JCMGZhYkZQUldvY1V0?=
 =?utf-8?B?dXVadVZXRGRpODhtTE04T2JBZEpqcXdXTStZWU9PUHByelBxdzNLUWJoRjNn?=
 =?utf-8?B?eHV1UGJzODVkcmo0OHd3d1hRUjIxVUZMWE5reEU2OXlLZjVXaHUzMlpFT3Nh?=
 =?utf-8?B?Z1dvZVl1aU1BQXh5K0lBOFpPaG5BMm1NdEd0VHAwcGRwSDJHR0xva1c2ZkRa?=
 =?utf-8?B?MEZtdCtYUFRGVm10amVVRU9iWXVJOSs0My82Ui9uWHAxREY2endkK3VUY3d2?=
 =?utf-8?B?dG1yeFdybFlKeHV3OFE3RUNNZ2J2YWN1VC90Wm5EdUJ5UHVTWjNUelVGSGtz?=
 =?utf-8?B?L0tuTnUvV3lwOU9NdWtpQU9McjdpVGxoUnRKVjlpUFJoeE9xMnYvbGxiZmtO?=
 =?utf-8?B?MkhleW5JdzhMS0dXUDJYQTVsT1R3a0ZvT3l3Z09FS2JTZ3hOOXJHTmU1Ym93?=
 =?utf-8?B?T0UwSVdld25yc0V4cmd4d0kxcFczODlmZ2NtbmRlT3dyc21lSkxyRy91MDdn?=
 =?utf-8?B?RjhBYWpsdDNXMW9zakZTaDJ0QnJBc0hnSVdadWZXajZBU1B5SGtDRjExaEJy?=
 =?utf-8?B?cE45cjZjVmlWUXVPbWpkR3pvQWFQVlhpNkJiU2JudzdSNC9HYVBvZ1NiYUM5?=
 =?utf-8?B?cjlpUlRpYmczTVVTTTNibzZOWU8vOTFzTlJnVVUvbjIwUE9QZWpnZEVxWGpy?=
 =?utf-8?B?SU9aZUthL1dySFNpaXZyUEk1VW9PbU1kVW9UNGlKRElsVjlYTEN4NkQyRzJp?=
 =?utf-8?B?eXR4VXoxeStvcTl1YzRKUkNOYm9PZUZ3dUF6emt1dE4zeEMwdnNlVWdsemtt?=
 =?utf-8?B?dzBPUnM0SVcrUGtNUlIzZXJhcUdnRFVlOW1YUThsYTZFLytqM1UzdUVGMXdj?=
 =?utf-8?B?aWV4ZmQ1NXlTZnFZT04vSzRESVBCZGNmNll1QmtQQWNPYzIrZkJEdndCZU80?=
 =?utf-8?B?cTdzc1hQc2xjZzFJMGZZbUpoWUtVcUZ5UDVMUFZiSGo0akZGVmZqS1BZNGpj?=
 =?utf-8?B?c3ZnTDRLYVFFMGgrbmRjUGZ1dWZVL1lhSTV2d1lPOC9tSmtBQ2ZWTkg0STZS?=
 =?utf-8?B?OVA2eEZlMFJWRlNBNnFEYmp5bzVGSi93YXphQnlPc2ZDeVpCbmhoMGZXSDBp?=
 =?utf-8?B?NXBqVElvcGdleE9ubDQ0U2xxZVVaUUcrUWxlZ0RaUEdVR1FNUGIyVFZHVXpD?=
 =?utf-8?B?Ulp1YW1wMDVldkZoK1grbElscm5TbGZoS3ZIUXZhR2hrUzJ5NmNzZ0FUM3J6?=
 =?utf-8?B?UGk5UVFhQXpHaWYycHZJa2JVSW1CejV0cHkwZlB5QUU2Si8yVFp5clMvZkZo?=
 =?utf-8?B?cGNOMC9JZ3lndmd4NU1OdnVWeU96K0hXUjhzR0E0SS9lSTE1ZFJSMGtZNXN0?=
 =?utf-8?B?M2FrRGZoUGg3WHR2MHRDTlk4MGp3V1ZJT3JFUHM3d1NocjZySVNnZlNuZHht?=
 =?utf-8?B?N25uZFZPU1hZOFJtQmVadWZJaUhyUytFTkRPWmNwM3RpSU9pbVo2Mm9qN2NM?=
 =?utf-8?B?eUQ5a1VSMnRLSnkzemljZkVHajkwR1BTNUpEdGl2Q0QvYlNZczhrUnRvM2Rm?=
 =?utf-8?B?MmRKRGlqcUt0bWt6RGM4djBRZzJ1dFc0L2hWRWRPYWJrSWFDZ2dQQXB4VGF2?=
 =?utf-8?B?MC91VmRHaGgxdVB4c1hCK3g3bU1tR2tyWWZrenpnRTBpa2M5Y3RZazZ4TXhm?=
 =?utf-8?B?TzZDYmE5dnZrN3d5RnNsTytSeUVpVWt4djE3alA5c3lyWS9NMEc4emtNR21q?=
 =?utf-8?Q?uvUw=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cc658ef-951e-49fd-0b67-08de39cd607d
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2025 22:25:38.4026
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9tWuXNBHovvLk8xiGMFgY0bmOPCipGdzrx6RhtsbelrlNrqKa+VZ7VgEX4zNmiUBdeqFW9CNyN9ARI/aWl7kzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9053

Use common dw_edma_core_start() for both edma and hdmi. Remove .start()
callback functions at edma and hdmi.

HDMI set CYCLE_BIT for each chunk. Now only set it when first is true. The
logic is the same because previous ll_max is -1, so first is always true.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/dw-edma/dw-edma-core.c    | 24 ++++++++++++++++--
 drivers/dma/dw-edma/dw-edma-core.h    |  7 -----
 drivers/dma/dw-edma/dw-edma-v0-core.c | 48 -----------------------------------
 drivers/dma/dw-edma/dw-hdma-v0-core.c | 43 +++----------------------------
 4 files changed, 25 insertions(+), 97 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index 5b12af20cb37156a8dec440401d956652b890d53..37918f733eb4d36c7ced6418b85a885affadc8f7 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -163,9 +163,29 @@ static void vchan_free_desc(struct virt_dma_desc *vdesc)
 	dw_edma_free_desc(vd2dw_edma_desc(vdesc));
 }
 
+static void dw_edma_core_start(struct dw_edma_chunk *chunk, bool first)
+{
+	struct dw_edma_chan *chan = chunk->chan;
+	struct dw_edma_burst *child;
+	u32 i = 0;
+	int j;
+
+	j = chunk->bursts_alloc;
+	list_for_each_entry(child, &chunk->burst->list, list) {
+		j--;
+		dw_edma_core_ll_data(chan, child, i++, chunk->cb, !j);
+	}
+
+	dw_edma_core_ll_link(chan, i, chunk->cb, chan->ll_region.paddr);
+
+	if (first)
+		dw_edma_core_ch_enable(chan);
+
+	dw_edma_core_ch_doorbell(chan);
+}
+
 static int dw_edma_start_transfer(struct dw_edma_chan *chan)
 {
-	struct dw_edma *dw = chan->dw;
 	struct dw_edma_chunk *child;
 	struct dw_edma_desc *desc;
 	struct virt_dma_desc *vd;
@@ -183,7 +203,7 @@ static int dw_edma_start_transfer(struct dw_edma_chan *chan)
 	if (!child)
 		return 0;
 
-	dw_edma_core_start(dw, child, !desc->xfer_sz);
+	dw_edma_core_start(child, !desc->xfer_sz);
 	desc->xfer_sz += child->xfer_sz;
 	dw_edma_free_burst(child);
 	list_del(&child->list);
diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
index 2b5defae133c360f142394f9fab35c4748a893da..7a0d8405eb7feaedf4b19fd83bbeb5d24781bb7b 100644
--- a/drivers/dma/dw-edma/dw-edma-core.h
+++ b/drivers/dma/dw-edma/dw-edma-core.h
@@ -124,7 +124,6 @@ struct dw_edma_core_ops {
 	enum dma_status (*ch_status)(struct dw_edma_chan *chan);
 	irqreturn_t (*handle_int)(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir,
 				  dw_edma_handler_t done, dw_edma_handler_t abort);
-	void (*start)(struct dw_edma_chunk *chunk, bool first);
 	void (*ll_data)(struct dw_edma_chan *chan, struct dw_edma_burst *burst,
 			u32 idx, bool cb, bool irq);
 	void (*ll_link)(struct dw_edma_chan *chan, u32 idx, bool cb, u64 addr);
@@ -195,12 +194,6 @@ dw_edma_core_handle_int(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir,
 	return dw_irq->dw->core->handle_int(dw_irq, dir, done, abort);
 }
 
-static inline
-void dw_edma_core_start(struct dw_edma *dw, struct dw_edma_chunk *chunk, bool first)
-{
-	dw->core->start(chunk, first);
-}
-
 static inline
 void dw_edma_core_ch_config(struct dw_edma_chan *chan)
 {
diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
index 59ee219f1abddd48806dec953ce96afdc87ffdab..c5f381d00b9773e52c1134cfea3ac3a04c7bef52 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
@@ -379,36 +379,6 @@ static void dw_edma_v0_core_ch_enable(struct dw_edma_chan *chan)
 		  upper_32_bits(chan->ll_region.paddr));
 }
 
-static void dw_edma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
-{
-	struct dw_edma_burst *child;
-	struct dw_edma_chan *chan = chunk->chan;
-	u32 control = 0, i = 0;
-	int j;
-
-	if (chunk->cb)
-		control = DW_EDMA_V0_CB;
-
-	j = chunk->bursts_alloc;
-	list_for_each_entry(child, &chunk->burst->list, list) {
-		j--;
-		if (!j) {
-			control |= DW_EDMA_V0_LIE;
-			if (!(chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL))
-				control |= DW_EDMA_V0_RIE;
-		}
-
-		dw_edma_v0_write_ll_data(chan, i++, control, child->sz,
-					 child->sar, child->dar);
-	}
-
-	control = DW_EDMA_V0_LLP | DW_EDMA_V0_TCB;
-	if (!chunk->cb)
-		control |= DW_EDMA_V0_CB;
-
-	dw_edma_v0_write_ll_link(chan, i, control, chan->ll_region.paddr);
-}
-
 static void dw_edma_v0_sync_ll_data(struct dw_edma_chan *chan)
 {
 	/*
@@ -423,23 +393,6 @@ static void dw_edma_v0_sync_ll_data(struct dw_edma_chan *chan)
 		readl(chan->ll_region.vaddr.io);
 }
 
-static void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
-{
-	struct dw_edma_chan *chan = chunk->chan;
-	struct dw_edma *dw = chan->dw;
-
-	dw_edma_v0_core_write_chunk(chunk);
-
-	if (first)
-		dw_edma_v0_core_ch_enable(chan);
-
-	dw_edma_v0_sync_ll_data(chan);
-
-	/* Doorbell */
-	SET_RW_32(dw, chan->dir, doorbell,
-		  FIELD_PREP(EDMA_V0_DOORBELL_CH_MASK, chan->id));
-}
-
 static void dw_edma_v0_core_ch_config(struct dw_edma_chan *chan)
 {
 	struct dw_edma *dw = chan->dw;
@@ -562,7 +515,6 @@ static const struct dw_edma_core_ops dw_edma_v0_core = {
 	.ch_count = dw_edma_v0_core_ch_count,
 	.ch_status = dw_edma_v0_core_ch_status,
 	.handle_int = dw_edma_v0_core_handle_int,
-	.start = dw_edma_v0_core_start,
 	.ll_data = dw_edma_v0_core_ll_data,
 	.ll_link = dw_edma_v0_core_ll_link,
 	.ch_doorbell = dw_edma_v0_core_ch_doorbell,
diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
index 94350bb2bdcd6e29d8a42380160a5bd77caf4680..7f9fe3a6edd94583fd09c80a8d79527ed6383a8c 100644
--- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
@@ -217,26 +217,10 @@ static void dw_hdma_v0_core_ch_enable(struct dw_edma_chan *chan)
 		  lower_32_bits(chan->ll_region.paddr));
 	SET_CH_32(dw, chan->dir, chan->id, llp.msb,
 		  upper_32_bits(chan->ll_region.paddr));
-}
-
-static void dw_hdma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
-{
-	struct dw_edma_chan *chan = chunk->chan;
-	struct dw_edma_burst *child;
-	u32 control = 0, i = 0;
-
-	if (chunk->cb)
-		control = DW_HDMA_V0_CB;
-
-	list_for_each_entry(child, &chunk->burst->list, list)
-		dw_hdma_v0_write_ll_data(chan, i++, control, child->sz,
-					 child->sar, child->dar);
-
-	control = DW_HDMA_V0_LLP | DW_HDMA_V0_TCB;
-	if (!chunk->cb)
-		control |= DW_HDMA_V0_CB;
 
-	dw_hdma_v0_write_ll_link(chan, i, control, chunk->chan->ll_region.paddr);
+	/* Set consumer cycle */
+	SET_CH_32(dw, chan->dir, chan->id, cycle_sync,
+		  HDMA_V0_CONSUMER_CYCLE_STAT | HDMA_V0_CONSUMER_CYCLE_BIT);
 }
 
 static void dw_hdma_v0_sync_ll_data(struct dw_edma_chan *chan)
@@ -253,26 +237,6 @@ static void dw_hdma_v0_sync_ll_data(struct dw_edma_chan *chan)
 		readl(chan->ll_region.vaddr.io);
 }
 
-static void dw_hdma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
-{
-	struct dw_edma_chan *chan = chunk->chan;
-	struct dw_edma *dw = chan->dw;
-
-	dw_hdma_v0_core_write_chunk(chunk);
-
-	if (first)
-		dw_hdma_v0_core_ch_enable(chan);
-
-	/* Set consumer cycle */
-	SET_CH_32(dw, chan->dir, chan->id, cycle_sync,
-		  HDMA_V0_CONSUMER_CYCLE_STAT | HDMA_V0_CONSUMER_CYCLE_BIT);
-
-	dw_hdma_v0_sync_ll_data(chan);
-
-	/* Doorbell */
-	SET_CH_32(dw, chan->dir, chan->id, doorbell, HDMA_V0_DOORBELL_START);
-}
-
 static void dw_hdma_v0_core_ch_config(struct dw_edma_chan *chan)
 {
 	struct dw_edma *dw = chan->dw;
@@ -332,7 +296,6 @@ static const struct dw_edma_core_ops dw_hdma_v0_core = {
 	.ch_count = dw_hdma_v0_core_ch_count,
 	.ch_status = dw_hdma_v0_core_ch_status,
 	.handle_int = dw_hdma_v0_core_handle_int,
-	.start = dw_hdma_v0_core_start,
 	.ll_data = dw_hdma_v0_core_ll_data,
 	.ll_link = dw_hdma_v0_core_ll_link,
 	.ch_doorbell = dw_hdma_v0_core_ch_doorbell,

-- 
2.34.1


