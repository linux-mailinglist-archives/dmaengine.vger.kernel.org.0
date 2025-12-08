Return-Path: <dmaengine+bounces-7535-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 60E4ECADD31
	for <lists+dmaengine@lfdr.de>; Mon, 08 Dec 2025 18:10:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 015A33028327
	for <lists+dmaengine@lfdr.de>; Mon,  8 Dec 2025 17:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4552A28CF7C;
	Mon,  8 Dec 2025 17:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="RloISD9I"
X-Original-To: dmaengine@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010058.outbound.protection.outlook.com [52.101.69.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07D92D3225;
	Mon,  8 Dec 2025 17:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765213824; cv=fail; b=pDLwygLZ6EiTPytz14rjra47FiRvI1JUpU1W5u+mHJMfW8X835PzZydCLVDhQYkyH3yYRUzyezjsEmpJuowhEynvGOiuGQmJfZ1UtUT/Et/17FMQhYKvoT7qsUDgnDFYorfYqcote/Ltr+9zKy+xlnNOBow81SRUkWihCujXv5c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765213824; c=relaxed/simple;
	bh=JSiFHoc4jP047joFmy+C7Hev7L96D7ECNo/fkTDMah0=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=YVpYtuaE176eaMNVQ6tZKp6QmTpHdIfQ7wtbyj/ybWY3YD6QtJfmgdZl2HTK26zs1J7W8lpk/Xbz+6ByHrqZ75TOlqRA/yyUs6RpIqrg2fpmRRaveMumpGXBmqCEdxyMTOrmPb+UkMuwZ+0RLHe4Y4Xo9upub2pV7lfZaBsXuFk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=RloISD9I; arc=fail smtp.client-ip=52.101.69.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m9/w+Mc+lHIjGaqVUT2cKDYdj4pe7mq8rh413pxnOQhvOYKn7W3yESEZmoddP6ayTyfvY4BOIU72jkLFeJXupaCc4iYzAxwnkE1CeWMKVgktoIzzfd/xkixWWC7kRtspWio9zX6gvl+afq1LdyyrA11jkG/1piH1nqjhRZuaD6tL0YwaCim+dsbysmMTyYCP+NueRp6QrNAPfyLDXcjoOtJAhRNDsM2OepcsCpIhFHaSTZKNsvBbvv0hoe9taRcmt8dHtjmLgi19FmQUShUIgieb4AtcNkM0Zgr1NMtgbp4yvnSMPT273EDGNW6JBNu2Mawg3Qf28HWyOw5X/CMXfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Po1rG29/J+6NDX9dHwqALzdqP1QCBgE64DaqSi6gtM=;
 b=XrmiXm/jrwQqc56YU4PPpu8ELwJ7/VxJyDTvAxec2t64F2XkCILWxP6iFIl4LqippckGNezwmlA9AQ9LvQZtM2MXIpYpEXCTcdV8ctOTx7VO8ra1hOAjLXnvJgvrDPldZ1ua3WHWuXdE8mh7xpYcXfYUNs5g8i1Wloe53ROcLpsAiZXyvRkLf20byE65xW8Izp8S6wagKzaz6hZLrFU3JnUbE7KQnvm8oA1ldFDMpWdADfygG+mkBtM+XhbBMrMs22oDtFLHfXin5Qakw60UI6dgVv8mSGsETGwNcjTov4XNDI8aMzwCKzSEWUiLhKMHxBF29NGnZ+sIuxCtr3zj/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Po1rG29/J+6NDX9dHwqALzdqP1QCBgE64DaqSi6gtM=;
 b=RloISD9IdzF9yY0RT8P3MBxhkMgMqqUyX/rQUR6kyDiSjfddrkpH53LVdXNGnYn0q3DS6NkAlsODR1+LdtKEqmTO8GMrdEvw8u0M3yd7rkC8UkT/AoT/1cxiG97Cc1MqbqzwbgkcLxjvNLpJgY7RpDgO8v2uqKITdeSOcrRLOymhmo0Kle2ms1oVtN1igH7cxkKecpMWdShHxQpbLcoDXn83SEg6Gl8RMB7mY2d6l9h01iGMScC6daGF12V/xrYdqI8t10M8d3wwJjoLV/vq5qHu+MuDWVela2ZXFjKA6wNTsHGyi7cHghYs9q7LXme6JPYH9ZINjymAFzifoqxtSQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by VI0PR04MB10318.eurprd04.prod.outlook.com (2603:10a6:800:21c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Mon, 8 Dec
 2025 17:10:18 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9388.013; Mon, 8 Dec 2025
 17:10:18 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 08 Dec 2025 12:09:42 -0500
Subject: [PATCH 3/8] dmaengine: dw-edma: Use new
 .device_prep_slave_sg_config() callback
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251208-dma_prep_config-v1-3-53490c5e1e2a@nxp.com>
References: <20251208-dma_prep_config-v1-0-53490c5e1e2a@nxp.com>
In-Reply-To: <20251208-dma_prep_config-v1-0-53490c5e1e2a@nxp.com>
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
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1765213799; l=2052;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=JSiFHoc4jP047joFmy+C7Hev7L96D7ECNo/fkTDMah0=;
 b=gejb+vkn9vhmNXdvR0JPaUVUWQDjyJAARy5RrpEenBu5tLRkFcJIqnn7/iisxux25lREWWxeq
 7Jm1V4HS0Z0B1+bjyM0hl5WZiCq5lsxSfBZ+Er7bhw9KpIcdXnC91Ih
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH8PR02CA0036.namprd02.prod.outlook.com
 (2603:10b6:510:2da::28) To DU2PR04MB8951.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::22)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|VI0PR04MB10318:EE_
X-MS-Office365-Filtering-Correlation-Id: 108c7adc-199f-41ba-27de-08de367ca9e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|1800799024|366016|19092799006|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WTNxWXpyd29WM1VZeHIzWDNFWkZkZWxXL3ZOZ1MvYStyb1llV1lodExQcE9S?=
 =?utf-8?B?ZjlOaGhOM2JEUjR6Vm1ON3pQRy9RSnZZM08xajU2NmJBZ1QrajRSUGRwdmlR?=
 =?utf-8?B?dmowNVY2WkNKQmw0a2xSVzJZTkxKbHk0UUxaYzBTamJhUjhBQVFsV1pLc2JX?=
 =?utf-8?B?VU5HWlY5MVl0dHRuSDdDNlJrZ2paWkxIempDWlZWb3cvRFFiNG9TWHYwcVBu?=
 =?utf-8?B?NEVKTUVNckNDUGZ5Z2cyc1RscUxXanhFY0o0V0k3WmViSUhlUGRxcXBKQUNW?=
 =?utf-8?B?ODBmd0UzMnM1TkRvc2tORDFLc1R3T2V4N3Y3TG1zWUVZa0VkQnhuZU5SVnU2?=
 =?utf-8?B?M2JWYVk4dWJQYXZaK3VaYk1QTTV4SDhvTDlETjErM1JvR3V0TlBIbVRXVmxs?=
 =?utf-8?B?MHRsNDE2dGJFamp1TEorUllTeWZ4Rm44bFVXenRQaUdXZXJhbmRMbjJRNHpu?=
 =?utf-8?B?dGpPcWU0N0FpUjJjWkt5Nk5CNHB5a3ZSQmNZWVZDYlBlV3Jackl6TDFzVnIz?=
 =?utf-8?B?Ui9uTnRGMzgwWFNqVlpIcFZuUHZYQytoU2JmU2UxK3hGNDU2RjFyV2NXSFp4?=
 =?utf-8?B?UnJsUjdqSDBBQjUyaW04MTJEWG9KMFF4NHdYblc4NnlQb0RuZXdrQVFuWlhh?=
 =?utf-8?B?RmM3U3hNK2ttQSt3T0x2Qnk1Mk0waUduU3RINUw0bk5FbWlHTUFOOXhDdU1P?=
 =?utf-8?B?d0xUQ1ViYTJuTG1xK0FlSE1Za1dFcTBJOUFkK3FWck5rbXZqakt2QkRXZTZl?=
 =?utf-8?B?ckxGeGhCZlNyRHk3bVhNd1BSUVE0K1pSZjVoRHNBY2RJVmFPWmtBbTNrKzVr?=
 =?utf-8?B?WkJBaGtUK0wxWFBZVFprb0pkNHZvVEJzSGpNWUIzOERwbmgrR2lsTnJFUEcy?=
 =?utf-8?B?MjVlRCszV0pFbjZEV0I2Y0RzQ3JiZUhTUTdpUEZ5TjFYQmsxYzgyWFkzYzIw?=
 =?utf-8?B?TnRLcklQSXB0L2NMcGE0VUZROWNQQm5wd0J1eTYrczEzandZWDh3Z1IwVTVK?=
 =?utf-8?B?QmJDU1dRNkJPc2s1SGxrL1g1NFNUYTBicmVmcDdzaGhlVUR4S0pidE5BRFBX?=
 =?utf-8?B?dThqMHZkU21YSFZPSmYveXpzS1JxNEN3aHJiNHpLa1gzTkRPSTI4T0NIL0hD?=
 =?utf-8?B?WTFKSkR4blJZdHFVSGRLc080cnAyTm90bU9RRTJWd2VyUVdZbUJUc0pseThI?=
 =?utf-8?B?aUx3d0l1VVVNMnIxRng5Q3VsNzFWREtXL2JxelFWdUJ4bDNpY3BuTnNCTThz?=
 =?utf-8?B?R29CbVNKcjVZcHpSaC84M3FVQkZVaDAvc0tDVnJBUVZiRDJpODMrNHRQSGc1?=
 =?utf-8?B?c0h1QXBINXlqTFhDV2xERWJXNUsxeU5qV2dRSmFXbTRxQmJqVDZvTTFkWkMx?=
 =?utf-8?B?dmx1aUN6clQwNy9OcG9Kd29CZnZLeU5NRzJWRDVyK1dtZWhQREhPSTNiVjB3?=
 =?utf-8?B?UWROeWtudXNpL21tZzBFOHVkTTNNSkliY0lKY2RNMEVFaVhQY1krYVUzTmdQ?=
 =?utf-8?B?NzJvS292a1REVHN4Y1M4RHBZS3BTV3E3V00yQ3JGSnlNVEcvNnpUTk5zaHJu?=
 =?utf-8?B?OGRwbVp2ZFlQeTBVL2d2WnZBRjVsRHdJTHFMbHoxWDE5QlRoeXc2cFQwQ1la?=
 =?utf-8?B?ditrdm1WQmV5cXIwbzI4K1RHM0t4VVpMdTF5MjZRZ25IN1lkdHowMVdCcysz?=
 =?utf-8?B?NXNxdW9UVkdzTGordXRiNEZUUzV2dS9ob0x4RDlPUCtEM0Z6Zjh3V3loUlBG?=
 =?utf-8?B?M0krbWpQOGsrRkI0VjF1ZVV2L3E3cVdEMjJHeW5sNytNTG1PcWNlcXB1NXVC?=
 =?utf-8?B?dStzbDNQYnUyVDE3K3NLbXNxNWRDRXg0RU5WQnlVbXFtR3ptY1RvQXVoUWkr?=
 =?utf-8?B?WVlLWk9EbU1EaVQ2MVljbTVCQUhGaVoxNWhMRW5ZZ2NHZHdRNFJNRGk4OGZ2?=
 =?utf-8?B?YWx3TXBQK2gxMXdXT01wWVVBZlF5cm5QajBpRjMycXV5Tzk4NXRrSG1ZQkZX?=
 =?utf-8?B?UGRJUXl5cE9VSUhaWmFaMXNnTXVNVTViTmhTcnAzMCtIcHdCU0ttcU9xdmxR?=
 =?utf-8?B?ZmhkUGJVR3dhelZpQWNjb0c1YjFjOWVzTG1yZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(1800799024)(366016)(19092799006)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZDlqaHlyejFYeUhRK2N0aHJGbFN6WFFUOTRJSWlhQVB6UUhJb0k5RDJwUE5J?=
 =?utf-8?B?aUlmNnI2QTVKWERFelFnMjJTTzZ3blpvZzdLUEs0N0RqNyt1cWtUcUwvaU5v?=
 =?utf-8?B?dmNnUFRHd0xjMHpmMms4aTIwcENZZ0JJbGpYSTJhTGQvUFJxczAwVUg5WEoz?=
 =?utf-8?B?SXc5WWxyd3A1KzA4WkpkYnFndEVvYlJPU3hqU0VKYWhleFV1cDY0V3grMS83?=
 =?utf-8?B?dU9QS1VURXQxQVQ0MVVySFkxSXIvUWR4YTFudlNXOU5oLzMzOEdwelpFbi9w?=
 =?utf-8?B?U2RJWmdrUkQzU3dlK0FoRVRxK01iN2ZQTU5RTXFobVhtYjBtSExyUmNDVFdx?=
 =?utf-8?B?MmVVRlN0eUo5aUxLYzlvTFRrdm84T0xmLzBnMG9oQzVsQXJNWE52YVhhZE1L?=
 =?utf-8?B?amE0UlUyYnQrbXB0R0d3OGFIY3BuVW94QzNoVVpQV0tNaHoxS1VFWFh0a2FL?=
 =?utf-8?B?WC9vQSs2eTdlMHI1TEwrTkhNb0lWZExVcU5WSHNIMFh2RWJLQnZYS2RRNzN3?=
 =?utf-8?B?TEd6bjZvMVNJRlNOK2dMTWx6SVpuRHVVZ1VFVWdMNGpabkE2bVpjaHEwMXBD?=
 =?utf-8?B?NTgrTEowaCtlL2NtcE8xaExWT0RqaDgvTUxRS0ljSHhua2kzSllweDBkamVL?=
 =?utf-8?B?Zy9zRldreVVuWjhtNE9BQWdRNWRNcmJ1STRNSE5GaWcyeXJWMHY2Uy9odU5p?=
 =?utf-8?B?UlN3YTRRQTVVUU9OcExpTytkc0VoUUlGSUcvR0VUaE5ZK0pZdW9RaE1rcWJ2?=
 =?utf-8?B?NFpDUDRtNm5vbytYWXM5Y0tvNWtEeFFZa3lTZHc0a0d6dnl5bW9pNHozQzNm?=
 =?utf-8?B?TWplTC93MGNzT3lEMGg4UHNHc1BjTWdYOExaNWhLNXQ0T0RIN0ZzVUY3ZVNo?=
 =?utf-8?B?WXc0RlBHVG8rQ3d1cG1zL0I5RlhWV2srSjVCYmZlTTJseDE4RlFtbFZlUEUz?=
 =?utf-8?B?UDVoNHRTcmwvelN2eFRpYVVYem5BcE0zVFpRY2JBeVlBelpLZFJMNkNIUFE5?=
 =?utf-8?B?UWJBa25sRHcvNnFoS2NlcVJRYVFJLy85SVpqT09SdmlIZkY1QU4wR01sdDNK?=
 =?utf-8?B?SUhweXBvOHZoOWFmdE1xTUtWeXBzb2NJOFR4dmhBaGEycmpoVVZmYytXci95?=
 =?utf-8?B?OGVhemJxTUVUVDJCcDF6MmVwYUNaeHpJdVlxR2Q0eU53RlM0dnByWk1WQmFU?=
 =?utf-8?B?WTh0UkJOR2ZlaFVHcFp1L0I0eXFRZU1uL252N0FXbTZxQ1prMm5pVHd3Zmg5?=
 =?utf-8?B?NFVMbGUvT0YzUjJrTExqNzJWbGRPbFhvQUJtZnp0ZlQ3azU0ZEl0K25SOC85?=
 =?utf-8?B?dVJSblpkTEJ0RmhmMWNLY0VXaDAwK1RrRlZZWFFlamtTd0YrZENJVXJrU1JC?=
 =?utf-8?B?L1M0VFExRDNGTVRHWDFicGZnT05wYWU2cUE5bmx2dThxQWpwdmJ4WDVOeTVX?=
 =?utf-8?B?aDI2WjV2U0ErYWNBNmtyeWZsaGVmUk9oSHU0dzVsQVFuL2phUEt3UHNJV2lo?=
 =?utf-8?B?SVJZRUZjby9qUEdxVmtDSFY0V0M3WERmbWhxcUNXL1A0emRiQk83UVRBcEZx?=
 =?utf-8?B?TUNrQVBCVERBZmtMbkRsWXREYkltTC9rNWQ0eW4wdys2THQvKzdSUnUyczZT?=
 =?utf-8?B?QzQva1R0ZEVEdW5sWVRrZGJWSXozSFhMdnAxcUVUSzd4bFNxM1d6Snc4SDhw?=
 =?utf-8?B?LzNTSG51YU95T0NVeFUyR0pCTnNldjV0Y3J0NWpFaUZZQ3Uxa3pteUFseUJ2?=
 =?utf-8?B?dWxoWFlmTWh1MUtHRmtwdDl0RllEMnNTT3BHVUUzNGxvV3BhbXhuZlgvWWV5?=
 =?utf-8?B?dGkxRDY2VUlUNXdmMnFpNmdiQzVBUkhBVmEwak5tRUNnak5EYnBWZk96U2Ru?=
 =?utf-8?B?VlhHckVvMEZLUTB6VnA5M1dCRDQxMExoK3pLb2tvZ25BYm9nNFlmbVFrSzdP?=
 =?utf-8?B?Q2l1dU1zRG9HME5YODZVcXN3bHBoZzdZOGd3NkNMbVVmVnFzVzJHSzd2RE1U?=
 =?utf-8?B?aTQxbnBMdVhwaEFreFRxQ1k3MC9QV1R4ZnVzY3VlaEcrSVc2QXpUeTV3K2ta?=
 =?utf-8?B?UWhZQVZPNnZNMytOUnQvcnhiVkZnMjVKdjA1dVdhb0ladGEzT1ArSlprT0Na?=
 =?utf-8?Q?28kiZvhNq6epJMQiNQwUckao4?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 108c7adc-199f-41ba-27de-08de367ca9e4
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2025 17:10:18.8368
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f75wEMQZqRFTMvtkBhOUlcxb4TyxRl6f/xU5YupMmZBMv4ovAmQsPX8IoXPHxzfVOeZpNcTu2r6ESQdxKShlFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10318

Use the new .device_prep_slave_sg_config() callback to combine
configuration and descriptor preparation.

No functional changes.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/dw-edma/dw-edma-core.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index 8e5f7defa6b678eefe0f312ebc59f654677c744f..58f98542f8329a3bfdc5455768e8394ae601ab5f 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -532,10 +532,13 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer)
 }
 
 static struct dma_async_tx_descriptor *
-dw_edma_device_prep_slave_sg(struct dma_chan *dchan, struct scatterlist *sgl,
-			     unsigned int len,
-			     enum dma_transfer_direction direction,
-			     unsigned long flags, void *context)
+dw_edma_device_prep_slave_sg_config(struct dma_chan *dchan,
+				    struct scatterlist *sgl,
+				    unsigned int len,
+				    enum dma_transfer_direction direction,
+				    unsigned long flags,
+				    struct dma_slave_config *config,
+				    void *context)
 {
 	struct dw_edma_transfer xfer;
 
@@ -546,6 +549,9 @@ dw_edma_device_prep_slave_sg(struct dma_chan *dchan, struct scatterlist *sgl,
 	xfer.flags = flags;
 	xfer.type = EDMA_XFER_SCATTER_GATHER;
 
+	if (config)
+		dw_edma_device_config(dchan, config);
+
 	return dw_edma_device_transfer(&xfer);
 }
 
@@ -815,7 +821,7 @@ static int dw_edma_channel_setup(struct dw_edma *dw, u32 wr_alloc, u32 rd_alloc)
 	dma->device_terminate_all = dw_edma_device_terminate_all;
 	dma->device_issue_pending = dw_edma_device_issue_pending;
 	dma->device_tx_status = dw_edma_device_tx_status;
-	dma->device_prep_slave_sg = dw_edma_device_prep_slave_sg;
+	dma->device_prep_slave_sg_config = dw_edma_device_prep_slave_sg_config;
 	dma->device_prep_dma_cyclic = dw_edma_device_prep_dma_cyclic;
 	dma->device_prep_interleaved_dma = dw_edma_device_prep_interleaved_dma;
 

-- 
2.34.1


