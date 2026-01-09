Return-Path: <dmaengine+bounces-8156-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8166AD0AEE0
	for <lists+dmaengine@lfdr.de>; Fri, 09 Jan 2026 16:33:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 919CA30692A4
	for <lists+dmaengine@lfdr.de>; Fri,  9 Jan 2026 15:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A7943644C3;
	Fri,  9 Jan 2026 15:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="HB7fJuuB"
X-Original-To: dmaengine@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010007.outbound.protection.outlook.com [52.101.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63382364049;
	Fri,  9 Jan 2026 15:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767972576; cv=fail; b=grNEZqAZ6p991WbUga3KIR+ZqiEiRwpeITbYJoWysiXioBbXMU5YEE7TLnn28Z5//gNiX3+LDRYw0u/L57T6NfXCGJVfg9H3ENfqY5+/1nSFe39c/L5sy2UYXv2PyT8ytfHy0n06nlQCUgi4Liyx66fPSXVJYgzu814EqMMAiBU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767972576; c=relaxed/simple;
	bh=w5ps2p9CujbZUsKjzla7w5em4bh2AQNtLiZah5if8hg=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=qCI8FN4kZmf7E4rSKyaWVMrdZ/IkzGEm1r55YVMFM2sjDOHhM2qf5l3wATuKJp0GoGqj+9WxdQ0QIM/UY7QJGuJjSsCXdfZT7UXBzlkf5k1gIa3M6DD9KCri2s1cTvKLDl4aU69yeFKN9jFHL4Wze+XClJFwRq/wxYUxCPrxOjU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=HB7fJuuB; arc=fail smtp.client-ip=52.101.84.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aLuomOKLFgEFRWt/5nc24nIkeU5ZZ6gLUXXmdWpj6WIU70okX9bH9nGLKS9Vz4o2Aosz5qvg33HkBjxnbxdeoPxEp4kYA6E8zWRFhF6Txz5r0GfkLzz95zC2u0LKLtq3Rqttgy//kAybxEKePU3kiq6CJzV+Q+jdWjysnfMK2up9F2iW/li2zmP9xL37dwTnzA8GPO5Iy0Tvpvjl2V3HllSI/gmFgR6or5rP4VVsYWFxTJRscmYjUSvKnGoK4IWn5/MiRla58Efrd2Swup4Rme7Ou10MWdUv2cHC7Pkjf2RmmD2DlPCHlXykmRzKFGyILidjZLO8krvzOU9QB19qpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XXVVOurEHaeLMeflZi1dd2ZRXNNs6nwImwEsOkr5VFI=;
 b=CwYKyRLlI223mxoQ8SpANq1K2zuwjLbDiiZVA2KeR+nVws5xPXVd7o35pOaRsfxIXexn+VgtWjanOQtd+ayfS7pMs/2PCwqEVhMclRZJCc1utvGql5z9CJ9mJTTsGkWuYc2yvn8M7M0/qG9EVpsfB6/OWq2Hg/1Z8VfD+DcICjIJFXmrAtp/l48RJA+OLD+dc0f+6JL/LM6sWSUT8slMT9QplS967OiXro6CK1tEDidTGvIor+25Du55uVJxcdg039uoWI1NKMka5PHOQldljP/3dA2ZaYir/VRrYeY/vqSpq7GtWyVQd6lk8ttxk67QMNxcJn98kg25dJ+RA5iX5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XXVVOurEHaeLMeflZi1dd2ZRXNNs6nwImwEsOkr5VFI=;
 b=HB7fJuuBXaGAt6LUCS5Y3NDUzFxgwNQmU99FbEaUnIwNa9IPofOhideO8jTvVfeymjpv8qy49J1S5ImkNFgX6F/6Fx0BGzPATmPicPsEU4Kh2hVLWhbF2JU/bt31qj1B4RTuWz9hzr3CZcOnFWFvvxm0suTnieIbAG+yaNlvr5HaoPcK8vh9ZBStm3BtpxJ463+93P4Y3O+Na6HKycrlSiJxog+rUrEZhqaGRuTMzWevy3EuiXoWShTECmvkWYPNpnsrgkoyA3t2OrQBBFYBB/XZlUTtME1/3plsx3JASBGE0GR/4mQ/MMVU8P83il5uZDZeQrDBf6wcJWq0I5CcVg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8957.eurprd04.prod.outlook.com (2603:10a6:102:20c::5)
 by DU0PR04MB9371.eurprd04.prod.outlook.com (2603:10a6:10:35a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Fri, 9 Jan
 2026 15:29:31 +0000
Received: from PAXPR04MB8957.eurprd04.prod.outlook.com
 ([fe80::9c5d:8cdf:5a78:3c5]) by PAXPR04MB8957.eurprd04.prod.outlook.com
 ([fe80::9c5d:8cdf:5a78:3c5%3]) with mapi id 15.20.9499.003; Fri, 9 Jan 2026
 15:29:31 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Fri, 09 Jan 2026 10:28:28 -0500
Subject: [PATCH v2 08/11] dmaengine: dw-edma: Add callbacks to fill link
 list entries
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260109-edma_ll-v2-8-5c0b27b2c664@nxp.com>
References: <20260109-edma_ll-v2-0-5c0b27b2c664@nxp.com>
In-Reply-To: <20260109-edma_ll-v2-0-5c0b27b2c664@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767972522; l=6285;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=w5ps2p9CujbZUsKjzla7w5em4bh2AQNtLiZah5if8hg=;
 b=6qOa94gk2Fz5ZuhZTCShYgywQCoKiwZQdW3tORzPEgFuJFsN6+tJ7DqqBGPLFxYQSMH9n4GvY
 0nxOdfId7zCAXX4vxbCTGQ2qRyeBVru+JXhiy0bv5RJscSn41Jtbgxw
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR01CA0069.prod.exchangelabs.com (2603:10b6:a03:94::46)
 To PAXPR04MB8957.eurprd04.prod.outlook.com (2603:10a6:102:20c::5)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8957:EE_|DU0PR04MB9371:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ec66f8f-5f0b-4d84-83f9-08de4f93e166
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|52116014|7416014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bEljRzJIT2JWY2p5MVN2VkxiVjBHZVBsY29GZ0VBWHVpUFRUUkdBcm5VdExU?=
 =?utf-8?B?QXh2Y282bzhPN2o4MG5mb21vamI5aXQxTzYwNGFyWVV6VWZCd3FOa3ptaWhZ?=
 =?utf-8?B?cjNybCtPa25Fdm9ndVZSdUVlckhtVGR4VkV1bTE4dWVRUFd5OFhVeS83b2NV?=
 =?utf-8?B?NmtNblpKK0V2dVEzUDFFc2l6Qk9GYmJTTG9GbmdQWnlQaGFMQjB0aXJzQ2dk?=
 =?utf-8?B?Rno4SlozMWZqTVRjRTFlbEY5N2lZNncvY2J3dms1bVJ0enVSS3dXTHFPUEMx?=
 =?utf-8?B?eTZOMlJVcFpGUUEwT2RaSVpVcVFEL1NYbDZhMTBSQ1hkQ1V3am1PajdPVHp4?=
 =?utf-8?B?cEFVSUNnY3Vhb0F3c1ZCUXl2dE9PblViNGpRcjJrc1BWemxiSjYrVFowc1U3?=
 =?utf-8?B?TUlzMm1mU2xYR0F5ZEJ0akhLN1JkVGR3TFNGK2k4dDhobEZqWHZRMjZ0aEd0?=
 =?utf-8?B?WXMwc3NXZmdlNm9CUHd1TzRDRHFsVnQxMGhxU0NBWXdOTHlvK281a2lsZ2dr?=
 =?utf-8?B?c0JRM28zSHNWeEVLTlBTYjhkLzBxTVlWamhaWjRNNHRmSTlpWGo2MitGU3Yr?=
 =?utf-8?B?aGFLSjJBOXU1WXFZWFZHSE9vNStKRFNrUWJsSEpodGpCcU9rVHhrVWVpM0Ex?=
 =?utf-8?B?cmZXMHBvMHVjYVhEcGVWMDd5NDIrdkxlUDlNRmptek02VVZOTThpYzdyTmxm?=
 =?utf-8?B?WENUenpCdTU2dE01UlB3RHc0OG5LSFZML2J5VXVnVDkxa01zdDR2MFdZZVFF?=
 =?utf-8?B?RWZFRHdKR0k5MEExR2pXSEp3dGNxdjlmb01TL3c1cy9teFBPMEM3ZXpDVG1G?=
 =?utf-8?B?dnF1b2haSkNZVXZxMDVJaFEvTjFMdVJNeTdmNmY5blQ2dlZFdnR0WURYN0s3?=
 =?utf-8?B?K0M1OUV1Uk8rRFJxNTFJc0VsWGM5eHR0QmZObFBoeFVxMWZkL0luUTVFb21v?=
 =?utf-8?B?VGp6V3h4Zlc3Tlk5SWNtVkNQM3Z3UVg3bmNzSXEvdHFKYlFvdE1BN2xBSFFS?=
 =?utf-8?B?SEVobXdaSnF1RGk0Qkg2OFJKVjNIamY0WXFBZG5HdEw3dCtLcmhCcldtdFN4?=
 =?utf-8?B?cGVXUlJ2SUFtcUJpZ0tlSUQ0YjNwc1V1b3VGRm10b29HNFdvV0pzUStSMTNi?=
 =?utf-8?B?MzNwb3ppQUZXZnpzTi9sY0FTMTRYdlRudlFnVnNremdTdkNXZVNFYUJpUkJm?=
 =?utf-8?B?c09IRWs4Y3BWTHFQeWZrZnVkWllhT2VUZzdGVTNOZ3JlWkQ1VDVZc3RNaFVV?=
 =?utf-8?B?akF1ZXlPZEJ4L24weUxuUzVrSy9JN3JjS085ME01bjY5OVdvc0R6RWhQcHRP?=
 =?utf-8?B?bTdmZFUvLzJHVmRORFpQV1FUL3c1M2VsVUpPLzdmN3UzQkp1TFBqcFpOcXVJ?=
 =?utf-8?B?ZlptbnhVQUFoYWFWVkhQenVCNXhpWTFUcXQxSVUzbVpYYmU1ckhFVDlvS2lh?=
 =?utf-8?B?dUtDODhaY3Q4cW5iSlhyQWdKQVdPeXY2aEtlaFFhNnhpKzVGSkJsWU9Ebk9E?=
 =?utf-8?B?QlFoeGtKRDg1bkhGOGVNMjV3NTEzZ2ZiT0RWRkdkVXBORWsxc1MvUmh2SkNL?=
 =?utf-8?B?U2xmOVdmVlpCYSswcUVmZ1dsa3FCSmRqbmZGSnpIbHdZdTBScHNCbjU0eVN4?=
 =?utf-8?B?U2xSWUcrWlRaa0NTckVKUHh5ejdtbXpIT05nQTlUc3JJMnk1WFdFK0hFcWx4?=
 =?utf-8?B?cTF2SktHdGVWSWxwRzNCWU04VGt0dGpWOFhLaDkwdEdhbFZNdG1NcE80WDBX?=
 =?utf-8?B?Z1UxOGZnREI0M3pCTFFuRlM0Yk4yRUZvaUJSaE51TkZHYjgyMHpwS2dIcnd1?=
 =?utf-8?B?ZVhIVStOUnJwWGswWEJaaGZ5TWVKd1pOQVpqMWlFVTJLaU9RZFh1MElmemVw?=
 =?utf-8?B?UXZLVE1KNEJURXQwY3JLWWxJK0tQZlZiYXg0b1hIZHhQQld4czRUeHcxZXUz?=
 =?utf-8?B?WjBaeEk0T2xiakdsN3l4SFVMMXQ3alhVcnpRSXJMRTJwMEJpeEFTQnFFY0Y0?=
 =?utf-8?B?NUxhMVVnMGY1SGw0NGtKQ0ppOGxCTEFzOUhaYUFzZ3RSSkpLbW5FVi9FMUVV?=
 =?utf-8?B?OW40eENkdVYwbVdFZ2xDeXg0eittdVJ0OG54dz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8957.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(52116014)(7416014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ejFjUmM1aXhFVGlKY3lGajhyaHZtcnM4WUR6eWZvRmY4VkM5NE5zWHVUZURq?=
 =?utf-8?B?RCtKSHZ3ODFlVFdJamxhWmZQYS9FKzVpV2NXU3liK1A1NFVhZ0VqZ1B6NkZB?=
 =?utf-8?B?VDNSaXBhNXA2ZHRkWlQ0SnJZR0VoY3BUaURNdUVPN3RnTGpaM1cvRVpjdlUr?=
 =?utf-8?B?d1phR1VDZW50NmgzSWRaVmw5ckEydFcwNmxpeVFTMjYyWWsrdC8zZGFpNDdB?=
 =?utf-8?B?bnh0QllpUUVRTWtXdC9UNjdQTWJKVHRkTUN0UEVyUXk0VEtxajhVMHBMM1Vm?=
 =?utf-8?B?WGh6OFZGL2JkNXBWTFZVYit4M3VZYXhDS2tZeGFKM0N4QnNyQThPSXBDalk1?=
 =?utf-8?B?cFd3cDYrL1RKNHlGUVhkQmh1UVNzQklaV0tTZyt1QVdxT2lWU3R0bTcyMko2?=
 =?utf-8?B?cjU2d1gzd0NaZjdibmMrcDFndUFqbk1FQ2I5aThXKzg0WGtWWHp0czh6ZDR4?=
 =?utf-8?B?YnhQdTBQbmcza3E1ck8xMVRLMUg4RFVQSWxxWEhKTlZnVXRuUVFweSs5dlZq?=
 =?utf-8?B?SlJCcVYwRkYzUVQ4VW5uMm9nZ0t4LzcxQmxGa3hzMlpuSkdkUVdUdHZjZ3po?=
 =?utf-8?B?R1dMSUZWcFA0SWN2UG9kWVBOUzVUNEtZSzZLL3NFZWJFQmVCSFY4ZXJlUGxG?=
 =?utf-8?B?TTBoOWlRM2dOSURBQWRUaWtPREl1Nld5K2lhYWd6VjJaQVQyV3BsaFFnalM4?=
 =?utf-8?B?ajg1OStFUE1CSDVhQjhJeG1LMWNYSU9GUEIrWEN1dUxsUFlxOWNzeGRyTUhS?=
 =?utf-8?B?eWlpMVZPSVZINU9CVXhHai9OajZnUGhnbTVBbjhaUVJQb0pMVXFWSDVDTUwv?=
 =?utf-8?B?Vkc4Vm1VZUtreGRVNHJyZXBMV3Zxakp4bXUxRkNjcFljZ3JCUFRaR0FnSVFu?=
 =?utf-8?B?K1B1TWVlcVhCTzM5S0JTeVBtT0tLVmoxZXg0NHlkZ29IVnlJSGZHblh3dFZx?=
 =?utf-8?B?bE8zOVNRbnhUSDBVVVQ5ZEQ3dnhoWEV3QTBUbG1UUU1Fa3d2dXZVemlZQWFv?=
 =?utf-8?B?TUJ3N3dtUm1uRXp1RWxZRE1pVy9rWXVVOWdtOWVjZ2hsc2JIRld4NXBoOFB6?=
 =?utf-8?B?YW5TMjlaMVVBMUxoSkRzRE4yTW9RWDNmcHRYVDM2QjQ2ZEIvY1FOOUN5aFFW?=
 =?utf-8?B?ZzZGK0hwdytGQ3BkSS9HVFpMMGJkY3NOMDRJQUVxdi9YcWJHc0I1VjBZK2xD?=
 =?utf-8?B?UkJKaXV2UFNGejczMnpqdDl4ZXMrWC83WEFmcEVFRVJNdEQreUlXK0F4dXdq?=
 =?utf-8?B?L3JiUWVib051T2ZSQ1dPcHhoR1hPRnU4RWFzTFFHNDVtbVY2d2NUUXkvSzV3?=
 =?utf-8?B?VkRmTE9LSUxSNXcwaTlDK25jdE9zQm5NUzF6S1p5L3BWQllvb3lMSEM1UHpK?=
 =?utf-8?B?VEZRWkRTd25yYURSR0NlcnRzOEEvRTdlVzFSYkk3TExkQXNhYmhIYkJ6VzE1?=
 =?utf-8?B?VmVTbU9NQ0RFcEFZVU9iRENwS3ozamJFY2J5eGlRcFJFWXNoNk9Nd2g4YmJB?=
 =?utf-8?B?UW5VVjhhcHA1VUN6bW5FRDhHVFhDZ0p3c2lXVFJ3NW1veTljMXJwbG9kMFVV?=
 =?utf-8?B?MnRLNXd5OCtkYlN4eEtzU213NDFjWHpZRXRIQkpSeFZGMlZhZVFwMnZ1Qis1?=
 =?utf-8?B?ZDY5Q2ZSdDJqZmYreGwySWVFNEhMZjVKcHZqM0lCNEZwQ21SYkc2VklkYk1n?=
 =?utf-8?B?WGkxekd3WGhQQVg0TjBnKzlCM0hucVAxd3lFclRyQjlxMnlxbUh4V0N2NXhh?=
 =?utf-8?B?VEZranVIbC8wVmliS0dvNVJhT08zQVpsZE84dWNQakpEakNWUTVBUVM2Wktr?=
 =?utf-8?B?dXNNenFISFY0MkJEdEh4djlJOHh4UkhHUmFsN2cvc1AzTHN1Z0ZOb0RYeEI5?=
 =?utf-8?B?cnNGZjFzM2Yra0t1U1FqWFVGMUFNSk5IdmYrOG5zU3VBVGNzWUhxRko0UEp3?=
 =?utf-8?B?TE16cHROMkxob0Zwa0xlQm5QZHk5M01hRklRcGtXVllTWHRYUWhZUDRzMzdK?=
 =?utf-8?B?YjZUeU5PMGFhclpiYS93cWhsRVdmREVmSUh1ekgwZmlYT1RFZWQ1K1BLa3Rp?=
 =?utf-8?B?S1F3Tm5GdGJ6WWorbThxRmJqNG9UUmM5bld0ODBsdGJxbU5sWm5GSDZURkQz?=
 =?utf-8?B?a0hGZlZnam9MQ001dU45WnhhWnRiaGQvR2ZzN1RDMWpmT0duejRWTkI3K1Ar?=
 =?utf-8?B?SStBTDVxVjB4a3hmaWdRTnNJcTJsM0F3TTZrR1Y2TGRvSFJDTWgvdERrNk9y?=
 =?utf-8?B?SWNJUWR6L29NejZuY05Wc3JlakdzcVpWeXJqMFhRVTgrbTFVVTM5ZlVWamln?=
 =?utf-8?B?K2dLd3hScm9iRGVXMFJEOWxMT0hUdzZ6akQ0T213TXBQVjZyZWZTUT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ec66f8f-5f0b-4d84-83f9-08de4f93e166
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8957.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2026 15:29:31.1956
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d7DrVUP662LRqMOkI7w8EryxZBlsybffmCHaFKF/ogCgUfQVLhl5CmvksATmYR4cIyF6I+ye0OKQ7USVPXibqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9371

Introduce four new callbacks to fill link list entries in preparation for
replacing dw_(edma|hdma)_v0_core_start().

Filling link list entries is expected to become more complex, and without
this abstraction both eDMA and HDMA paths would need to duplicate the same
logic. Add fill-entry callbacks so the code can be shared cleanly between
eDMA and HDMA implementations.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change in v2
- update commit message
- use eDMA and HDMI
- keep inline to avoid build warnings. dw-edma-v0-core.c also include
dw-edma-core.h
---
 drivers/dma/dw-edma/dw-edma-core.h    | 29 ++++++++++++++++++++++
 drivers/dma/dw-edma/dw-edma-v0-core.c | 46 +++++++++++++++++++++++++++++++++++
 drivers/dma/dw-edma/dw-hdma-v0-core.c | 38 +++++++++++++++++++++++++++++
 3 files changed, 113 insertions(+)

diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
index e074a6375f8a6853c212e65d2d54cb3e614b1483..09e6b25225407f5bacb2699cbba26d1bab90b0c7 100644
--- a/drivers/dma/dw-edma/dw-edma-core.h
+++ b/drivers/dma/dw-edma/dw-edma-core.h
@@ -125,6 +125,12 @@ struct dw_edma_core_ops {
 	irqreturn_t (*handle_int)(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir,
 				  dw_edma_handler_t done, dw_edma_handler_t abort);
 	void (*start)(struct dw_edma_chunk *chunk, bool first);
+	void (*ll_data)(struct dw_edma_chan *chan, struct dw_edma_burst *burst,
+			u32 idx, bool cb, bool irq);
+	void (*ll_link)(struct dw_edma_chan *chan, u32 idx, bool cb, u64 addr);
+	void (*ch_doorbell)(struct dw_edma_chan *chan);
+	void (*ch_enable)(struct dw_edma_chan *chan);
+
 	void (*ch_config)(struct dw_edma_chan *chan);
 	void (*debugfs_on)(struct dw_edma *dw);
 };
@@ -201,6 +207,29 @@ void dw_edma_core_ch_config(struct dw_edma_chan *chan)
 	chan->dw->core->ch_config(chan);
 }
 
+static inline void
+dw_edma_core_ll_data(struct dw_edma_chan *chan, struct dw_edma_burst *burst,
+		     u32 idx, bool cb, bool irq)
+{
+	chan->dw->core->ll_data(chan, burst, idx, cb, irq);
+}
+
+static inline void
+dw_edma_core_ll_link(struct dw_edma_chan *chan, u32 idx, bool cb, u64 addr)
+{
+	chan->dw->core->ll_link(chan, idx, cb, addr);
+}
+
+static inline void dw_edma_core_ch_doorbell(struct dw_edma_chan *chan)
+{
+	chan->dw->core->ch_doorbell(chan);
+}
+
+static inline void dw_edma_core_ch_enable(struct dw_edma_chan *chan)
+{
+	chan->dw->core->ch_enable(chan);
+}
+
 static inline
 void dw_edma_core_debugfs_on(struct dw_edma *dw)
 {
diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
index 1f1bc8b8d04aff85ddaf0b077fd01a87ac54046f..7c954af7a3e377f1fb2a250279383af4fa0d8d3e 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
@@ -509,6 +509,48 @@ static void dw_edma_v0_core_ch_config(struct dw_edma_chan *chan)
 	}
 }
 
+static void
+dw_edma_v0_core_ll_data(struct dw_edma_chan *chan, struct dw_edma_burst *burst,
+			u32 idx, bool cb, bool irq)
+{
+	u32 control = 0;
+
+	if (cb)
+		control |= DW_EDMA_V0_CB;
+
+	if (irq) {
+		control |= DW_EDMA_V0_LIE;
+
+		if (!(chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL))
+			control |= DW_EDMA_V0_RIE;
+	}
+
+	dw_edma_v0_write_ll_data(chan, idx, control, burst->sz, burst->sar,
+				 burst->dar);
+}
+
+static void
+dw_edma_v0_core_ll_link(struct dw_edma_chan *chan, u32 idx, bool cb, u64 addr)
+{
+	u32 control = DW_EDMA_V0_LLP | DW_EDMA_V0_TCB;
+
+	if (!cb)
+		control |= DW_EDMA_V0_CB;
+
+	dw_edma_v0_write_ll_link(chan, idx, control, chan->ll_region.paddr);
+}
+
+static void dw_edma_v0_core_ch_doorbell(struct dw_edma_chan *chan)
+{
+	struct dw_edma *dw = chan->dw;
+
+	dw_edma_v0_sync_ll_data(chan);
+
+	/* Doorbell */
+	SET_RW_32(dw, chan->dir, doorbell,
+		  FIELD_PREP(EDMA_V0_DOORBELL_CH_MASK, chan->id));
+}
+
 /* eDMA debugfs callbacks */
 static void dw_edma_v0_core_debugfs_on(struct dw_edma *dw)
 {
@@ -521,6 +563,10 @@ static const struct dw_edma_core_ops dw_edma_v0_core = {
 	.ch_status = dw_edma_v0_core_ch_status,
 	.handle_int = dw_edma_v0_core_handle_int,
 	.start = dw_edma_v0_core_start,
+	.ll_data = dw_edma_v0_core_ll_data,
+	.ll_link = dw_edma_v0_core_ll_link,
+	.ch_doorbell = dw_edma_v0_core_ch_doorbell,
+	.ch_enable = dw_edma_v0_core_ch_enable,
 	.ch_config = dw_edma_v0_core_ch_config,
 	.debugfs_on = dw_edma_v0_core_debugfs_on,
 };
diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
index 953868ef424250c1b696b9e61b72ba9a9c7c38c9..94350bb2bdcd6e29d8a42380160a5bd77caf4680 100644
--- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
@@ -287,6 +287,40 @@ static void dw_hdma_v0_core_ch_config(struct dw_edma_chan *chan)
 	SET_CH_32(dw, chan->dir, chan->id, msi_msgdata, chan->msi.data);
 }
 
+static void
+dw_hdma_v0_core_ll_data(struct dw_edma_chan *chan, struct dw_edma_burst *burst,
+			u32 idx, bool cb, bool irq)
+{
+	u32 control = 0;
+
+	if (cb)
+		control |= DW_HDMA_V0_CB;
+
+	dw_hdma_v0_write_ll_data(chan, idx, control, burst->sz, burst->sar,
+				 burst->dar);
+}
+
+static void
+dw_hdma_v0_core_ll_link(struct dw_edma_chan *chan, u32 idx, bool cb, u64 addr)
+{
+	u32 control = DW_HDMA_V0_LLP | DW_HDMA_V0_TCB;
+
+	if (!cb)
+		control |= DW_HDMA_V0_CB;
+
+	dw_hdma_v0_write_ll_link(chan, idx, control, chan->ll_region.paddr);
+}
+
+static void dw_hdma_v0_core_ch_doorbell(struct dw_edma_chan *chan)
+{
+	struct dw_edma *dw = chan->dw;
+
+	dw_hdma_v0_sync_ll_data(chan);
+
+	/* Doorbell */
+	SET_CH_32(dw, chan->dir, chan->id, doorbell, HDMA_V0_DOORBELL_START);
+}
+
 /* HDMA debugfs callbacks */
 static void dw_hdma_v0_core_debugfs_on(struct dw_edma *dw)
 {
@@ -299,6 +333,10 @@ static const struct dw_edma_core_ops dw_hdma_v0_core = {
 	.ch_status = dw_hdma_v0_core_ch_status,
 	.handle_int = dw_hdma_v0_core_handle_int,
 	.start = dw_hdma_v0_core_start,
+	.ll_data = dw_hdma_v0_core_ll_data,
+	.ll_link = dw_hdma_v0_core_ll_link,
+	.ch_doorbell = dw_hdma_v0_core_ch_doorbell,
+	.ch_enable = dw_hdma_v0_core_ch_enable,
 	.ch_config = dw_hdma_v0_core_ch_config,
 	.debugfs_on = dw_hdma_v0_core_debugfs_on,
 };

-- 
2.34.1


