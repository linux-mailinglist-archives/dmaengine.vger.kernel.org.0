Return-Path: <dmaengine+bounces-8673-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2LSCDurXgGnMBwMAu9opvQ
	(envelope-from <dmaengine+bounces-8673-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 02 Feb 2026 17:59:22 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D0A43CF466
	for <lists+dmaengine@lfdr.de>; Mon, 02 Feb 2026 17:59:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 44F613008C16
	for <lists+dmaengine@lfdr.de>; Mon,  2 Feb 2026 16:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A04F37F748;
	Mon,  2 Feb 2026 16:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="kAdhDtI5"
X-Original-To: dmaengine@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010014.outbound.protection.outlook.com [52.101.69.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318762798ED;
	Mon,  2 Feb 2026 16:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770051558; cv=fail; b=k4R0I7p6O1RS+c+XPHFCncawa4Bi/mp8u02sO77Kg7J/nQzEN1d1roMxJ1NiysXaIP0bIzpbG1V8YzbyrmKhua7hibKMer4zwhM1hfD8FKxOGKzfEMmXelMJr74qrG3kNEuX6SNfDZKFiDFSIorRLAqzybva8m4D2TBfVZAgUnw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770051558; c=relaxed/simple;
	bh=i20iA1kBYlm88iWjr0tu1FirHSiWvBDtquQ5UpFge10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gXeNetybHS6zwUuF+Gg6Vtb/yOlgH3z24y9UZ/ZLJ6ElAxxfd0Ymt4K3orSN2xkixiu4eisqTl0Nf4XZXJGBDzHUzJ7xAmHd9SQzLHxpg/VBdS+/SlHAGHR8onQhWs/3nML8Hi3oiZZ3bTYvzqeoCx0h958u2dOcrYk+ji6i9GM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=kAdhDtI5; arc=fail smtp.client-ip=52.101.69.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vApT9BgVaVL02BZ5d8IO0hzorKwMBx30blyvyOdhVqbV3wBS5HS20WIiz1NaKgbfyMlrHZn6c/kMEsSA4xRgbtsYX5SKVPH/UgBx/LD+lyNNKguY2UepLyPYaOosYLji58/yRqBtxCMvTsiV8RmbSWnKEXJDMCkLE9Z/M2sXg83zsvvnCqcCCj8QCOyVwhKB5DbGhZdAEKzNEV5kJrBbWP3Lmq8YB5C3xPyKgEy779aaxl58KgduFXXryffPy60FHSBrYRKN7Jzp8x/5mgGXgeT+dS6O8nwDCKogaU5ymlaUAeD1NMeFuFWYgB+/kZk5b736q3y1O67k/QftoefKuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OrlU0MxvnZf8J2fhFVOPlRtpkq6xPCP0H+Pg7uKwU6E=;
 b=gNUstOHGy+P8avyS3HKxET/dwa+WxdZgdwtDMp/Z5rjKGyeL7zTJfn7tqFlL3vTR0as1UAG0wOfP4V8ZLus3GrnLOPs7vq97n7rsSHKqOoa2HBf9qxZzry6JRt8DU+QYYTAe8xu8OQcy5oGP0abGqpOo7Vly/Y52xKcNgyCErmpfI9ZHCyo5ABVDGVtL9xlRoZlPBp/H9noF6S8Li4ub9UBjm8nsHNPgCN5dlNNp9lzdEybk0k56qyZodc5yuqxqO5dadNvUqFOD9QdsqHGaiD20DL8tRDryzixDGFaakt+9+UUD8d9Zltl641yzI5NxNF9O93IbZu5Wl7rOaQWlgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OrlU0MxvnZf8J2fhFVOPlRtpkq6xPCP0H+Pg7uKwU6E=;
 b=kAdhDtI5RAcvDEPovoT5D3drG92yDQmf+7aupfwBq44tbEfNTtD7tC+v4IWtKkjkpc/xOLOgH8Nk7wR3gjxPat/UNUzt7xS2Puo73q+Zz9Td1MYrQatcqJINkXRrkrEmjzWiUqRdSF07Vsu2C1tENylgrcPiUWNTp+SbaVb2xaCfKUFW1scf/NK76QmpzW89CLspbAGjmlNMeHu1rkndgkS1HV8ztAt5lJzOpw9IxIRNnrKqKmuOPAh+vV+M9gegwLrftrt2fBUHpLzHChrEYpVe/RAfPKdof2Yj4qQ0I2qdTb5+3ZxdEk2FM/mY3HOhVqv9UW7SwiWyimeejyS37A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by AM9PR04MB8539.eurprd04.prod.outlook.com (2603:10a6:20b:436::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.13; Mon, 2 Feb
 2026 16:59:13 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9564.016; Mon, 2 Feb 2026
 16:59:12 +0000
Date: Mon, 2 Feb 2026 11:59:05 -0500
From: Frank Li <Frank.li@nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: vkoul@kernel.org, mani@kernel.org, jingoohan1@gmail.com,
	lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org,
	bhelgaas@google.com, dmaengine@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/7] dmaengine: dw-edma, PCI: dwc: Enable remote use
 of integrated DesignWare eDMA
Message-ID: <aYDX2Y0n8lD/iUcJ@lizhi-Precision-Tower-5810>
References: <20260127033420.3460579-1-den@valinux.co.jp>
 <h3uhcd426u32lmn4ajjcrclabuptiy3d4lmtdbwhtu5ca2dv2s@co5piltmkhx6>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <h3uhcd426u32lmn4ajjcrclabuptiy3d4lmtdbwhtu5ca2dv2s@co5piltmkhx6>
X-ClientProxiedBy: PH0P220CA0026.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:d3::7) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|AM9PR04MB8539:EE_
X-MS-Office365-Filtering-Correlation-Id: c161b8d8-fe81-47d4-3bde-08de627c640f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|7416014|19092799006|366016|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bU16OU93RGFsQytIUmlNSU9FZWVWVkxxblZWYzBKckwvVVlzYkV1ZGdubkZD?=
 =?utf-8?B?b2xQSFlqbEZ4NXZLRkJaWVVWUEdiRkRkZ0c1MjBlNG00d2grMHh4N1Z4aWZL?=
 =?utf-8?B?TjJMbmU5RFU4VEVDTUxrNkh5dTA2bVJGQUt3RUFuYllzNEp5NHkva0tUb2U0?=
 =?utf-8?B?QU90UG1IWlh2QWVzdnZOOTA1MUVVUExlZzVJRlJBRXdFc1dkc1ViTzluck9F?=
 =?utf-8?B?bHd1S3owZVNxdS9JOUxNazJycXlYTjRsL3drM25NSE85Mmx1OENQU3V1K0Zo?=
 =?utf-8?B?TGdyN1UvNGw5Snk3b0J4ck9DVVpNeURhKy9xUmMrSTRnT2puRTRoVVFBM1g3?=
 =?utf-8?B?ZmNYS2YxdTk5RTRMeThiRmNmUlN2SzRwZDU5dFNLWmJjQ0dsRjdTM0hwWGc3?=
 =?utf-8?B?YmNHQy93eHBpY2FBcW5MZnd0NE9RQm1LZ1ZRd2JGa0pURUJKaXR0M3hMMC9Q?=
 =?utf-8?B?Nmw1Wk9LRXNtNzdDdEt1dWt3UXYvcFVlY1I4akJaSm4ySmY5V3FJZld2YnBj?=
 =?utf-8?B?U04xYWJmNDhaQjh6RGtDalJOMnRXQTFOSkN0QnhqOFlJaFYzRlg0cFc4VWRU?=
 =?utf-8?B?Y3BMN0V6dEEwR2ZlNnZ2QkFEU3E1MFcrQkhsdVpxL05sNFVyQzQyQVd3dXlB?=
 =?utf-8?B?WkJISGRNSkYvZDYxN0lvbVRtc0RGd2dzcVllanBoa2ZpUVFWTUNnb3ZFaG9E?=
 =?utf-8?B?Y1Vhd0s4NUFXbVI0cTZjWFVCVXVuM2s5d08wVGE1cUpVTTJxeWZudUREZTB2?=
 =?utf-8?B?L2RJcVpRdit6MVRBUzNDNjNHa0VYNEpiZ0NId3dlMEI2dzZxMGRGZ1FOekk1?=
 =?utf-8?B?T0J6NmYybVNVRkxydGZyZnBTSFJteUlUS1o1RkhFTDhHTEZTVnBzVWcwVm9k?=
 =?utf-8?B?bVhWc2JZUkE4OXFUNmpnNzhJN1RkOFdzY0tBQnpsTkwxbDYvKzdpY1B3SWI1?=
 =?utf-8?B?U25FR0R5R2ErS0c5eXVUWUEyY0UrNm9rRFZoNnRJb1paek1laXRtOEFZQWlq?=
 =?utf-8?B?aUlDZHcvQ1hWV1EybGx3ckVaWTh4M0FERFlXV0dSNHJGZ3lnNFVhQXNoN3V1?=
 =?utf-8?B?Unk5YjJJbmxVQ2NJQlFsVG90TDJrcFIxeTZaMldMNEYySUZFRTFvVlJXQ1E3?=
 =?utf-8?B?TE5xWEFWZ3BiV2NkU3pvTnB3U1ovZ0FQYTBtZ2FwaTg2dUZiWk5HR0pqYW8x?=
 =?utf-8?B?cXVuQjRmeEpZaTNFQlpvUDJTVmdsUjdSaEJLeDM1NHR6eW10UTB5Qk83UGor?=
 =?utf-8?B?RUVGL2IrNHNuSUJNSDMwem9PZi9rVDhnLzFjUkVOTHJMcjF0YlBqRExnaGIz?=
 =?utf-8?B?Y3Z4OHBqdDZUMXdjSU0xOXVFdHhTVWtqWWVVME9PdXZnYkJKVkIxTElsd2xY?=
 =?utf-8?B?aGJEN2VlT1pneE5Kd1NTL2hSeElMTzAzeTRxeU9PanpxY2JPV0Z2ck9UQ1Nv?=
 =?utf-8?B?NDhkYVFMMWxKSWYwNERyNW9Xeit4c3VvVHMxMGVrQmpJWWNZeXBVbktzdEpN?=
 =?utf-8?B?RU52U3VhZTk0cmpXTTZtRGVuQkdpZTJhaXd6SHVVM3EwSUNkWjBSV2NkVm1Q?=
 =?utf-8?B?bW5JQW9vOFljc0JsY1VURk9zYThybk55Q0hac3pQa2l6THU4eHdRQVdpaENp?=
 =?utf-8?B?bGMrNmdMNXNTTWpMc25DSllRRWpqbVlma0sxNXgyeTQrTDdqN3JXK0V4Q0NF?=
 =?utf-8?B?a3RIdlhBM0hRMUpnY0JXWUowUWNaVEZkZDlEdXpTTzZtbXhUZ2JxZHJCUTFs?=
 =?utf-8?B?K212cy90T0pFdnI1QnFrYURVSW0xWjJubTZTa2h0MEFML2RpVzRMRk1BZk1J?=
 =?utf-8?B?Z2h6UDdiQnVSY1NkanBReUVpdVQ0aHl6SjNuK2Rwa012ZHdiR2Y0STAvZGhi?=
 =?utf-8?B?ZEdjRktJZ09vVkREbHJGZksrWjNnbGpsazE4TElzNTdMd2UzTUUxTTlTZm44?=
 =?utf-8?B?a0F0ZVF2elVWVnJWMnlhMWJsR2ZhcWxnNjN4dWF4WTgwM2kvMFlUOXJqR0I1?=
 =?utf-8?B?cjVId1IyMmU1dHlncFFndjVPOUFQaFBpSSs1dDhKM0hqSU11WUNZeWhEdUFm?=
 =?utf-8?B?OXV3RjdicmtKbXZReTVYSWkyL1E0T1dHb1U5MmR3ZU5uVjNQZ0duM2Y2MDNt?=
 =?utf-8?B?YXQvOXZCOGVZZ21Eb29PQW4xRXRBSXVBVUVVazNWYTlPekJzcFV6c3Mza0FC?=
 =?utf-8?Q?wAd4m4pPAz1kvvebe/Ra5D0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(7416014)(19092799006)(366016)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VlhLSk0xd3hLS1JPNmJWclAreTNxVzVlS0xmVWVBWTV5dnpvOUtva0pXTzly?=
 =?utf-8?B?L0dUSEpUOTdhNGk2aEYrTm4zbWZuaktiUTduVEVjdFpxMEM3VXZMZW9wSmo1?=
 =?utf-8?B?bUVZWGhDbTQyQzlVYXh3VHRja2hMdFBzTkNqTWlDS1hZZksyK0RSN3pNYzJJ?=
 =?utf-8?B?S2VnNWY5eWZKN2VmSjNnSVhoVzBnNzU0OStRUFBvNTF1cXdkaDk5RzlkMjVl?=
 =?utf-8?B?Z0hkWVRpZEtaN0JlVTdyNnFJVHd5U3B6eFNXSU9iYW9iSTRLb1RkZGNPVUwy?=
 =?utf-8?B?UWJwTGZ5b0RROFdXSCtRQWIxZ3dHSWZHL1JYNmZlWFNoUHpvaERWS1dVOU0w?=
 =?utf-8?B?c1ZyUVhESkxnTWliSEFQakNBY3FFTE02bXhacFY0Zm9EcWVIUHhjakMzenh6?=
 =?utf-8?B?eEpxRUtVK0JjaVM1ZjFjQzQ1NW9sL1hQd0tVYzltMXBNdVMxS3J5dVBxUHpa?=
 =?utf-8?B?dWF2VnJEdGFXd002WEV0WjZiQzBlL05IeXFiVUlLdWl3QTdxWHhPTFEzWGNR?=
 =?utf-8?B?aGxBOWcwZXZoNDV4R0RuS3l3YURNaFpBaW5pTS8xYmhSV3pNeEtYVGFVSmk1?=
 =?utf-8?B?Sk8xdDdtOTM0VGp6bElTOFRuUWxxOXJTL05hZG96Wk45OUtDUCtIRFUyeDlm?=
 =?utf-8?B?TEU4N1g0MHB2UEk0VzFLY296OTdGNHFyYmJWd05XRUREM1lrMkltVHhHdjVk?=
 =?utf-8?B?end6OUNVQjVzNWRBd0xzWXdNdjJURUpKcVo3NVF6TGxVdFNTVWhmNGNpNFVh?=
 =?utf-8?B?dFZKc2gxL296S0x5VXFEa3VLbzlmZGxpRjdSZ2R3N01nRG1UYTk1ZEwxMjlx?=
 =?utf-8?B?SGdodXJzNXVqOXZzTUp1L0lQR25CSWJRdGxQM0hUWmNKSDRySThuQWxQL2hr?=
 =?utf-8?B?VkhEYzRiWWM2RURmU1JIalBKQ2ZVSWJhaXZIOVc5SDRMRkdqcTlSekM4U2ZJ?=
 =?utf-8?B?UG5DUlhveVRNS1VIczcvcXBEZWZ2bU00dHBINlkyVHFnbFI4ODdJMEVxc0xT?=
 =?utf-8?B?VWppTWwwTGdEUFBlNFdybWhxTVRScU95a09xYWk1dWxRcnJpY09jRU1PNytD?=
 =?utf-8?B?Y3VrUUZQUFQweHlzVUhyL3V2QUNhckNoTThnQWExNXAwV0lxbXZRTUZ3d1lh?=
 =?utf-8?B?akxmQUhxZ0VVTVhkNmF6SVJKLzhwMTdyS3Ivc2tnQi9yQSsxSE9LMjhiVXlh?=
 =?utf-8?B?SVowdXdxT0NaemxhNGF1MUhMaXJJSytOb3poR0M4dEd6eDZWeVJpbkJXNHNU?=
 =?utf-8?B?ejZLSnJWL1NXVlBlc1l4dStmNkhZdUNxK1ZVSitBVkI0NEpESEFMZE1BdjdL?=
 =?utf-8?B?eDFUOW5sdUsrUlE3a2NWK0wyVUdCb2hSMVdwZTlyZnllcUo5R1JOWm5CMkQ2?=
 =?utf-8?B?WktFZTUyMHhRaExqTlA1ZXFiRCtDTnFqR2JTQ1JRQjRZaTREWjhGOFZ0c3dB?=
 =?utf-8?B?N3JWTDJHdUV6bkYxeGRZS2N5SUFpWHd3V0w2YW1za1I5TVBZQ2RPOWlJRFRk?=
 =?utf-8?B?bGxBNFBGQUZxeXlRZjR3ZVRGNjhmSVNqbzF2RVlJaGg3L2RCSDVmQjBYcUNo?=
 =?utf-8?B?Q3NmdEZvY2tQVDJicVVYVmdKUk1jSlBSNEdNQWJTSXQrcE5wNVFaNW14TWdo?=
 =?utf-8?B?Q1FacnZiRlVZdHhBMU1QQmpURWJjaUU3TzhEOHVMZDkzczZycmdiZi9xUUFo?=
 =?utf-8?B?eFliTitXSW5kZnhiV0QvZXlLRmFGOTRCN3lYVStwNTBIemR1WXprVkF3Y2Zm?=
 =?utf-8?B?dWZBUE8rZWFxNG50VWdNN2t5dkhsSEN5dDZtZW4wdmlZNGNkZENLOG1tZWh6?=
 =?utf-8?B?amtUR3U1RTFiaFRqcFhaWHNFWmlESkFpajl3Uk9iVnltaW5SUFFxMU9vMmZW?=
 =?utf-8?B?OEo1QURhWUZLQXNETzlYa2tyVDFhYXI4YjVob3pSTFpYWmlicDU2ZGhmTWxN?=
 =?utf-8?B?Y2hyZnZtbkFDVEVib24rY0Y1Ymx5UU5kaGRtYWM5NjNMTXFvdnJvRXRKU1pS?=
 =?utf-8?B?dE5jZ3NkMHlzems1cVBCRHZPZWE0dkJ6OExvSWY2NS9meG03OTBjZ0UvQW14?=
 =?utf-8?B?Y1liOUNrZzNTdWZTZUtpeGhTT1FYclBIckFWdjR4MmRlaHJTeDgxMHFYTkVo?=
 =?utf-8?B?THp1UWhFN0VLTnErQjBWeU5hQ0FQbXR5QlpCa1JFYWJsUXlFRDFGVEloU0pN?=
 =?utf-8?B?SlFhMHVmLzhXYXBmWXd2Q1V6ZzkzdnNQekxLczNlVkxscnpCK3ZPRGtRS21U?=
 =?utf-8?B?anJDMlRxN3hYTEY3c2dQU0NLTW92WHNONnQ4dFZOZVB5VGpnelNXZFdja0RK?=
 =?utf-8?B?Unh4Y3oyQk02VUdBYVZMMnFFcWh5SG9IOE1hOGk2M21Dc0FmV1ZYdz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c161b8d8-fe81-47d4-3bde-08de627c640f
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 16:59:12.8871
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kmEfdbfb6NpoB9rivhCU7RQlHzYstXxSlGxewO24CmHLqfODWdcc6j9k2sYX/qFkoOZRJi0YsQY82lAsY4WgQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8539
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,google.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-8673-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[nxp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nxp.com:dkim]
X-Rspamd-Queue-Id: D0A43CF466
X-Rspamd-Action: no action

On Sun, Feb 01, 2026 at 11:32:23AM +0900, Koichiro Den wrote:
> On Tue, Jan 27, 2026 at 12:34:13PM +0900, Koichiro Den wrote:
> > Hi,
> >
> > Per Frank Li's suggestion [1], this revision combines the previously posted
> > PCI/dwc helper series and the dmaengine/dw-edma series into a single
> > 7-patch set. This series therefore supersedes the two earlier postings:
> >
> >   - [PATCH 0/5] dmaengine: dw-edma: Add helpers for remote eDMA use scenarios
> >     https://lore.kernel.org/dmaengine/20260126073652.3293564-1-den@valinux.co.jp/
> >   - [PATCH 0/2] PCI: dwc: Expose integrated DesignWare eDMA windows
> >     https://lore.kernel.org/linux-pci/20260126071550.3233631-1-den@valinux.co.jp/
> >
> > [1] https://lore.kernel.org/linux-pci/aXeoxxG+9cFML1sx@lizhi-Precision-Tower-5810/
> >
> > Some DesignWare PCIe endpoint platforms integrate a DesignWare eDMA
> > instance alongside the PCIe controller. In remote eDMA use cases, the host
> > needs access to the eDMA register block and the per-channel linked-list
> > (LL) regions via PCIe BARs, while the endpoint may still boot with a
> > standard EP configuration (and may also use dw-edma locally).
> >
> > This series provides the following building blocks:
> >
> >   * dmaengine: Add an optional dma_slave_caps.hw_id so DMA providers can expose
> >     a provider-defined hardware channel identifier to clients, and report it
> >     from dw-edma. This allows users to correlate a DMA channel with
> >     hardware-specific resources such as per-channel LL regions.
> >
> >   * dmaengine/dw-edma: Add features useful for remote-controlled EP eDMA usage:
> >       - per-channel interrupt routing control (configured via dmaengine_slave_config(),
> >         passing a small dw-edma-specific structure through
> >         dma_slave_config.peripheral_config / dma_slave_config.peripheral_size),
> >       - optional completion polling when local IRQ handling is disabled, and
> >       - notify-only channels for cases where the local side needs interrupt
> > 	notification without cookie-based accounting (i.e. its peer
> > 	prepares and submits the descriptors), useful when host-to-endpoint
> > 	interrupt delivery is difficult or unavailable without it.
> >
> >   * PCI: dwc: Add query-only helper APIs to expose resources of an integrated
> >     DesignWare eDMA instance:
> >       - the physical base/size of the eDMA register window, and
> >       - the per-channel LL region base/size, keyed by transfer direction and
> >         the hardware channel identifier (hw_id).
> >
> > The first real user will likely be the DesignWare backend in the NTB transport work:
> >
> >   [RFC PATCH v4 25/38] NTB: hw: Add remote eDMA backend registry and DesignWare backend
> >   https://lore.kernel.org/linux-pci/20260118135440.1958279-26-den@valinux.co.jp/
> >
> >     (Note: the implementation in this series has been updated since that
> >     RFC v4, so the RFC series will also need some adjustments. I have an
> >     updated RFC series locally and can post an RFC v5 if that would help
> >     review/testing.)
> >
> > Apply/merge notes:
> >   - Patches 1-5 apply cleanly on dmaengine.git next.
> >   - Patches 6-7 apply cleanly on pci.git controller/dwc.
> >
> > Changes in v2:
> >   - Combine the two previously posted series into a single set (per Frank's
> >     suggestion). Order dmaengine/dw-edma patches first so hw_id support
> >     lands before the PCI LL-region helper, which assumes
> >     dma_slave_caps.hw_id availability.
> >
> > Thanks for reviewing,
> >
> >
> > Koichiro Den (7):
> >   dmaengine: Add hw_id to dma_slave_caps
> >   dmaengine: dw-edma: Report channel hw_id in dma_slave_caps
> >   dmaengine: dw-edma: Add per-channel interrupt routing control
> >   dmaengine: dw-edma: Poll completion when local IRQ handling is
> >     disabled
> >   dmaengine: dw-edma: Add notify-only channels support
> >   PCI: dwc: Add helper to query integrated dw-edma register window
> >   PCI: dwc: Add helper to query integrated dw-edma linked-list region
>
>
> Hi Mani, Vinod (and others),
>
> I'd appreciate your thoughts on the overall design of patches 3–5/7 when
> you have a moment.
>
>   - [PATCH v2 3/7] dmaengine: dw-edma: Add per-channel interrupt routing control
>     https://lore.kernel.org/dmaengine/20260127033420.3460579-4-den@valinux.co.jp/
>   - [PATCH v2 4/7] dmaengine: dw-edma: Poll completion when local IRQ handling is disabled
>     https://lore.kernel.org/dmaengine/20260127033420.3460579-5-den@valinux.co.jp/
>   - [PATCH v2 5/7] dmaengine: dw-edma: Add notify-only channels support
>     https://lore.kernel.org/dmaengine/20260127033420.3460579-6-den@valinux.co.jp/
>
> My cover letter might have been too terse, so let me add a bit more context
> and two questions at the end.
>
> (Frank already provided helpful feedback on v1/RFC for Patch 3/7. Thanks, Frank.)
>
>
> Motivation for these three patches
> ----------------------------------
>
>   For remote use of a DMA channel (i.e. the host drives a channel that
>   resides in the endpoint (EP)):
>
>   * The EP initializes its DMA channels during the normal SoC glue
>     driver probe.
>   * It obtains a dma_chan to delegate to the host via the standard
>     dma_request_channel().
>   * It exposes the underlying HW resources to the host ("delegation").
>   * The host also acquires a channel via the standard
>     dma_request_channel(). The underlying HW resource is the same as on the
>     EP side, but it's driven remotely from the host.
>
>   and I'm targeting two operating modes:
>
>   1). Standard use of the remote channel
>
>     * The host submits a transaction and handles its completion, just
>       like a local dmaengine client would. Under the hood, the HW channel
>       resides in the remote EP.
>     * In this scenario, we need to ensure:
>       (a). completion interrupts are delivered only to the host. Or,
>       (b). even if (a) is not possible (i.e. the EP also gets interrupted),
>            the EP must not acknowledge/clear the interrupt status in a way
>            that would race with host.
>
>                                   dmaengine_submit()
>                                           :
>                                           v
>        +----------+                 +----------+
>        | dma_chan |--(delegate)--->: dma_chan :
>        +----------+                 +----------+
>       EP (delegator)              Host (delegatee)
>                                           ^
>                                           :
>                                 completion interrupt
>
>   2). Notify-only channel
>
>     * The host submits a transaction, and the EP gets the interrupt
>       and runs any registered callbacks.
>     * In this scenario, we need to ensure:
>       (a). completion interrupts are delivered only to the EP. Or,
>       (b). even if (a) is not possible (i.e. the host also gets
>            interrupted), the host must not acknowledge/clear the interrupt
>            status in a way that would race with the EP.
>       (c). repeated dmaengine_submit() calls must not get stuck, even
>            though it cannot rely on interrupt-driven transaction status
>            management.

According to RM:

WR_DONE_INT_STATUS
Done Interrupt Status. The DMA write channel has successfully completed the DMA transfer. For
more information, see "Interrupts and Error Handling". Each bit corresponds to a DMA channel. Bit
[0] corresponds to channel 0.
- Enabling: For more information, see "Interrupts and Error Handling".
- Masking: The DMA write interrupt Mask register has no effect on this register.
- Clearing: You must write a 1'b1 to the corresponding channel bit in the DMA write interrupt Clear register
to clear this interrupt bit.

Note: You can write to this register to emulate interrupt generation, during software or hardware testing. A
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
write to the address triggers an interrupt, but the DMA does not set the Done or Abort bits in this register.


So you just need write this register to trigger a fake irq. needn't do
data transfer.

Frank

>       (d). callback can be registered for the dma_chan on the EP.
>
>                                   dmaengine_submit()
>                                           :
>                                           v
>        +----------+                 +----------+
>        | dma_chan |--(delegate)--->: dma_chan :
>        +----------+                 +----------+
>       EP (delegator)              Host (delegatee)
>              ^
>              :
>       completion interrupt
>
>
>   Patch mapping:
>     - (a)(b) are addressed by [PATCH v2 3/7].
>     - (c) is addressed by [PATCH v2 4/7].
>     - (d) is addressed by [PATCH v2 5/7].
>
>
> Questions
> ---------
>
>   1. Are these two use cases (1) and (2) acceptable?
>   2. To support (1) and (2), is the current implementation direction acceptable?
>      Or should this be generalized into a dmaengine API rather than being a
>      dw-edma-core-specific extension?
>
>
> Any feedback would be appreciated.
>
> Kind regards,
> Koichiro
>
>
> >
> >  MAINTAINERS                                  |   2 +-
> >  drivers/dma/dmaengine.c                      |   1 +
> >  drivers/dma/dw-edma/dw-edma-core.c           | 167 +++++++++++++++++--
> >  drivers/dma/dw-edma/dw-edma-core.h           |  21 +++
> >  drivers/dma/dw-edma/dw-edma-v0-core.c        |  26 ++-
> >  drivers/pci/controller/dwc/pcie-designware.c |  74 ++++++++
> >  drivers/pci/controller/dwc/pcie-designware.h |   2 +
> >  include/linux/dma/edma.h                     |  57 +++++++
> >  include/linux/dmaengine.h                    |   2 +
> >  include/linux/pcie-dwc-edma.h                |  72 ++++++++
> >  10 files changed, 398 insertions(+), 26 deletions(-)
> >  create mode 100644 include/linux/pcie-dwc-edma.h
> >
> > --
> > 2.51.0
> >

