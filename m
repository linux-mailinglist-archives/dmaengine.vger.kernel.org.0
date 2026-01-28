Return-Path: <dmaengine+bounces-8564-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UN6pLGlSemnk5AEAu9opvQ
	(envelope-from <dmaengine+bounces-8564-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 28 Jan 2026 19:16:09 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CDC3A79DE
	for <lists+dmaengine@lfdr.de>; Wed, 28 Jan 2026 19:16:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 53F6B30E5128
	for <lists+dmaengine@lfdr.de>; Wed, 28 Jan 2026 18:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 999B43783BD;
	Wed, 28 Jan 2026 18:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="HOQ00DTi"
X-Original-To: dmaengine@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013046.outbound.protection.outlook.com [52.101.72.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FCE737757D;
	Wed, 28 Jan 2026 18:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769623569; cv=fail; b=WHSEqcUxz2n8K0MthNvKV4fJfjpkbopc8idZ5lt/6QlJJpx+ZGVogjgDYRuwI/HJ+zrWQ9tK4o5IZ8xosrG/9+vTEDTRgdiuihoWBLpBUVqf7d47PcRdo48i5h/AmWWudFSiduaPXjRX3KY9Z0Y85FDRW1Akr5Od+hLf4GgFz7Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769623569; c=relaxed/simple;
	bh=wp52EyiRanCFPsgK5reuEw8U6zXbt11wIf1f6ie8hx4=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=T4+bhSdJznHmz5GUG2Rg+jfokWf9YCLhgaOWBG7tyM8V64V1kPsjhwoiAWGqcjcXiYrFcIs+sWbfPSzxoedZvI6hEPJ/5z/eiaaPS4Y63ZkonP5yqi/IeGU0IwaptKrBaebIMrTbFJFo9tWjDYPne9VuuuhvlTQwmy1x48jNXnU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=HOQ00DTi; arc=fail smtp.client-ip=52.101.72.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ENI4NeiAJhEIjxSWYZPjDAmFcGlR3yWCiB9k0SflY978ehvYCEXxgN1NsC2TNCPBHgPW2cCxoeDNRC1aPdERRVXdwqg8kGpDQftGmcz2Jm/PppDpD8zNAO/8lq+yVnhgk1J7dzQUNHgqoqZFPptPvKu0a6Kbwp4qiBLQUXKRMB5hsFM/00oT+4o5nEFQ/T+UWyZP7486levf4rgB3KaY8GwVWo0F6GlNxhqA4Z/7ncjwKd3VxRPPjwrEh7WRUVI47v5aTx1P48P8oy4hB3SPLzqSljG38gAOY14DxF6pLUJ9d5Xy0E0OKOQwjYwpL1uG3Q3awTRqgKZhfnn6NrpwVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7ofYJ1AYEA7Nz2ulM/WPemo7OqILyelNkwtvV7PaKnY=;
 b=quM7JSkYDea9gRsN8oUOoFIa6spGqAUihesc50Oj4+9u/5P3ubATZFjG9n9B82a0JpwzGpf59tGBOmcmpkxPuW1husfULneiZOtTxO6a5/w+Dzyek0awzp0qI6+p8agjN/C7Jc9xn5aI4yh+pcpp/bQlDpBYypecvK+LMFqIJNS7BGseHgYmJEXhonrLXqoMRjCCSKBCw+c1oYM5x1vvtfTONKppFRzfRhDsbpwFcvfPIWqQzC8xPgjC+Z7izm0fBmLy3i6ffk15FmPm1gsUjKtPlXyOckY9ldIftFpTKZFyq7Q2UzdwbhtdunILiVzvutLYk7LL2utkECn6VgsnOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ofYJ1AYEA7Nz2ulM/WPemo7OqILyelNkwtvV7PaKnY=;
 b=HOQ00DTiZseew2yNhObnwTWpQ3GCMnqPDl4iRk+IZLigff2fQnC/qZxns7Y3gQQCVYwZLMnxxhbDvO08dEgHkOnQ3DuDnXYEqW6TX28EpgJFOLqc/xBh5mNbnsnvbBfPaeS8WEMn9e7DVi6BTZWYSKoDsfaJnf/BVn4l7eX02nFVzbXcsPpNnVXqKbN3xqJaSPDLbaWfO5t+Z0CRGBsO4pRa6mrxXLYKMiCu4Q+Jo97WBdeIXBeSp+iftYsqclL/54ZzcKuKKRsrUNbe42oZR1bttYryaNXxouQPqYzc5VcqVqeimWNf3zWhgjHJj4uQgPZzy29/b7YFwbWG6M0fPA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by AM9PR04MB8145.eurprd04.prod.outlook.com (2603:10a6:20b:3e1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.8; Wed, 28 Jan
 2026 18:05:56 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9520.005; Wed, 28 Jan 2026
 18:05:56 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 28 Jan 2026 13:05:25 -0500
Subject: [PATCH RFC 06/12] dmaengine: Move fsl_edma_(alloc|free)_desc() to
 common library
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260128-dma_ll_comlib-v1-6-1b1fa2c671f9@nxp.com>
References: <20260128-dma_ll_comlib-v1-0-1b1fa2c671f9@nxp.com>
In-Reply-To: <20260128-dma_ll_comlib-v1-0-1b1fa2c671f9@nxp.com>
To: Vinod Koul <vkoul@kernel.org>
Cc: linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, 
 imx@lists.linux.dev, joy.zou@nxp.com, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769623546; l=7693;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=wp52EyiRanCFPsgK5reuEw8U6zXbt11wIf1f6ie8hx4=;
 b=KNZHQnbAdPmhLz+rOoJk+ka4CVpaTRuBqlySz4xj6tcPkUmqP4HiDViP6BFsFh/h3qgVbK7oQ
 k6myT0WYf2SCcCuknNTsq5Wdkq14UNjgFGpsS0urWGLz8P7nZ6fJXJo
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SA9PR03CA0009.namprd03.prod.outlook.com
 (2603:10b6:806:20::14) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|AM9PR04MB8145:EE_
X-MS-Office365-Filtering-Correlation-Id: a42a5643-5ad9-41fc-45ef-08de5e97e250
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RitJUEtqKzB1UFJ6cFBaMnRFMEN3aTZpQjlpTHpvUG9sSkF2dHlHK2hKWG93?=
 =?utf-8?B?M2xSRVptdit0alhzS2wrVWoxcXBJNERzdjVuNlo1WmVJRTNuKzZlY1YzaEg3?=
 =?utf-8?B?cEg4Yng5SC81OFJScEs4TXJpNENMajllUGkzREdrUHhWcERRRjh3NXFxOGdn?=
 =?utf-8?B?dHQzRHR6c2pVbVhPeTdyYUNCUE40NE8wM01CdndNOXcyRlNXRFBnNEpXTXp5?=
 =?utf-8?B?RklrT2o3M3NyZUhPdmZ0akRRSGRubjN4bEgwZHVQNmhhMm5qS3JxSXo1RmxP?=
 =?utf-8?B?Ni9RVENNbkZQMWFEMnhMYURLcVA3WGE0ZGw3ci8zbTEwSEZEYUp5eXpPVnZ0?=
 =?utf-8?B?eVBKR0IwRXNWUDJNZnYreTZVK1ZBbVZhSVhiWHBnN25mbjdQaE4yd0k2ZDN2?=
 =?utf-8?B?cGEzZ2x4NDIzVm1mSzNINUJvZVNaNmcwTE42d1VsdEJmR09KSEVKZmliVkxH?=
 =?utf-8?B?c0FSdGtqRHozQm1welExMWJ3K3MzRUZVUGx5bHFJWEFUdEUxbmplaWxpYkRi?=
 =?utf-8?B?U2VhOUJ4d3RsN3ZwYXlQZ0g1RU9laEFsTW9kTkVYZWtXY2o3NjBNMUEweG5o?=
 =?utf-8?B?OGF3aXNJMWUwbzhpbGh2ZHh6aHVmankvcEU3c1ovTi9SalBFYkVLUW01eWdP?=
 =?utf-8?B?akJZV1IvVUljb3ZiMnZ2OWtkcnM0YWhMa3YvWWdJTi9QbHhjM3g1dnNpZEZp?=
 =?utf-8?B?dzcrL2dPR1FJd2lqczBPOStCVHJPNDlFRlhEcDlxZDhBTlhReEZGbkIrQUtx?=
 =?utf-8?B?VlpEUURqaDJUR2lxcGtlNExrVmtRMEdRM29NOEw2VHZLNk1aWlVKRHp5Nm9F?=
 =?utf-8?B?dEo0cVkxUC9hdXpmSkp2ODMyYWhnN0Z6STJHSTJrNE1YY2JjcEZISzRMUi83?=
 =?utf-8?B?bHJwQ280Qy84ZFo3OXRFSzcxV0xtVU40LzE4bUVJVGdZNk1oVTlxN0d1L3NX?=
 =?utf-8?B?Q2NjUklqT251NHo5OERaaENyQlJQRXUrdDFOYTRIakc0cWRrbHZKR200YUxY?=
 =?utf-8?B?bnlYakRCRGtzZk9oS2lFRXh3YVh0RHdyTytnWndGTDVRYm9HaTEydjZaRmFU?=
 =?utf-8?B?TklnSXJUallDY29hRGpQWlQ4VkxQbXQyR0hMUEszUWFzR1hBandnbnRjMHZ3?=
 =?utf-8?B?cDU0dXVMZGtyaE9VT1c2Y3B3ZEdIdkdpajlQM01HbXB0ZHlYL2xTK093UnE2?=
 =?utf-8?B?ZUc5MmQ5NlVqVjhMMGcyejM4Y2lwNTBvcXRYbU05YWs3cVJDY3MwcytwcStM?=
 =?utf-8?B?R1JNRVlHb1gwRjB2Q2plNWlvS0lPeDhpdTJ0TUg0ckJ1dHBqY2J0b3kyKysv?=
 =?utf-8?B?Q283WHAyZTY4bE5XR2w0M3duQ3Y1eXJ3djJja0t2a3hNcktRbFhCb2FJbk05?=
 =?utf-8?B?cmp4WjB5MlNGbVd4Sm9wQlBHbzZSb1Q4UVByZ2x5eGNVSmlFUXU5dGppZk5C?=
 =?utf-8?B?dk1XK2JudENkaThIMWNoZWNiblltdE0zaHBWRnpCbzFOZmpZMmE0VXU3LzV6?=
 =?utf-8?B?UWZhc0llYmVFcUtOaUpsVU1OQmVTRXN2K3VFZmYwY2ZLSzRaRENuWXgrN3hh?=
 =?utf-8?B?Y2R0Yk8yeDRQMEtFVk5pSjZ1TTBuQU9EakV5NCt6WEE1WDZMUS95R0tsV0s2?=
 =?utf-8?B?ZVhKaWNVUkVuQ3lPT2FlM3R1Wm5YM2tydWp5K0doWUQrcVhoT0NtT1ZlZUtx?=
 =?utf-8?B?QitNL2R2VVVIeWxheW40N0ZpRUNHRWlkeld0b3d0L3VUSTdBc29wRU1pLzd5?=
 =?utf-8?B?S2t6SzdHbHc0SjJ2Q1M1SU1XUFNDaTFLYmNYL2ZIY3NOT2pONGNuZjFwaThS?=
 =?utf-8?B?aW1INnlkWStyb2xWZVBoRWtxa1JvbEl5cGVrYVZCV3FhTXdRbWg5bGVrbnI5?=
 =?utf-8?B?cnpuRHFRZ2ZCTmowQmY2MEJJNDRiWVVLTTg0TmRMWHVIVHRER2VsSFJBTURy?=
 =?utf-8?B?eFE0NXVPMVFOUXJwZFJYdm1GL0RqVEVmV3hjV0E2WXlCY3Y5L0RjclRlK1ZX?=
 =?utf-8?B?ZElMV0JrcFZBc1MvWWFoR2swOFI0Zld0VFhZWWVuNkZBTzhZQ1QwK1U5ems2?=
 =?utf-8?B?YmhsbmJNc1l2Y2lTcDNmeHpEdDl6YlJORllCWENmOVZHdDk1eVBCSGZJTnVi?=
 =?utf-8?B?bWFrUituUVFJVlBDME82VGpISC96RVVZS1hWcGtqdzhnc1RMZ2lSSVE0d0cv?=
 =?utf-8?Q?hoGA2N+1ptxfR/YYslqY0uY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SktvT3pQR0xVTTZLenIrcGxMT09KNm5SODEvZ25YaGs5cm54TFNwUDJ2Qjc0?=
 =?utf-8?B?WGVVcGNhZWVSalJiZ1orcXhiYW8rVXBIOHBZdEp2TmFLYzdHY2xuam5YUUx2?=
 =?utf-8?B?QWE1cnhFSHlBNDd0S2UyaFBEd3dmY0VlU084cFd0TUs1WFRKY0ExVFpGaXlR?=
 =?utf-8?B?VjVuS1Y3bFluNTFlTTJXTHZzUTlBOEFSU2Z4RkR6aUp6OVlPQ1p5NFJ0OGEz?=
 =?utf-8?B?Z1dVNWYwVG5kY29oUzNKN0dBYS9lWnRneTYxbHdYU0x1OVgzejBqSE0wRWZ5?=
 =?utf-8?B?czR6dDE1dEVPQnRrVWE1NkIwaTFZWnhBSTVSTC91TUowZkFCWjZYb0hIZ0la?=
 =?utf-8?B?NEZtUmJTeG81bUYxRTJZUmREOXkyVk9hTFVkQmkrUU5sWEErNVhuNHZLa3R2?=
 =?utf-8?B?L1hPNTZOZk01Ky92MUdmYTFuZ1ZBSnVqa1kyMW1XUmZpc256eXE4NmZLdFR4?=
 =?utf-8?B?ZXVuTlEzdDFnQ3hlRVdMVDc0MzVRT1I3bFEyNTJPV1lYTlhHWGlpNEJHYnpo?=
 =?utf-8?B?bjBOaUFDZlFlcElwcVpDSnhqQS9xVTVkL01ydERLUXRjLzNkR012VGU4clAy?=
 =?utf-8?B?NkJYRnpJbkIrQ3JaY3VIWElkSFdnVWJES29mWEdzMUt2QUw2NStMZmtaa0Mw?=
 =?utf-8?B?Y2ptVEZVS3BzeDNtTU1VLzFtR0MrK0FYK3lzWHdvQ0t1cUNLaEdKOSs0djhQ?=
 =?utf-8?B?N0g0TytVSy9yZmZodnU1N1cyNVhOTlA0WlNCUXppa2NTOWNTSUZ6aGJQT2VP?=
 =?utf-8?B?VEdkc3VZNW5GbEgyTWFDRkM1NTJYVlp5eE9vblEzUjk0alpOTTJjbXkvdWQx?=
 =?utf-8?B?algvVUJIU3VBMnRiWnF6Vk03VERVNzBTTEV5Witzd1NNeEdRemlBSUhBbTNL?=
 =?utf-8?B?K3RYdjkyOUxNNUpoK2NwRjl6aS9Ydy9mczhROWQ1bHlHNStQd3IxK0szT0hm?=
 =?utf-8?B?NlpydkNqY2FFSVJuVmVIUjNpNi9USzNpYkRkTDliU0xmeTFXblgrRlFwbytO?=
 =?utf-8?B?UExmT3A1L3RGeXJuZ1NnSVNxSU1oZU52VUtQQnZpemFUMFlPMzdqWmtMN2VM?=
 =?utf-8?B?eE15cFlTQS90WVZiSllCODZOc2FRdnZmTFNYVGlFdzJuMndsaGd1YWRpVTlv?=
 =?utf-8?B?WCtPMEh0ZHVRM1J6ZUsvbGY4VGNmRnRYaDI3MVlLTDFjeTd2ZnFlaFl6cXpq?=
 =?utf-8?B?THQxSVFPSis2Q01ScjljYmFvRVlDRUdSTXNvZWhiNzViakNST1Voa3FqeHBL?=
 =?utf-8?B?WXB6UTRWWHN2NjVlYk9MOGhQbytvN3g5aTd1T2hsSVR6N0F5c2lqWWhlcS9F?=
 =?utf-8?B?T3gzV3lDcElOd05wQjk2RmV1TFZMOFJDaUF2ZzJmQUpuOUU0RlNiSmIydmll?=
 =?utf-8?B?TjB2VkI5TEJFNnQyek1YcjVDMGJKcFUvV3EwakRwODcrcW5VdElDdmltSHQw?=
 =?utf-8?B?K3pEbGJldlpEczEvb0x3eW1mTit3Sk9NMXhKOWhYejMyRUpGN3dmNkZzTTRw?=
 =?utf-8?B?dEpKQndEUmFpdHE5M1pZVVVrZWFPeWxUQ1Z1Rm5ubVl3K2pTSkFwVnUrbVQx?=
 =?utf-8?B?dnFzcDk1UGE1cDg5L3hqMllFcTA5MktWRWo1U2pvQVFyRXZTSUtKay9oY3g4?=
 =?utf-8?B?ZnZiaVBTdUlHYVpMV0xSV1hjd3hBOFplRmxFbC9PeXNPV1BJQVg2RlZqR0ha?=
 =?utf-8?B?QUdLVytTL2RqZXhRU0s2VWdGdERVMmFEaVNKRFRmeXU3R2RmUHpDeVpMWXh3?=
 =?utf-8?B?SVhJM3VSaTFmMVVhOE1ybHVIZExramV6WnluQjhPYlFmZ1p2Z0VhdDJ2b3NO?=
 =?utf-8?B?bld6cllTdjZmV0lWWG5hV05MZmNUOXJEVFdKS2tybnBuM3YvVkRzaWw2dUlK?=
 =?utf-8?B?MVFjd2dJQjl0TzZGVk9WY1V2elFpRDEva3I4OHU4RWNQL2dMTHFQZ3BqSkcy?=
 =?utf-8?B?cGlIWlVLbWF5STcwS2tGVVBHQzZiUmd3enFvamdRWVFUbi9VY2FYd2I4R1Z1?=
 =?utf-8?B?UURYWGt3QVAvVGVmTGhMdXVrSDNqempPMGtwVWg0b2JGR0xEd3FGaTRPV0NF?=
 =?utf-8?B?bXVvUXc3N3YxaGRDZ1d6Q3hlVUlIeEwrdGVWbExaM2ZueUZpd3VoQks1YnJS?=
 =?utf-8?B?Qjdnd21HNFlhdEtOb0NUME9WUHZ5Mzh2VE1nc2JDaGVjdmhRQjNYeThtYXBm?=
 =?utf-8?B?V3M4SmRxL0FybDN5YlNVeUlab3RaQTh1d2hkZ09zeWVHZzZMNGkzTU5mdGc2?=
 =?utf-8?B?T1pVNnRXZ1ZkMW51MkR0RVptczQ5YU52TDBzMnFFeko0WlVMaWNVOXU4NWdK?=
 =?utf-8?B?VUtaRjBtNnNBUEtFbFEvZEVHY21xM3pvS1VYQmlHME5FS0hvd21oZz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a42a5643-5ad9-41fc-45ef-08de5e97e250
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 18:05:56.4792
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zLa0hdSdKaPb1WDRg3WQhADsEhhWe7yDh3WtAeCXDhNKf+FCajKrPMFdZCMrIoEDvfcSjbBvm6XRJymeLoQDNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8145
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	TAGGED_FROM(0.00)[bounces-8564-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.Li@nxp.com,dmaengine@vger.kernel.org];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[nxp.com:+]
X-Rspamd-Queue-Id: 3CDC3A79DE
X-Rspamd-Action: no action

Move fsl_edma_(alloc|free)_desc() to the common DMA link-list library and
rename them to vchan_dma_ll_(alloc|free)_desc().

Remove the "fsl_" prefix from local variables accordingly.

No functional change.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/fsl-edma-common.c | 47 +++----------------------------------------
 drivers/dma/fsl-edma-common.h |  1 -
 drivers/dma/fsl-edma-main.c   |  2 +-
 drivers/dma/ll-dma.c          | 43 +++++++++++++++++++++++++++++++++++++++
 drivers/dma/mcf-edma-main.c   |  2 +-
 drivers/dma/virt-dma.h        |  2 ++
 6 files changed, 50 insertions(+), 47 deletions(-)

diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
index 1b5dcb4c333e7b9a0b1b3bd7964dcff94641bd79..20b954221c2e9b3b3a6849c1f0d4ca68efecb32e 100644
--- a/drivers/dma/fsl-edma-common.c
+++ b/drivers/dma/fsl-edma-common.c
@@ -221,19 +221,6 @@ static unsigned int fsl_edma_get_tcd_attr(enum dma_slave_buswidth src_addr_width
 	return dst_val | (src_val << 8);
 }
 
-void fsl_edma_free_desc(struct virt_dma_desc *vdesc)
-{
-	struct dma_ll_desc *fsl_desc;
-	int i;
-
-	fsl_desc = to_dma_ll_desc(vdesc);
-	for (i = 0; i < fsl_desc->n_its; i++)
-		dma_pool_free(to_virt_chan(vdesc->tx.chan)->ll.pool,
-			      fsl_desc->its[i].vaddr,
-			      fsl_desc->its[i].paddr);
-	kfree(fsl_desc);
-}
-
 int fsl_edma_terminate_all(struct dma_chan *chan)
 {
 	struct fsl_edma_chan *fsl_chan = to_fsl_edma_chan(chan);
@@ -546,34 +533,6 @@ void fsl_edma_fill_tcd(struct fsl_edma_chan *fsl_chan,
 	trace_edma_fill_tcd(fsl_chan, tcd);
 }
 
-static struct dma_ll_desc *
-fsl_edma_alloc_desc(struct fsl_edma_chan *fsl_chan, int sg_len)
-{
-	struct dma_ll_desc *fsl_desc;
-	int i;
-
-	fsl_desc = kzalloc(struct_size(fsl_desc, its, sg_len), GFP_NOWAIT);
-	if (!fsl_desc)
-		return NULL;
-
-	fsl_desc->n_its = sg_len;
-	for (i = 0; i < sg_len; i++) {
-		fsl_desc->its[i].vaddr = dma_pool_alloc(fsl_chan->vchan.ll.pool,
-							GFP_NOWAIT,
-							&fsl_desc->its[i].paddr);
-		if (!fsl_desc->its[i].vaddr)
-			goto err;
-	}
-	return fsl_desc;
-
-err:
-	while (--i >= 0)
-		dma_pool_free(fsl_chan->vchan.ll.pool, fsl_desc->its[i].vaddr,
-			      fsl_desc->its[i].paddr);
-	kfree(fsl_desc);
-	return NULL;
-}
-
 struct dma_async_tx_descriptor *fsl_edma_prep_dma_cyclic(
 		struct dma_chan *chan, dma_addr_t dma_addr, size_t buf_len,
 		size_t period_len, enum dma_transfer_direction direction,
@@ -596,7 +555,7 @@ struct dma_async_tx_descriptor *fsl_edma_prep_dma_cyclic(
 		return NULL;
 
 	sg_len = buf_len / period_len;
-	fsl_desc = fsl_edma_alloc_desc(fsl_chan, sg_len);
+	fsl_desc = vchan_dma_ll_alloc_desc(chan, sg_len);
 	if (!fsl_desc)
 		return NULL;
 	fsl_desc->iscyclic = true;
@@ -679,7 +638,7 @@ struct dma_async_tx_descriptor *fsl_edma_prep_slave_sg(
 	if (!fsl_edma_prep_slave_dma(fsl_chan, direction))
 		return NULL;
 
-	fsl_desc = fsl_edma_alloc_desc(fsl_chan, sg_len);
+	fsl_desc = vchan_dma_ll_alloc_desc(chan, sg_len);
 	if (!fsl_desc)
 		return NULL;
 	fsl_desc->iscyclic = false;
@@ -774,7 +733,7 @@ struct dma_async_tx_descriptor *fsl_edma_prep_memcpy(struct dma_chan *chan,
 	src_bus_width = min_t(u32, DMA_SLAVE_BUSWIDTH_32_BYTES, 1 << (ffs(dma_src) - 1));
 	dst_bus_width = min_t(u32, DMA_SLAVE_BUSWIDTH_32_BYTES, 1 << (ffs(dma_dst) - 1));
 
-	fsl_desc = fsl_edma_alloc_desc(fsl_chan, 1);
+	fsl_desc = vchan_dma_ll_alloc_desc(chan, 1);
 	if (!fsl_desc)
 		return NULL;
 	fsl_desc->iscyclic = false;
diff --git a/drivers/dma/fsl-edma-common.h b/drivers/dma/fsl-edma-common.h
index 56d219d57b852e0769cbead11fadac89913747e2..654d05f06b2c1817e68e7afaf9de3439285d2978 100644
--- a/drivers/dma/fsl-edma-common.h
+++ b/drivers/dma/fsl-edma-common.h
@@ -464,7 +464,6 @@ void fsl_edma_tx_chan_handler(struct fsl_edma_chan *fsl_chan);
 void fsl_edma_disable_request(struct fsl_edma_chan *fsl_chan);
 void fsl_edma_chan_mux(struct fsl_edma_chan *fsl_chan,
 			unsigned int slot, bool enable);
-void fsl_edma_free_desc(struct virt_dma_desc *vdesc);
 int fsl_edma_terminate_all(struct dma_chan *chan);
 int fsl_edma_pause(struct dma_chan *chan);
 int fsl_edma_resume(struct dma_chan *chan);
diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
index a753b7cbfa7a3369d17314bc5bc9139c9f8e5c27..354e4ac5e46c920dd66ec1479a64c75a609c186d 100644
--- a/drivers/dma/fsl-edma-main.c
+++ b/drivers/dma/fsl-edma-main.c
@@ -808,7 +808,7 @@ static int fsl_edma_probe(struct platform_device *pdev)
 		fsl_chan->pm_state = RUNNING;
 		fsl_chan->srcid = 0;
 		fsl_chan->dma_dir = DMA_NONE;
-		fsl_chan->vchan.desc_free = fsl_edma_free_desc;
+		fsl_chan->vchan.desc_free = vchan_dma_ll_free_desc;
 
 		len = (drvdata->flags & FSL_EDMA_DRV_SPLIT_REG) ?
 				offsetof(struct fsl_edma3_ch_reg, tcd) : 0;
diff --git a/drivers/dma/ll-dma.c b/drivers/dma/ll-dma.c
index 3b6de65ae83c070d2ca588abf6bca2c49c1d7bd2..ff9eac43886255c18550c978184c0801456fefe9 100644
--- a/drivers/dma/ll-dma.c
+++ b/drivers/dma/ll-dma.c
@@ -53,6 +53,49 @@ void vchan_dma_ll_free(struct virt_dma_chan *vc)
 }
 EXPORT_SYMBOL_GPL(vchan_dma_ll_free);
 
+struct dma_ll_desc *vchan_dma_ll_alloc_desc(struct dma_chan *chan, u32 n)
+{
+	struct virt_dma_chan *vchan = to_virt_chan(chan);
+	struct dma_ll_desc *desc;
+	u32 i;
+
+	desc = kzalloc(struct_size(desc, its, n), GFP_NOWAIT);
+	if (!desc)
+		return NULL;
+
+	desc->n_its = n;
+
+	for (i = 0; i < n; i++) {
+		desc->its[i].vaddr = dma_pool_alloc(vchan->ll.pool, GFP_NOWAIT,
+						    &desc->its[i].paddr);
+		if (!desc->its[i].vaddr)
+			goto err;
+	}
+
+	return desc;
+
+err:
+	while (--i >= 0)
+		dma_pool_free(vchan->ll.pool, desc->its[i].vaddr,
+			      desc->its[i].paddr);
+	kfree(desc);
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(vchan_dma_ll_alloc_desc);
+
+void vchan_dma_ll_free_desc(struct virt_dma_desc *vdesc)
+{
+	struct dma_ll_desc *desc = to_dma_ll_desc(vdesc);
+	struct virt_dma_chan *vchan = to_virt_chan(vdesc->tx.chan);
+	int i;
+
+	for (i = 0; i < desc->n_its; i++)
+		dma_pool_free(vchan->ll.pool, desc->its[i].vaddr,
+			      desc->its[i].paddr);
+	kfree(desc);
+}
+EXPORT_SYMBOL_GPL(vchan_dma_ll_free_desc);
+
 int vchan_dma_ll_terminate_all(struct dma_chan *chan)
 {
 	struct virt_dma_chan *vchan = to_virt_chan(chan);
diff --git a/drivers/dma/mcf-edma-main.c b/drivers/dma/mcf-edma-main.c
index 9e1c6400c77be237684855759382d7b7bd2e6ea0..60c5b928ade74d36c8f4206777921544787f6cd8 100644
--- a/drivers/dma/mcf-edma-main.c
+++ b/drivers/dma/mcf-edma-main.c
@@ -196,7 +196,7 @@ static int mcf_edma_probe(struct platform_device *pdev)
 		mcf_chan->edma = mcf_edma;
 		mcf_chan->srcid = i;
 		mcf_chan->dma_dir = DMA_NONE;
-		mcf_chan->vchan.desc_free = fsl_edma_free_desc;
+		mcf_chan->vchan.desc_free = vchan_dma_ll_free_desc;
 		vchan_init(&mcf_chan->vchan, &mcf_edma->dma_dev);
 		mcf_chan->tcd = mcf_edma->membase + EDMA_TCD
 				+ i * sizeof(struct fsl_edma_hw_tcd);
diff --git a/drivers/dma/virt-dma.h b/drivers/dma/virt-dma.h
index e3311be3d917ea1e0d5f4fb0e6781c7d0737c0a5..a15f9e318ca5ec7fd3c4e6fc6864ad3d1dc3eaa5 100644
--- a/drivers/dma/virt-dma.h
+++ b/drivers/dma/virt-dma.h
@@ -277,6 +277,8 @@ int vchan_dma_ll_init(struct virt_dma_chan *vc,
 		      const struct dma_linklist_ops *ops, size_t size,
 		      size_t align, size_t boundary);
 void vchan_dma_ll_free(struct virt_dma_chan *vc);
+struct dma_ll_desc *vchan_dma_ll_alloc_desc(struct dma_chan *chan, u32 n);
+void vchan_dma_ll_free_desc(struct virt_dma_desc *vdesc);
 int vchan_dma_ll_terminate_all(struct dma_chan *chan);
 #endif
 

-- 
2.34.1


