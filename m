Return-Path: <dmaengine+bounces-8149-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A192FD0AE62
	for <lists+dmaengine@lfdr.de>; Fri, 09 Jan 2026 16:29:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5CF9E301511C
	for <lists+dmaengine@lfdr.de>; Fri,  9 Jan 2026 15:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 579AF363C4D;
	Fri,  9 Jan 2026 15:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="GJ48CMd4"
X-Original-To: dmaengine@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010017.outbound.protection.outlook.com [52.101.69.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C75D35E551;
	Fri,  9 Jan 2026 15:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767972537; cv=fail; b=GLjIBwXgrPzWnHTFLML6Z77kQvaEi4NpcBz3EJeRT9j9ES4wyO2g/+sk8z5Ghp/4ZWQHDDT41U+hZKIPKJ3eeyxGQuomUuDNj/t8p+9BMZKbIkJVHCLxBtlYxA4bhtkXqSX9Zeo/s78Oxv++bBdynWOwcPy22Loe3EATL5ihgUU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767972537; c=relaxed/simple;
	bh=yKF99Tx9lpadPhYSreIAeNag0NgA6KiKL/9dG8d/zNE=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Cpmuf+IRdCfod8SFUj7b+PLNp7ii12NMpd0T8Se/m+/NE0dIF+LkKlwO8EQ2LmHyr8IBQ4GHco4Nerssg0dJ0o4MZtv/8GNCH2tiW0+NPknLfqeWnc4tIiiokRLzdfNYpPk4uiK0kqWazlYT+bq6HDg+Ov3n+VIZyLuKEQWO9ag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=GJ48CMd4; arc=fail smtp.client-ip=52.101.69.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OqazjzU/F//y8y0D/szXDpxLhjvEt09xHrqVAqy4K/dCfOZdmotkAMdCZZkDMOYsXB47l4/5XG1+zxpSCAgyGidUjsGnZGSNPLUjy//3v3M+q7iQENCRUWBjBndVWM6YP92wwM9WzAIH+hGIzY71UGuX8PQKdEnrN4W5Q1zNUplE8WgaYWdT1BZAyqhhwWJZI2IEViMaPTmq/MD/qzWYEaTepNOXuTi85rZUddWFr1BMfIwIHgFAoL0hFJi1qdeJ6uMAvzWg2OrHFW8zf8aNRLNFwoDUA/jQHKpNomqf6aG3OYCclTWs/Ou+aU0aZaw3dn1OtrxVInStijkSYSISeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XfLjh+ApBY/nPWTjERKkBzW3FBqydBMQZmSG6vezxZs=;
 b=cVPe5qaFp+zC2x3qb9NHbnEklNwpm1Vk0Iw9f6eq2wxhOdgIjbErIG2FGpT7scZ0L0xGWJI3dN8I6L6jTJ/BtGaOjRWhq+YvZt5XuRPfAswVnzTVfhlpG3UPYkwzlvW7kVV41K6E7OPEMHWRMTulDu1e8P4vUDFfCsB8AD9IIO7tv/BkD5KYwYDzFPqDJUfm/YbP/J2Yf+rw6HEOUjchO/st1jCZxvrRg2siaupld5ug9kgQbxVvNbNOkJECgQyRqNM38uvSAemuI40neXmylZrIV9mUVg/lmWhZ1P5PjfTu6JK1F3Me7cefqfygvFS10/T/351FCMKGack1Xv+0bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XfLjh+ApBY/nPWTjERKkBzW3FBqydBMQZmSG6vezxZs=;
 b=GJ48CMd4kLb3wS/JdSvOuQj1Xx0wGwWix/f4TXUEpuE8M9m/b0nLgqq27i6spucpKCiQDVRYFSA+APzaFXUmjQhKKLmUaqzvwCV7UKA1muy89dNoAezqcUHc78cyRUYjGV3RDn2lfs6YQN8VSd7cxA4xzwng03VLqbSwXKr32UtVViWSSfUqIR6Ykbv99yJ0rrJLNmhSNcqnRAK+LeUMcJMQesKny468bi7fiu2cHeoMxvR2HNIbkLKOp2D1SY6qL9aNn/7risDC93cfQ6JYXB+VwYLjw6VrUJ+Iv4UnsAx78jIkVfjitLnHVY8CzzrYPkJa6C8ziFdXJlQJwf/aXw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8957.eurprd04.prod.outlook.com (2603:10a6:102:20c::5)
 by AS8PR04MB8261.eurprd04.prod.outlook.com (2603:10a6:20b:3b1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Fri, 9 Jan
 2026 15:28:53 +0000
Received: from PAXPR04MB8957.eurprd04.prod.outlook.com
 ([fe80::9c5d:8cdf:5a78:3c5]) by PAXPR04MB8957.eurprd04.prod.outlook.com
 ([fe80::9c5d:8cdf:5a78:3c5%3]) with mapi id 15.20.9499.003; Fri, 9 Jan 2026
 15:28:53 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Fri, 09 Jan 2026 10:28:21 -0500
Subject: [PATCH v2 01/11] dmaengine: dw-edma: Add spinlock to protect
 DONE_INT_MASK and ABORT_INT_MASK
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260109-edma_ll-v2-1-5c0b27b2c664@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767972522; l=2083;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=yKF99Tx9lpadPhYSreIAeNag0NgA6KiKL/9dG8d/zNE=;
 b=VltaR4AfwYp/En0IdxTWPYJw+NFYZ0tZwTlQXdoAtkIecKm7psYFmtOMkn1VnoDCks+moxvQp
 /dBOAV9qxNMDuhCZ0UbLh+1W1b2QhGOtsxkTZF6reNzA45XbH/xYlTY
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB8957:EE_|AS8PR04MB8261:EE_
X-MS-Office365-Filtering-Correlation-Id: febc1897-2aeb-4354-90bd-08de4f93cbfd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|7416014|52116014|366016|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SDh3KzdTYzVlQUNiQUViSW5yb3dsS29LSkhQaThJQ1l1L0FVdExna25zRkl0?=
 =?utf-8?B?ekV0M1h6MkN3WWxSRVNNNzNqTVIrOEpkYkk0ZStkNjc3Z1QyK2hrL1RRQ2R3?=
 =?utf-8?B?MlNHTmZ1WGtWZ0VOTVRFM0dLTldTVEVMYm40YkVjQ0hiRTFXN2tuMTBsdlAw?=
 =?utf-8?B?SXJJbXlHSWk2ZXh1L3RtQ0l0b0l4Tlpnc3JCUnYrOCtvSEFBUGFjMDdjbjJm?=
 =?utf-8?B?RU1QRnQvS1JVQmRyT281WkFpK3RQaHVBNHY1RElkUVRrWUdoMnorLzFpNnFB?=
 =?utf-8?B?NW8vRTZEbE5aTzlmTjdCdVhXaWkrem90YlpkN2pIRDZDZXNoaVhYUTBzUzdr?=
 =?utf-8?B?RXUrTkliMURKL0pkbVVPeUk3dWFpZ3pSb1dLcTYvOTFwY1JjdW9uNFY3eUty?=
 =?utf-8?B?T0tiZzVYMnNpTmtQYUUyaEhEM2JoZ3JvMDZnQkNRaXlpbmtmd2tGdkovOUFi?=
 =?utf-8?B?Ny9reVRlOTdnS0RUUjNmZDJkU2szaUVFYU1YdEM5K2o1OXZTenoxVkZyWmsy?=
 =?utf-8?B?MERnTElwcXpDWmZoRXRGQWQvMWpzWnBIZGNuK3RhZEozTHRzL2krOUkxMGVZ?=
 =?utf-8?B?SFZyQnJPd1NOdW1kTFphMVcwS3NBMksrZ1ZtQmhzQWJJUHJJZDZ1VGVsb25U?=
 =?utf-8?B?cHFybGhuZmYrUDJrZzBVVlFpYjNVc0h4R0hXaGN2eG9ReHpVNHFCRyt1VlRI?=
 =?utf-8?B?V0NPN1RheHR0cTV4ck9iVmpGdlg4eGFYNEdhcnN2WGlCbEZpQjVBcy9hR1Az?=
 =?utf-8?B?WHY5OTE3aGlrZHpVRlF1M0NHYURqOUdybTRJRmxCRDJIRWV3MFp5VzF3ZmRJ?=
 =?utf-8?B?cHpGSWhzSVZ4OUxnWlJzZ3lkSmdCN3ptMFROSXhORDJINVd4RFV6Skwxb0E2?=
 =?utf-8?B?YWk2ak5OK3ZhSmNOSi91S1N6eExGeGNmL1BaT1R2L3NlS0UzV3VtNTRjZGJk?=
 =?utf-8?B?NUp2Zy9pak5oM2xoUGlOSGYxbWw3dXFwVWcxYXljYnVzTTQxaS9adFYwR3F5?=
 =?utf-8?B?NktWT3VnMnJIS044bEVzY1JMeXFNTmtGMUh6VGtSVHpVQ3ZtZ3NwQTFwL3I3?=
 =?utf-8?B?R3hkT0t3WHUybWt6SlZVZWxBWVJjK1NPajlheVdzUHMySDBkdmtMRlI2S0Jj?=
 =?utf-8?B?b0FWWEFsQVVJREc4c1E5Y0RXQ2E1Um82bTlJUkltaVhjUWJ2Sk5XOWZkcmdp?=
 =?utf-8?B?bVkyK2c5ZmcxaWFjekIyN1lkS0QzQS9FcVFsdjJ1KzArSGZXWmc4RSsybWhz?=
 =?utf-8?B?NmVPazJaQUpNd1lOT0JOTVRCa2N3RWx2TnVBbG10SXpKakwvb2dNL2RKL0Nj?=
 =?utf-8?B?Z2pRUWtWV0tsbWVCRGVxWTZWcU1lTnpVZlE5VkpTRkdCeXFZL3k3U1ptRSt4?=
 =?utf-8?B?NWVXamFrQk02T0J3YnY1MWhJaWdDRS9uRHI4Z0ppR2hnNndUVzR6d2YrVjNV?=
 =?utf-8?B?SVlURGFVaGhlRTdDQXVveW5STXRGOHhqZGQyMVU1cExFckVHcEFKdklEQ3p3?=
 =?utf-8?B?aDRVY1hGRkZVa1ZHWHNDSEVtUU5FNlEvUDY0TlBMZnIzWTZBUzMvTkFYOURz?=
 =?utf-8?B?L0RnTUw4VnVUd0F4Q3BxWksxQ2RwNlZkcG1rajVaR2FObGgwNlJTYWdOZEdV?=
 =?utf-8?B?TGNsY2ZyYUU3RjkyaWxZRG5mTmIzSHNRL0NnSXZtNTBRWnk5ZjBkdU03ZmI2?=
 =?utf-8?B?UzBsUjRpdHZuZFRZbWRqeU1vMkpGWTljVTAxKzZJQ1kxMGtuai9YYURWZlN2?=
 =?utf-8?B?MUFsaXVaU1lpc2F0RjAzcWd5VEI3ZGduVWZkRzl0NlFRZnM4dlVIMHhkY0lB?=
 =?utf-8?B?Q1dtckVmMFZVKzhBc3BpR1dIWHlRY0EwY2pIbVhJZHMrMzZUbm00NkgyUDZu?=
 =?utf-8?B?YXJtclViYm1tdmhUSkdrOGdEUDNZa1JCcXpGdEFoUjNINE16cGUwUnR0OG1u?=
 =?utf-8?B?anUyMFdrMzgzZ05BVmpZM2l2TDczellhajdPSGJia216S3lCdEUvYjlMTVhV?=
 =?utf-8?B?Um9vYi9OWkYrcmQ1bDBCbUdVOVNsalNMZnhpQTkycHJCZFlWamJodEcvWFF4?=
 =?utf-8?B?dUJvNHpoQ1V0T0FSeVVLaHlHTUxDb3dLalJXQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8957.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(7416014)(52116014)(366016)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZXNEdG9OV3RjSkF6bDJReWp0c0tyY0dhdzhuTVhDeDgyRkVuUENybUEyVnZC?=
 =?utf-8?B?NG4zQTVidnRHWGIvYU5oVmlzbnU5bEZIY2p2Mlpud28wd09GZUdWL0dseHAy?=
 =?utf-8?B?eTJUTktvblh0cW52ZXpjUVA2ZFc3TXBEQmpjM280ZW5SWHkwdm95QVc3MnU4?=
 =?utf-8?B?bUYvVWVibmxnTHFNWFk3bk5TUitzbEk4d1BsZE5GMG5hQTczOWNwTENiVndL?=
 =?utf-8?B?c3VRcUltb2lLekNzeVlNQTFmWUxUdkZ3S1d2NU9aMFVZRGNOaUpKNHNFMDhH?=
 =?utf-8?B?aUNUOHB0OFltZ3dKWUdRaUtVcUt2S05LQUViWnphVDk4NmhDa0pMNFU2UXRp?=
 =?utf-8?B?Q05QZXBrbTBReE1FRDNLb1NaUUkwVEZWRVVBc3MrcnhmWmYwSXBnekVUYU1o?=
 =?utf-8?B?a2tlR0I3Y05UUDBpaXIvdnAwblk5M3RiaXhZazBETXM3cVpMK29FeTk1OUpO?=
 =?utf-8?B?RDQzdkJSTXZKcDVJbklYalk0QzRHblVaa1NtWEl2SjU1cjl4bllPdGRiMGlV?=
 =?utf-8?B?YjdibWRoVzB4bDJtbGl2V0xyb1g5MDFCOVB5Yk02QmlvWjVtMlZFWHZSMDdY?=
 =?utf-8?B?eTNTbURlKzk4c01pR3dxeVJGTFVORC9GTCtmeEliVUdMbVEwaDBHSWtrNEJQ?=
 =?utf-8?B?R1hXODFndFZCWURtRzhjMHBwdXNWK1EwWjhUVk1uejRMU2RJWE9FcFRYb3pw?=
 =?utf-8?B?cUJHYlNpcXhyTnl2a09qa2dxS3JjQ1ZCaldnQUxXWW1LUnZmTVlDT1ZCam52?=
 =?utf-8?B?VjVrVnNZUi9WUGthZXRHbWtCZkgrSlRmV1N5akJaQnY4VFExYkFUVmxoTlR1?=
 =?utf-8?B?OWUxdWpQNm1QM3h5WFlBT0dpeEdoUW5INVZwb1pIcGhrN3llalVrNC8vRFZS?=
 =?utf-8?B?c29SWFdXOWVSVlZ0a3VWVkRRM1dXZUFvb2Q3NVNtcEdnZWRyekdKbnd3MVo1?=
 =?utf-8?B?bm5COWxxZDl5Vk9WNFZJblJZbmRXcGZUV3ZlYVo4MGRZL3FqWU9SQzRheHNM?=
 =?utf-8?B?dVpScmdpQis5Q1lKdkM5WTNXUTU5TTB4M2w4MWpjUG9NY1c5ekhuRWVNL05w?=
 =?utf-8?B?eS9lZk1mNzZSSXNnenZKTWZORUZ2VU5mVDk4S1l1ZDN1dXRYQUM3TnZZaUtm?=
 =?utf-8?B?Qi9OU2VqUGlVQUpJQnZMUm85RHZtb1l2NGVSeGJGZSt0RDU2ZCtWOHR3bnRa?=
 =?utf-8?B?UXRDTXpGZE5mVXFpNmtRT0RmOWhwS3o3UElXTjZUaUc2SlAxWWJXWjM5UlJP?=
 =?utf-8?B?cUdEdWRJSmF4aVJnMWlIM2dqS0tRTGdqR0k1ZDBYczJYNkxvaThrd21Za3Vu?=
 =?utf-8?B?UHpqMGxtMnNQZW0rTzBNQWVqZnhSNUhpdCtWYWtUYUhibU5xQzA3a2hjaWpj?=
 =?utf-8?B?MFluYkROSFc2NFhJLzVleWdESGRsYzU3WmYyKzJrT3JnVHoyU3V0Y3NhOWVI?=
 =?utf-8?B?a21KYXdSWENqY2JrYk8vVmtmVndFY2JaNGZrQTIyWm1wa08xT2FSMG1pb21m?=
 =?utf-8?B?S2Q1a1pmNXhMZjNLOUxNVElULyt6cVFJWVM4RGpCY1JEVExnOUcwTjViYUx6?=
 =?utf-8?B?OWxQOCsvWEd6UnBVY0xiaWNqVTFMdGVTc1RNR1RScm9Xc1VVSTd4MHFLTU8w?=
 =?utf-8?B?Y2RlWkJKQlZJcFpMbkNDS3N2Q0JFQjZ5Z0Z2OVFFY2tzV2ZtV2lHSXh3N283?=
 =?utf-8?B?VDNBZG5UQy8zN3NicDVFd1JuMmJmN0NMd0tWQmorRTB5YzVrem85SzVyUmkz?=
 =?utf-8?B?TVRtUytDTDhEaGYvRjlpVitLMnZZSVdkTTN3Q2Fqck1UWE15SEluMUw3YXlY?=
 =?utf-8?B?UTZyalpxVzBDRDRlK3R1UTBNSWhZdHE3d2p2bFA1SlpFbmV4TlhIZnU1SzBH?=
 =?utf-8?B?cUdUelFYSUl2LzAwNE1zYTJqanVoSnlORHJWL2NPcEZNSmI3NUZLSmI1Wjhs?=
 =?utf-8?B?VXpGYUxKN003WTJTNzBXNnRYR2JFTGtjeHF6aG1qV3I2SkJEM3YrM0lBN205?=
 =?utf-8?B?UnllUTM3ZzhxTHZ1QW1rMnEzUVZRWGtXanRlUE9WYlV5RTJteDFEb1UxckpX?=
 =?utf-8?B?Tk4wRGlNeklLS21vS2RqLzJOWnNPV2pnYUlyVUxBY2pXamFtQ0dmcXFqSVBu?=
 =?utf-8?B?S3p0a3NJcGRGS2JQcktacFdQdHVPNUR2a0EybFZSYWlOaStZS0NSVmp4dTI0?=
 =?utf-8?B?ajZkMnFRWjJkNDBmSDhTKzdOQUxSOXRFUHh4cndKMFFrRmxDYUU2bG5QM1JH?=
 =?utf-8?B?S0dZWkNMRjZlcGx4NEZMWTFSMHcwdFMzRnd5UlZXQ0Z2RHg1V1BIdC9ndUJl?=
 =?utf-8?B?d20xZ2h6ZndaZHVGR0tsYTBBZTkzU0dyQitsS1FZalIxNXVLTEtvdz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: febc1897-2aeb-4354-90bd-08de4f93cbfd
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8957.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2026 15:28:53.7440
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +cC109r5M6u3bHfofaTUiJJ8kMQng2HVGoZM4yRAC15TE+h1BSSM163qHJHdRUlzGngm+eEWVOv4z8SJr4RSkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8261

The DONE_INT_MASK and ABORT_INT_MASK registers are shared by all DMA
channels, and modifying them requires a read-modify-write sequence.
Because this operation is not atomic, concurrent calls to
dw_edma_v0_core_start() can introduce race conditions if two channels
update these registers simultaneously.

Add a spinlock to serialize access to these registers and prevent race
conditions.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
vc.lock protect should be another problem. This one just fix register
access for difference DMA channel.

Other improve defer to dynamtic append descriptor works later.
---
 drivers/dma/dw-edma/dw-edma-v0-core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
index b75fdaffad9a4ea6cd8d15e8f43bea550848b46c..2850a9df80f54d00789144415ed2dfe31dea3965 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
@@ -364,6 +364,7 @@ static void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
 {
 	struct dw_edma_chan *chan = chunk->chan;
 	struct dw_edma *dw = chan->dw;
+	unsigned long flags;
 	u32 tmp;
 
 	dw_edma_v0_core_write_chunk(chunk);
@@ -408,6 +409,8 @@ static void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
 			}
 		}
 		/* Interrupt unmask - done, abort */
+		raw_spin_lock_irqsave(&dw->lock, flags);
+
 		tmp = GET_RW_32(dw, chan->dir, int_mask);
 		tmp &= ~FIELD_PREP(EDMA_V0_DONE_INT_MASK, BIT(chan->id));
 		tmp &= ~FIELD_PREP(EDMA_V0_ABORT_INT_MASK, BIT(chan->id));
@@ -416,6 +419,9 @@ static void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
 		tmp = GET_RW_32(dw, chan->dir, linked_list_err_en);
 		tmp |= FIELD_PREP(EDMA_V0_LINKED_LIST_ERR_MASK, BIT(chan->id));
 		SET_RW_32(dw, chan->dir, linked_list_err_en, tmp);
+
+		raw_spin_unlock_irqrestore(&dw->lock, flags);
+
 		/* Channel control */
 		SET_CH_32(dw, chan->dir, chan->id, ch_control1,
 			  (DW_EDMA_V0_CCS | DW_EDMA_V0_LLE));

-- 
2.34.1


