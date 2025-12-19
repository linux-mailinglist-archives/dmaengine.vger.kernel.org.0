Return-Path: <dmaengine+bounces-7816-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D031CCE46A
	for <lists+dmaengine@lfdr.de>; Fri, 19 Dec 2025 03:36:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6BFF2301D31E
	for <lists+dmaengine@lfdr.de>; Fri, 19 Dec 2025 02:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 304BB277C9E;
	Fri, 19 Dec 2025 02:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="Gv1R/WVC"
X-Original-To: dmaengine@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023074.outbound.protection.outlook.com [40.107.44.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A1921A453;
	Fri, 19 Dec 2025 02:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766111761; cv=fail; b=I9T8KdI7/qQGeoRBhA8ovOQ9CeMOSHUEeJKzuqey+Mm0rHPL8A9e5VJV48SsNtxqNJn0fH1qNKrf5v0f2ztfH8ocBxtpEWSD8uX/QK74XLiXDMNUF1gDg/pAseFNnfPKMRLOOMcrCnRY8l73NcwgNqAvZyBV14e5pinwr+aBqow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766111761; c=relaxed/simple;
	bh=bzVH0R072n/aXUGxPNguJaTzX4N2tddEhGAMaK3cpag=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=l2hbdO7QCxoTqwTeMFhQ1YfnHWS1G4y2ECRtbOu6dIJJyCXuxdNTAsoS5BMkdxTml8SI+RR3sRkh+HIewabkZ17h+FpkcWc7/d2PEIkgOTwReio4L6G3egW9QPqbx1T5L0qx/N8qnrixkvF9ynWdQC4xYjdTwFo2puzYqgYOTVw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=Gv1R/WVC; arc=fail smtp.client-ip=40.107.44.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NdMApXnozFO7p4zUbvcu+HHBmFVImGndfdhkJ72309jCJMtgGlCwKlPOuWO6ThMPX247PXlqkYQLvGoPfoSA8zbVvPIkvCFKvqDF3KqMiGGKwGFjKlB91w2RieYrTZEMegYZD+ivRnpKtWg1cSs4VegF9TW5qnvyaZKd2aEHH23jSEMvV9rGdTX6e6dbJYdba6prKnlbbx9IcP9PNgZ6OliPA6Oj7m8n6wNPEwWRjSPndVDVSyRelVOi9x7L5JCQYyEtApwLCyiMPa1XXpYGUyjkCB1Mdh9tClAbvRgsV7QaTqM7ogNr3GBfd1J6QzTaiwPrsBPDjPt2ka6AyJqbMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uSV1900P7cTt83TnryloJNl2P/OqzjO/+lcsswWB9kQ=;
 b=AZCeJ0D7M0EgmELw+wnNIdelM9xNZhTl3lNaovmvqPuFZx7eLxQgHZaTniZHcca5p+x5efhNbwzo521Gq5+K1Un6j7TU4/LmbM6uWogOXwiuZr1k7CVXK95bO0eiWdHDtAz6BrVr+hDREowsnJcUh+0skgp83k8ef6yNIpqn1ksOwqy7YuYNKEp6GkTC7CDuxF4ZVKXvdJjKD2X9iC/KlQXHD0h5eIH4EYo79GgsNO40qQGw9aNdroOKjPyj3UKZSz7gzsogZvRi2V3oNB0zTn9PxILLW5KYUkxR6QXMPmsnPpqE2CMU4B4OEqmFMjjoztZ15e1y0lHnq3vp+x4LyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uSV1900P7cTt83TnryloJNl2P/OqzjO/+lcsswWB9kQ=;
 b=Gv1R/WVCxpz1WKTI9oEs/g+G23sltII7gtLL120Iw48Gc2mnEombekk7X9G+up1ZX9hflbri0/LfzeSg59CQwB4Ccpsq22WIL+pVMjl7M2Mf+tQJPWzdefGR1dBD4XkJv0M0f99CuOe0qWSQ8D4e/L3r1n6B418JpUf1Arwl1/zlcLJVdlA/1BlPWL7yJZiExlnFW2iNHq8cHOcwsDpYbB7SR3/8koRcI1xV2ip/ZyAGg8BnHVP+ORT9js/5EYNvi10/tqvqi17zPXQed1tunwW0fjUKL/5XPeenQaR59mBgLjzNlZ2kQ7tdVhsZ1MDBCDgPwv27ECly0AHsRa8gkg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from PUZPR03MB6888.apcprd03.prod.outlook.com (2603:1096:301:100::7)
 by SEYPR03MB8377.apcprd03.prod.outlook.com (2603:1096:101:20b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.9; Fri, 19 Dec
 2025 02:35:51 +0000
Received: from PUZPR03MB6888.apcprd03.prod.outlook.com
 ([fe80::5fc1:b7a:831:340f]) by PUZPR03MB6888.apcprd03.prod.outlook.com
 ([fe80::5fc1:b7a:831:340f%3]) with mapi id 15.20.9434.009; Fri, 19 Dec 2025
 02:35:50 +0000
Message-ID: <65699b22-f273-464c-9999-d2554d89c46f@amlogic.com>
Date: Fri, 19 Dec 2025 10:35:45 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] dma: amlogic: Add general DMA driver for SoCs
Content-Language: en-US
To: Neil Armstrong <neil.armstrong@linaro.org>, Vinod Koul
 <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-amlogic@lists.infradead.org, dmaengine@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20251216-amlogic-dma-v1-0-e289e57e96a7@amlogic.com>
 <20251216-amlogic-dma-v1-2-e289e57e96a7@amlogic.com>
 <c996b317-cda0-46d6-82d1-cd91569341a1@linaro.org>
From: Xianwei Zhao <xianwei.zhao@amlogic.com>
In-Reply-To: <c996b317-cda0-46d6-82d1-cd91569341a1@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0070.apcprd02.prod.outlook.com
 (2603:1096:4:54::34) To PUZPR03MB6888.apcprd03.prod.outlook.com
 (2603:1096:301:100::7)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR03MB6888:EE_|SEYPR03MB8377:EE_
X-MS-Office365-Filtering-Correlation-Id: 992e04d1-886c-468d-2cdf-08de3ea752c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SXk1MWVPdkdhVUZ1dzJiTmtVZEFjaFlDVlZYNVlYRVZLN2UrbXZhbVM4SGdm?=
 =?utf-8?B?dnV6cXJ1amloR2J2ZXdiU3hHcU82eGxPK2RvRVVCSW42Tkg0Y3ZLTktIQXNC?=
 =?utf-8?B?MFBTU1A0cEJwYkx2OHMvZ3hzZDNnZm5UaVlMUjhLQVNQaFA4MnNKNncxeG5O?=
 =?utf-8?B?b3JGSUU5bmQ1ZDArOTlCMW9tNWJ0V0hCNHF3blo1V2xCcWZWWGhJQVNYMEFC?=
 =?utf-8?B?bktrNkxwenFHbGdmTTI5Q1cwaU8wYzU5Z2pHeUtBYkRFbFNId2xVOTZ6ZHc2?=
 =?utf-8?B?ZVVLZDJ4TmZmMVhrbUhxREJpVzVTOVdReklNTmxxRU1lNFFYaDJ5Zzc3OFJV?=
 =?utf-8?B?TU92UWpaaU5sUDI5R0NpV3E0eFNDaVlldXAyTkU3TWc3aWdSSzFVNWkyLzZB?=
 =?utf-8?B?UG9qS2V4Zk9KaEp1RUtPZWtGNUhJTU52WDM5bm9TQ2xleUJoaXV0SnNZOG90?=
 =?utf-8?B?NlFidWdTY0gzSXVuZEhwQjNKSUR4NFdkaGxpZWJOUmY3aC9ac1RLTW0yRzBO?=
 =?utf-8?B?NUNVR1RaOUdrZVM3d1RYVHZvTk1QN3JzNWpweEgwb05zZFppRFRvM3FxSlN2?=
 =?utf-8?B?S3JIY2FBUUhFQ0ZPKzBXL3ozNG1JVC9kUzBuMFM0RkNyQ0NsZ0RIdkdmcVBl?=
 =?utf-8?B?Si8wZ21WT1BWTjdDa0ZmVStmOS9xWnBuNXJaWExaTk1NeUtrTFZFK2ZDMmlp?=
 =?utf-8?B?NUJreDhsb3M0bXo0N1pQVjVPR3pLaENpQ2NackUra0tVcG9tUlkyaWRJV1FO?=
 =?utf-8?B?MVJpU0s0QzVaMUZqWDlkS2lNdlgwT3pEV0llOEFLZytrMUxLV1Ridko2cmtB?=
 =?utf-8?B?YWwxQVFXNDlhcDNGTk10TVRsRTBBeUVSRFo2bXljWmlBUDdabjFwZ2V5cGMx?=
 =?utf-8?B?bC85VzByVkJRbXJBWndnaDJUQlBLT1c5aUlObUJzMGVwMVNuUE9DbVhlWnBS?=
 =?utf-8?B?amFFWlVTWTZ5anpDK1MydGxyYjBJbUNaaDJzK2lJTGNkRktuTkY3Y1lSdWdv?=
 =?utf-8?B?cTlyOXNQUEJmMkdYZVVqM0NWMVlhTERnSmovY2toRmtkQUJ2Mi9PTW1uZEVs?=
 =?utf-8?B?bnpZRVhMMUdkS2x5NXQ2RXQ4RDFuZVpFaUpRcmM1KzJwREpYd29STjluUGdh?=
 =?utf-8?B?b2k3aW9ONFRwaitEdVlkNkt6TXpDZ3pjZTg3MjBjdW85ZXZIWEZScGlpNGQz?=
 =?utf-8?B?bVNxcVNvRkJhMUNnRC9vMGx2MElKdkpKL3YyN0JnaXJkeWZzZW1NRExieUJK?=
 =?utf-8?B?d1FRVUlMcDQzVGoySk9oc3ZsbmdGblpiVHVnREREeFd3MnBSYzA5aGxFbDJ6?=
 =?utf-8?B?T0xkMHhVTzVlRWg5N29kdjAzTlB1azZKalBXVjdXVjNsaXEzb0lIbkcvRzhJ?=
 =?utf-8?B?dFNQMDZLcEEvdDBGNmhmZlhqTUdCQ3drM1ZQRFZtaGZ4ZzUxVklQTG9lNk0x?=
 =?utf-8?B?MVZvTWtMdzVpUHVBSnM5MUZ3NkUwNUpUZ3NrdU9YTmhXTnAzQ0xvUlI2Z2oz?=
 =?utf-8?B?MUZjZEprOHpoZFZnaVplZW51OUczSExFV1QrN3RNNnU2QlpNTVVuT0lRVStC?=
 =?utf-8?B?WHk2aXpHQkx0TXdwcm1oN1NmWDE1cHFLdjNPd3FoeHoxVXFtcVRJdmttcWR5?=
 =?utf-8?B?Sk1EZmtZays4OEI2ZmFaTjR6ZktLbWxKUlgvejBKOGZDeTN5L2theGxGcWRK?=
 =?utf-8?B?SXRWQXZKb2tLTHNpYUovc210Sk5uV1l5ZGtGSWtJSXl1RFNIYVF4cWhnc29S?=
 =?utf-8?B?WWNMSHhxdTYvSzdSVENSWElKaWlDMDZaRW51a2tNend4SzU2SzUvMDAvSXV1?=
 =?utf-8?B?SVprSWF6aUFGM2tSRmdGSzFWWEJxWmNYc25jZ2c2T3UrTnB6cVI0MHU3c3Bh?=
 =?utf-8?B?alpiRGo1SnVjM2UyNnU0UExjMS9Ydmd2UjJoeERBOTVNdlY5MVZWaElsNUI1?=
 =?utf-8?Q?mRej1y+1uTqKA56zAmecw9eiifr7P/2Z?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR03MB6888.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aXRwQjFjcCswbWFmQU1Zem80L2Y4MWtmY3dKNGtySGExTEpWRGgwTVFSeTVS?=
 =?utf-8?B?b3lyYjV5SnpmOWhLOEs4OE9tV3FnVmRpckJxbGYva2F0SlhGTGNUUDFlc1hN?=
 =?utf-8?B?cUNsdTFRQnNob2YzMlBSQVZoVmtHZCtjS21LZFk2OTdGTTJJeXhFNnZNMTV6?=
 =?utf-8?B?bDlCdGxNUm12cnJUbCs1V3hyOUZKcklZTjBlZFd0MVlRUjFnWkxRcmhwdFdh?=
 =?utf-8?B?ZE5wUkIwNWJwalhoY3dWckw1a1BjUWpTZ25vaVNBNEdRbFprSWdRNjNsK1dG?=
 =?utf-8?B?UlFyTENJNEN2ZlE5NWFwR2xsQ3p5M0V2MUcrcFhjeFAySkJLZUpWWXZpaGZO?=
 =?utf-8?B?eFdLeGU0SThDVTIrLzBFUmlCM2c5bHk1eEJ3aXNCWUtreXJhUGxsdW9XSFVy?=
 =?utf-8?B?TEg0N3N6bWhjU2FEWDBvZVhSSE1EaCtqTndPOHlpTHVQRWNYdlVrS3FKcjlp?=
 =?utf-8?B?TmJTeTZ0VHhsQkhXc2lEN1JPYk9jUVB4cXZsWElGN3BvTnl6bnVMYjZyMW9M?=
 =?utf-8?B?OElwNEg1WDZiUGUyYVBxOHVHZXhUbE95Q1Y0NkZoL0VHMDZJdzlWbDVWOUJz?=
 =?utf-8?B?TFdkc2lHRlRlOGFPQmswQytzUmRiL0dQaFlQN0VFVmJwejhmczdOS1o5RmM3?=
 =?utf-8?B?TUx6NHBSZm1GZGNmaXRuNGNPT1RGOWMxRWlGNmx0YlhQcHRURzJzVWUzU0Zz?=
 =?utf-8?B?S1NtU0xJRTBUQVFxV1Bzd2E1ZUVEY2F5aVUxWUVvVE1CdTJsc1RGekMwck5Q?=
 =?utf-8?B?bFcxbzdzd3lxeEp3WkMzTTZDUVV4UFZPaXhHR2hiMmRZdEdzWUFyVlJUajlV?=
 =?utf-8?B?cytaOHdrbDBSeUI3MVlLKzZ6NWN0TlpLSjJlb0pkSUJFUlNZeEdrMjZnQkNr?=
 =?utf-8?B?SjZ4ZGl1b3F3R1J6VmRFaEYwSnJBL1dsVldpMTMvL0NaUVNMV2JDbUVtYUZn?=
 =?utf-8?B?UHhrWkYyNEszcGMwWFFueXd5Mk5IM2hYWXB2eTFsWHRZMTVOM2Q0Z1YxSG1D?=
 =?utf-8?B?UmYwVTJTZ08xVzNWV1gzRDFTSVNhZ2ZVbTRrbTlZTW1JcTdvUkJRalFMcUFI?=
 =?utf-8?B?bzJsTk1kYkdJUTlJYXhrZEtoWE9LYkpOYlJZMkJ0dXlwdWpEY3FXVFhwSE9m?=
 =?utf-8?B?REFzbWF6MjhCZzhoeG9zRzFNMUI5VXVCdDdiSzQrY2lQektFL0FvMG56d2N3?=
 =?utf-8?B?L2dwUEdxcTNiNjk2UWJNZW9rVXNQZGJ2UmQ4ZmowOVgxd2I1NDVhMkpDQkpk?=
 =?utf-8?B?ZjVUYnBLYTFZQnJhYXdzQnREUmVuekNKdExKbkl6QUQ2UHhNT094clRwY1dw?=
 =?utf-8?B?ZTlCYi90OFFJbW5COTJPRkNNVlZQM1ZEei80R09tNjEvVmZxci9xaHRoTUJx?=
 =?utf-8?B?NUhQTzI4VUt4TVpLeTdiRkxPa3VLRzlOak4vbTEydmRNcnNSNDJJMHBoWGll?=
 =?utf-8?B?ditYK21hOUJaMU02YWY1cEhsMWhUVWs0WCtLajB5UzJBSGgyK3pWNWxlUldM?=
 =?utf-8?B?cW5MVjdielN1amhKV2J0blBEQ3ZKZ2RJNXF5S092Rk85UlV3UVI1bkR3QnYw?=
 =?utf-8?B?cjUyOG9lZFZUdG04ekMyYk00M0pDalNiaTNoRGd5NGFFaklHdFNQc3Q0OWlH?=
 =?utf-8?B?RTBEMERTNndFMUJ5RTg4L0IvTU54UlQ0VnljRjZ3TTVGbEM2My9WQnF6VW16?=
 =?utf-8?B?K2ZocUpYWnJFK0pqdVUvK3YwWEFieWFEYnl6S2RiaGw3MnYxbnd6bDFiZTBo?=
 =?utf-8?B?eDk5WXRVWlN0Mi8rR1ppckNuQTFEUVBOQk5aMTVSVUJobFlYckhRTForWU8y?=
 =?utf-8?B?OWNIRWRJa0Qyak1vSXpOM2JFa3VublZYcFNyL0w5NTRIWHorUWxXNkFsa0pp?=
 =?utf-8?B?ejZOL2dzeFdMM0ExQ1RBQ2FPbVNQOENWOXluUnVkTFVDNzZzRzRyR0RnVzM4?=
 =?utf-8?B?d2tRRnhaMEozWWhDeG5HS0hDRUVEZFp2N0hZMXRvTmh0OTFiQkljRGV5dUph?=
 =?utf-8?B?WHREbGtmWDBpbWN2aTdKWHhpNTNNeko2bVRoakRHSDdqeHpJcFpKY2FJRUds?=
 =?utf-8?B?MHdyTnppZ3lTcWpiR2ZrSGNpTm5UMmdFaENKeUxtQmlyUTYyQnJWejNwaUpR?=
 =?utf-8?B?TXc1RGx4RzQyS3pDK0cvNFBoNmVyMjVLeG85N2RyWUt0azRHQk1tZTRieklT?=
 =?utf-8?B?Znp0L0E0NmtyczlHUHE2N1JQa1pkR0pkNXd6VzB6QklYVG9uY2I2UjFjbGpy?=
 =?utf-8?B?TVNZbG1ONUhZelNHNDJjVzVtTlNwdEphMHNIZU1qVjNweFhLZEdVMk1uWkZu?=
 =?utf-8?B?WXFxbnRoVUFKS2VhNG1rRFVCZzZueHI3b0cyMzRWYXQzbG9xRmhrUT09?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 992e04d1-886c-468d-2cdf-08de3ea752c0
X-MS-Exchange-CrossTenant-AuthSource: PUZPR03MB6888.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2025 02:35:50.4467
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WF2MUyn8U+CzWWNsbxP3tvz+P9YGG7j/n0Q/MBzSyPQgE54jPpa9AaYnbfzxbhi64oELW9MAPEPDdkqj53zj1wLy8xpql5a4LPsMQ0DcibQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB8377

Hi Neil,
    Thanks for your reply.

On 2025/12/16 17:09, neil.armstrong@linaro.org wrote:
> [ EXTERNAL EMAIL ]
> 
> Hi,
> 
> On 12/16/25 09:03, Xianwei Zhao via B4 Relay wrote:
>> From: Xianwei Zhao <xianwei.zhao@amlogic.com>
>>
>> Amlogic SoCs include a general-purpose DMA controller that can be used
>> by multiple peripherals, such as I2C PIO and I3C. Each peripheral group
>> is associated with a dedicated DMA channel in hardware.
> 
> PLease add which SoC is concerned, in commoit message and in Kconfig help.
> 

Will add SoC name for support.

>>
>> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
>> ---
>>   drivers/dma/Kconfig       |   8 +
>>   drivers/dma/Makefile      |   1 +
>>   drivers/dma/amlogic-dma.c | 567 
>> ++++++++++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 576 insertions(+)
>>
>> diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
>> index 8bb0a119ecd4..fc7f70e22c22 100644
>> --- a/drivers/dma/Kconfig
>> +++ b/drivers/dma/Kconfig
>> @@ -85,6 +85,14 @@ config AMCC_PPC440SPE_ADMA
>>       help
>>         Enable support for the AMCC PPC440SPe RAID engines.
>>
>> +config AMLOGIC_DMA
>> +     tristate "Amlogic genneral DMA support"
>> +     depends on ARCH_MESON
>> +     select DMA_ENGINE
>> +     select REGMAP_MMIO
>> +     help
>> +       Enable support for the Amlogic general DMA engines.
>> +
>>   config APPLE_ADMAC
>>       tristate "Apple ADMAC support"
>>       depends on ARCH_APPLE || COMPILE_TEST
>> diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
>> index a54d7688392b..fc28dade5b69 100644
>> --- a/drivers/dma/Makefile
>> +++ b/drivers/dma/Makefile
>> @@ -16,6 +16,7 @@ obj-$(CONFIG_DMATEST) += dmatest.o
>>   obj-$(CONFIG_ALTERA_MSGDMA) += altera-msgdma.o
>>   obj-$(CONFIG_AMBA_PL08X) += amba-pl08x.o
>>   obj-$(CONFIG_AMCC_PPC440SPE_ADMA) += ppc4xx/
>> +obj-$(CONFIG_AMLOGIC_DMA) += amlogic-dma.o
>>   obj-$(CONFIG_APPLE_ADMAC) += apple-admac.o
>>   obj-$(CONFIG_ARM_DMA350) += arm-dma350.o
>>   obj-$(CONFIG_AT_HDMAC) += at_hdmac.o
>> diff --git a/drivers/dma/amlogic-dma.c b/drivers/dma/amlogic-dma.c
>> new file mode 100644
>> index 000000000000..40099002d558
>> --- /dev/null
>> +++ b/drivers/dma/amlogic-dma.c
>> @@ -0,0 +1,567 @@
>> +// SPDX-License-Identifier: (GPL-2.0-only OR MIT)
>> +/*
>> + * Copyright (C) 2025 Amlogic, Inc. All rights reserved
>> + * Author: Xianwei Zhao <xianwei.zhao@amlogic.com>
>> + */
>> +
>> +#include <linux/init.h>
>> +#include <linux/bitfield.h>
>> +#include <linux/types.h>
>> +#include <linux/mm.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/clk.h>
>> +#include <linux/device.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/dma-mapping.h>
>> +#include <linux/slab.h>
>> +#include <linux/dmaengine.h>
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/of_dma.h>
>> +#include <linux/list.h>
>> +#include <linux/regmap.h>
>> +#include <asm/irq.h>
>> +#include "dmaengine.h"
>> +
>> +#define RCH_REG_BASE         0x0
>> +#define WCH_REG_BASE         0x2000
>> +/*
>> + * Each rch (read from memory) REG offset  Rch_offset 0x0 each 
>> channel total 0x40
>> + * rch addr = DMA_base + Rch_offset+ chan_id * 0x40 + reg_offset
>> + */
>> +#define RCH_READY            0x0
>> +#define RCH_STATUS           0x4
>> +#define RCH_CFG                      0x8
>> +#define CFG_CLEAR            BIT(25)
>> +#define CFG_PAUSE            BIT(26)
>> +#define CFG_ENABLE           BIT(27)
>> +#define CFG_DONE             BIT(28)
>> +#define RCH_ADDR             0xc
>> +#define RCH_LEN                      0x10
>> +#define RCH_RD_LEN           0x14
>> +#define RCH_PRT                      0x18
>> +#define RCH_SYCN_STAT                0x1c
>> +#define RCH_ADDR_LOW         0x20
>> +#define RCH_ADDR_HIGH                0x24
>> +/* if work on 64, it work with RCH_PRT */
>> +#define RCH_PTR_HIGH         0x28
>> +
>> +/*
>> + * Each wch (write to memory) REG offset  Wch_offset 0x2000 each 
>> channel total 0x40
>> + * wch addr = DMA_base + Wch_offset+ chan_id * 0x40 + reg_offset
>> + */
>> +#define WCH_READY            0x0
>> +#define WCH_TOTAL_LEN                0x4
>> +#define WCH_CFG                      0x8
>> +#define WCH_ADDR             0xc
>> +#define WCH_LEN                      0x10
>> +#define WCH_RD_LEN           0x14
>> +#define WCH_PRT                      0x18
>> +#define WCH_CMD_CNT          0x1c
>> +#define WCH_ADDR_LOW         0x20
>> +#define WCH_ADDR_HIGH                0x24
>> +/* if work on 64, it work with RCH_PRT */
>> +#define WCH_PTR_HIGH         0x28
>> +
>> +/* DMA controller reg */
>> +#define RCH_INT_MASK         0x1000
>> +#define WCH_INT_MASK         0x1004
>> +#define CLEAR_W_BATCH                0x1014
>> +#define CLEAR_RCH            0x1024
>> +#define CLEAR_WCH            0x1028
>> +#define RCH_ACTIVE           0x1038
>> +#define WCH_ACTIVE           0x103C
>> +#define RCH_DONE             0x104C
>> +#define WCH_DONE             0x1050
>> +#define RCH_ERR                      0x1060
>> +#define RCH_LEN_ERR          0x1064
>> +#define WCH_ERR                      0x1068
>> +#define DMA_BATCH_END                0x1078
>> +#define WCH_EOC_DONE         0x1088
>> +#define WDMA_RESP_ERR                0x1098
>> +#define UPT_PKT_SYNC         0x10A8
>> +#define RCHN_CFG             0x10AC
>> +#define WCHN_CFG             0x10B0
>> +#define MEM_PD_CFG           0x10B4
>> +#define MEM_BUS_CFG          0x10B8
>> +#define DMA_GMV_CFG          0x10BC
>> +#define DMA_GMR_CFG          0x10C0
>> +
>> +#define DMA_MAX_LINK         8
>> +#define MAX_CHAN_ID          32
>> +#define SG_MAX_LEN           ((1 << 27) - 1)
>> +
>> +struct aml_dma_sg_link {
>> +#define LINK_LEN             GENMASK(26, 0)
>> +#define LINK_IRQ             BIT(27)
>> +#define LINK_EOC             BIT(28)
>> +#define LINK_LOOP            BIT(29)
>> +#define LINK_ERR             BIT(30)
>> +#define LINK_OWNER           BIT(31)
>> +     u32 ctl;
>> +     u64 address;
>> +     u32 revered;
>> +} __packed;
> 
> PLease make sure __packed is needed
> 

Yes. This is a hardware requirement.

>> +
>> +struct aml_dma_chan {
>> +     struct dma_chan                 chan;
>> +     struct dma_async_tx_descriptor  desc;
>> +     struct aml_dma_dev              *aml_dma;
>> +     struct aml_dma_sg_link          *sg_link;
>> +     dma_addr_t                      sg_link_phys;
>> +     int                             sg_link_cnt;
>> +     int                             data_len;
>> +     enum dma_status                 status;
>> +     enum dma_transfer_direction     direction;
>> +     int                             chan_id;
>> +     /* reg_base (direction + chan_id) */
>> +     int                             reg_offs;
>> +};
>> +
>> +struct aml_dma_dev {
>> +     struct dma_device               dma_device;
>> +     void __iomem                    *base;
>> +     struct regmap                   *regmap;
>> +     struct clk                      *clk;
>> +     int                             irq;
>> +     struct platform_device          *pdev;
>> +     struct aml_dma_chan             *aml_rch[MAX_CHAN_ID];
>> +     struct aml_dma_chan             *aml_wch[MAX_CHAN_ID];
>> +     unsigned int                    chan_nr;
>> +     unsigned int                    chan_used;
>> +     struct aml_dma_chan             aml_chans[]__counted_by(chan_ns);
>> +};
>> +
>> +static struct aml_dma_chan *to_aml_dma_chan(struct dma_chan *chan)
>> +{
>> +     return container_of(chan, struct aml_dma_chan, chan);
>> +}
>> +
>> +static dma_cookie_t aml_dma_tx_submit(struct dma_async_tx_descriptor 
>> *tx)
>> +{
>> +     return dma_cookie_assign(tx);
>> +}
>> +
>> +static int aml_dma_alloc_chan_resources(struct dma_chan *chan)
>> +{
>> +     struct aml_dma_chan *aml_chan = to_aml_dma_chan(chan);
>> +     struct aml_dma_dev *aml_dma = aml_chan->aml_dma;
>> +
>> +     aml_chan->sg_link = dma_alloc_coherent(aml_dma->dma_device.dev,
>> +                                            sizeof(struct 
>> aml_dma_sg_link) * DMA_MAX_LINK,
>> +                                            &aml_chan->sg_link_phys, 
>> GFP_KERNEL);
>> +     if (!aml_chan->sg_link)
>> +             return  -ENOMEM;
>> +
>> +     /* offset is the same RCH_CFG and WCH_CFG */
>> +     regmap_update_bits(aml_dma->regmap, aml_chan->reg_offs + 
>> RCH_CFG, CFG_CLEAR, CFG_CLEAR);
>> +     aml_chan->status = DMA_COMPLETE;
>> +     dma_async_tx_descriptor_init(&aml_chan->desc, chan);
>> +     aml_chan->desc.tx_submit = aml_dma_tx_submit;
>> +     regmap_update_bits(aml_dma->regmap, aml_chan->reg_offs + 
>> RCH_CFG, CFG_CLEAR, 0);
>> +
>> +     return 0;
>> +}
>> +
>> +static void aml_dma_free_chan_resources(struct dma_chan *chan)
>> +{
>> +     struct aml_dma_chan *aml_chan = to_aml_dma_chan(chan);
>> +     struct aml_dma_dev *aml_dma = aml_chan->aml_dma;
>> +
>> +     aml_chan->status = DMA_COMPLETE;
>> +     dma_free_coherent(aml_dma->dma_device.dev,
>> +                       sizeof(struct aml_dma_sg_link) * DMA_MAX_LINK,
>> +                       aml_chan->sg_link, aml_chan->sg_link_phys);
>> +}
>> +
>> +/* DMA transfer state  update how many data reside it */
>> +static enum dma_status aml_dma_tx_status(struct dma_chan *chan,
>> +                                      dma_cookie_t cookie,
>> +                                      struct dma_tx_state *txstate)
>> +{
>> +     struct aml_dma_chan *aml_chan = to_aml_dma_chan(chan);
>> +     struct aml_dma_dev *aml_dma = aml_chan->aml_dma;
>> +     u32 residue, done;
>> +
>> +     regmap_read(aml_dma->regmap, aml_chan->reg_offs + RCH_RD_LEN, 
>> &done);
>> +     residue = aml_chan->data_len - done;
>> +     dma_set_tx_state(txstate, chan->completed_cookie, chan->cookie,
>> +                      residue);
>> +
>> +     return aml_chan->status;
>> +}
>> +
>> +static struct dma_async_tx_descriptor *aml_dma_prep_slave_sg
>> +             (struct dma_chan *chan, struct scatterlist *sgl,
>> +             unsigned int sg_len, enum dma_transfer_direction direction,
>> +             unsigned long flags, void *context)
>> +{
>> +     struct aml_dma_chan *aml_chan = to_aml_dma_chan(chan);
>> +     struct aml_dma_dev *aml_dma = aml_chan->aml_dma;
>> +     struct aml_dma_sg_link *sg_link;
>> +     struct scatterlist *sg;
>> +     int idx = 0;
>> +     u32 reg, chan_id;
>> +     u32 i;
>> +
>> +     if (aml_chan->direction != direction) {
>> +             dev_err(aml_dma->dma_device.dev, "direction not 
>> support\n");
>> +             return NULL;
>> +     }
>> +
>> +     switch (aml_chan->status) {
>> +     case DMA_IN_PROGRESS:
>> +             /* support multiple prep before pending */
>> +             idx = aml_chan->sg_link_cnt;
>> +
>> +             break;
>> +     case DMA_COMPLETE:
>> +             aml_chan->data_len = 0;
>> +             chan_id = aml_chan->chan_id;
>> +             reg = (direction == DMA_DEV_TO_MEM) ? WCH_INT_MASK : 
>> RCH_INT_MASK;
>> +             regmap_update_bits(aml_dma->regmap, reg, BIT(chan_id), 
>> BIT(chan_id));
>> +
>> +             break;
>> +     default:
>> +             dev_err(aml_dma->dma_device.dev, "status error\n");
>> +             return NULL;
>> +     }
>> +
>> +     if (sg_len + idx > DMA_MAX_LINK) {
>> +             dev_err(aml_dma->dma_device.dev,
>> +                     "maximum number of sg exceeded: %d > %d\n",
>> +                     sg_len, DMA_MAX_LINK);
>> +             aml_chan->status = DMA_ERROR;
>> +             return NULL;
>> +     }
>> +
>> +     aml_chan->status = DMA_IN_PROGRESS;
>> +
>> +     for_each_sg(sgl, sg, sg_len, i) {
>> +             if (sg_dma_len(sg) > SG_MAX_LEN) {
>> +                     dev_err(aml_dma->dma_device.dev,
>> +                             "maximum bytes exceeded: %d > %d\n",
>> +                             sg_dma_len(sg), SG_MAX_LEN);
>> +                     aml_chan->status = DMA_ERROR;
>> +                     return NULL;
>> +             }
>> +             sg_link = &aml_chan->sg_link[idx++];
>> +             /* set dma address and len  to sglink*/
>> +             sg_link->address = sg->dma_address;
>> +             sg_link->ctl = FIELD_PREP(LINK_LEN, sg_dma_len(sg));
>> +
>> +             aml_chan->data_len += sg_dma_len(sg);
>> +     }
>> +     aml_chan->sg_link_cnt = idx;
>> +
>> +     return &aml_chan->desc;
>> +}
>> +
>> +static int aml_dma_pause_chan(struct dma_chan *chan)
>> +{
>> +     struct aml_dma_chan *aml_chan = to_aml_dma_chan(chan);
>> +     struct aml_dma_dev *aml_dma = aml_chan->aml_dma;
>> +
>> +     regmap_update_bits(aml_dma->regmap, aml_chan->reg_offs + 
>> RCH_CFG, CFG_PAUSE, CFG_PAUSE);
>> +     aml_chan->status = DMA_PAUSED;
>> +
>> +     return 0;
>> +}
>> +
>> +static int aml_dma_resume_chan(struct dma_chan *chan)
>> +{
>> +     struct aml_dma_chan *aml_chan = to_aml_dma_chan(chan);
>> +     struct aml_dma_dev *aml_dma = aml_chan->aml_dma;
>> +
>> +     regmap_update_bits(aml_dma->regmap, aml_chan->reg_offs + 
>> RCH_CFG, CFG_PAUSE, 0);
>> +     aml_chan->status = DMA_IN_PROGRESS;
>> +
>> +     return 0;
>> +}
>> +
>> +static int aml_dma_terminate_all(struct dma_chan *chan)
>> +{
>> +     struct aml_dma_chan *aml_chan = to_aml_dma_chan(chan);
>> +     struct aml_dma_dev *aml_dma = aml_chan->aml_dma;
>> +     int chan_id = aml_chan->chan_id;
>> +
>> +     aml_dma_pause_chan(chan);
>> +     regmap_update_bits(aml_dma->regmap, aml_chan->reg_offs + 
>> RCH_CFG, CFG_CLEAR, CFG_CLEAR);
>> +
>> +     if (aml_chan->direction == DMA_MEM_TO_DEV)
>> +             regmap_update_bits(aml_dma->regmap, RCH_INT_MASK, 
>> BIT(chan_id), BIT(chan_id));
>> +     else if (aml_chan->direction == DMA_DEV_TO_MEM)
>> +             regmap_update_bits(aml_dma->regmap, WCH_INT_MASK, 
>> BIT(chan_id), BIT(chan_id));
>> +
>> +     aml_chan->status = DMA_COMPLETE;
>> +
>> +     return 0;
>> +}
>> +
>> +static void aml_dma_enable_chan(struct dma_chan *chan)
>> +{
>> +     struct aml_dma_chan *aml_chan = to_aml_dma_chan(chan);
>> +     struct aml_dma_dev *aml_dma = aml_chan->aml_dma;
>> +     struct aml_dma_sg_link *sg_link;
>> +     int chan_id = aml_chan->chan_id;
>> +     int idx = aml_chan->sg_link_cnt - 1;
>> +
>> +     /* the last sg set eoc flag */
>> +     sg_link = &aml_chan->sg_link[idx];
>> +     sg_link->ctl |= LINK_EOC;
>> +     dma_wmb();
>> +     if (aml_chan->direction == DMA_MEM_TO_DEV) {
>> +             regmap_write(aml_dma->regmap, aml_chan->reg_offs + 
>> RCH_ADDR,
>> +                          aml_chan->sg_link_phys);
>> +             regmap_write(aml_dma->regmap, aml_chan->reg_offs + 
>> RCH_LEN, aml_chan->data_len);
>> +             regmap_update_bits(aml_dma->regmap, RCH_INT_MASK, 
>> BIT(chan_id), 0);
>> +             /* for rch (tx) need set cfg 0 to trigger start */
>> +             regmap_write(aml_dma->regmap, aml_chan->reg_offs + 
>> RCH_CFG, 0);
>> +     } else if (aml_chan->direction == DMA_DEV_TO_MEM) {
>> +             regmap_write(aml_dma->regmap, aml_chan->reg_offs + 
>> WCH_ADDR,
>> +                          aml_chan->sg_link_phys);
>> +             regmap_write(aml_dma->regmap, aml_chan->reg_offs + 
>> WCH_LEN, aml_chan->data_len);
>> +             regmap_update_bits(aml_dma->regmap, WCH_INT_MASK, 
>> BIT(chan_id), 0);
>> +     }
>> +}
>> +
>> +static irqreturn_t aml_dma_interrupt_handler(int irq, void *dev_id)
>> +{
>> +     struct aml_dma_dev *aml_dma = dev_id;
>> +     struct aml_dma_chan *aml_chan;
>> +     u32 done, eoc_done, err, err_l, end;
>> +     int i = 0;
>> +
>> +     /* deal with rch normal complete and error */
>> +     regmap_read(aml_dma->regmap, RCH_DONE, &done);
>> +     regmap_read(aml_dma->regmap, RCH_ERR, &err);
>> +     regmap_read(aml_dma->regmap, RCH_LEN_ERR, &err_l);
>> +     err = err | err_l;
>> +
>> +     done = done | err;
>> +
>> +     i = 0;
>> +     while (done) {
>> +             if (done & 1) {
> 
> Use BIT(0)

Will do.

> 
>> +                     aml_chan = aml_dma->aml_rch[i];
>> +                     regmap_write(aml_dma->regmap, CLEAR_RCH, 
>> BIT(aml_chan->chan_id));
>> +                     if (!aml_chan) {
>> +                             dev_err(aml_dma->dma_device.dev, "idx %d 
>> rch not initialized\n", i);
>> +                             continue;
>> +                     }
>> +                     aml_chan->status = (err & (1 << i)) ? DMA_ERROR 
>> : DMA_COMPLETE;
>> +                     /* Make sure to use this for initialization */
>> +                     if (aml_chan->desc.cookie >= DMA_MIN_COOKIE)
>> +                             dma_cookie_complete(&aml_chan->desc);
>> +                     
>> dmaengine_desc_get_callback_invoke(&aml_chan->desc, NULL);
>> +             }
>> +             i++;
>> +             done = done >> 1;
>> +     }
> 
> I would rather iterate on bits or loop with ffs():
> 
> for (i = ffs(done); i; i = ffs(done)) {
>         aml_chan = aml_dma->aml_rch[i - 1];
>         ...
> }
> 
Will do.
for (; done; ) {
	i = ffs(done))
         aml_chan = aml_dma->aml_rch[i - 1];
         ...
	done &=~BIT(i)
  }

>> +
>> +     /* deal with wch normal complete and error */
>> +     regmap_read(aml_dma->regmap, DMA_BATCH_END, &end);
>> +     if (end)
>> +             regmap_write(aml_dma->regmap, CLEAR_W_BATCH, end);
>> +
>> +     regmap_read(aml_dma->regmap, WCH_DONE, &done);
>> +     regmap_read(aml_dma->regmap, WCH_EOC_DONE, &eoc_done);
>> +     done = done | eoc_done;
>> +
>> +     regmap_read(aml_dma->regmap, WCH_ERR, &err);
>> +     regmap_read(aml_dma->regmap, WDMA_RESP_ERR, &err_l);
>> +     err = err | err_l;
>> +
>> +     done = done | err;
>> +     i = 0;
>> +     while (done) {
>> +             if (done & 1) {
>> +                     aml_chan = aml_dma->aml_wch[i];
>> +                     regmap_write(aml_dma->regmap, CLEAR_WCH, 
>> BIT(aml_chan->chan_id));
>> +                     if (!aml_chan) {
>> +                             dev_err(aml_dma->dma_device.dev, "idx %d 
>> wch not initialized\n", i);
>> +                             continue;
>> +                     }
>> +                     aml_chan->status = (err & (1 << i)) ? DMA_ERROR 
>> : DMA_COMPLETE;
>> +                     if (aml_chan->desc.cookie >= DMA_MIN_COOKIE)
>> +                             dma_cookie_complete(&aml_chan->desc);
>> +                     
>> dmaengine_desc_get_callback_invoke(&aml_chan->desc, NULL);
>> +             }
>> +             i++;
>> +             done = done >> 1;
>> +     }
>> +
>> +     return IRQ_HANDLED;
>> +}
>> +
>> +static struct dma_chan *aml_of_dma_xlate(struct of_phandle_args 
>> *dma_spec, struct of_dma *ofdma)
>> +{
>> +     struct aml_dma_dev *aml_dma = (struct aml_dma_dev 
>> *)ofdma->of_dma_data;
>> +     struct aml_dma_chan *aml_chan = NULL;
>> +     u32 type;
>> +     u32 phy_chan_id;
>> +
>> +     if (dma_spec->args_count != 2)
>> +             return NULL;
>> +
>> +     type = dma_spec->args[0];
>> +     phy_chan_id = dma_spec->args[1];
>> +
>> +     if (phy_chan_id >= MAX_CHAN_ID)
>> +             return NULL;
>> +
>> +     if (type == 0) {
> 
> Add or use a define for type
>


Will do.

>> +             aml_chan = aml_dma->aml_rch[phy_chan_id];
>> +             if (!aml_chan) {
>> +                     if (aml_dma->chan_used >= aml_dma->chan_nr) {
>> +                             dev_err(aml_dma->dma_device.dev, "some 
>> dma clients err used\n");
>> +                             return NULL;
>> +                     }
>> +                     aml_chan = &aml_dma->aml_chans[aml_dma->chan_used];
>> +                     aml_dma->chan_used++;
>> +                     aml_chan->direction = DMA_MEM_TO_DEV;
>> +                     aml_chan->chan_id = phy_chan_id;
>> +                     aml_chan->reg_offs = RCH_REG_BASE + 0x40 * 
>> aml_chan->chan_id;
>> +                     aml_dma->aml_rch[phy_chan_id] = aml_chan;
>> +             }
>> +     } else if (type == 1) {
>> +             aml_chan = aml_dma->aml_wch[phy_chan_id];
>> +             if (!aml_chan) {
>> +                     if (aml_dma->chan_used >= aml_dma->chan_nr) {
>> +                             dev_err(aml_dma->dma_device.dev, "some 
>> dma clients err used\n");
>> +                             return NULL;
>> +                     }
>> +                     aml_chan = &aml_dma->aml_chans[aml_dma->chan_used];
>> +                     aml_dma->chan_used++;
>> +                     aml_chan->direction = DMA_DEV_TO_MEM;
>> +                     aml_chan->chan_id = phy_chan_id;
>> +                     aml_chan->reg_offs = WCH_REG_BASE + 0x40 * 
>> aml_chan->chan_id;
>> +                     aml_dma->aml_wch[phy_chan_id] = aml_chan;
>> +             }
>> +     } else {
>> +             dev_err(aml_dma->dma_device.dev, "type %d not 
>> supported\n", type);
>> +             return NULL;
>> +     }
>> +
>> +     return dma_get_slave_channel(&aml_chan->chan);
>> +}
>> +
>> +static int aml_dma_probe(struct platform_device *pdev)
>> +{
>> +     struct device_node *np = pdev->dev.of_node;
>> +     struct dma_device *dma_dev;
>> +     struct aml_dma_dev *aml_dma;
>> +     int ret, i, len;
>> +     u32 chan_nr;
>> +
>> +     const struct regmap_config aml_regmap_config = {
>> +             .reg_bits = 32,
>> +             .val_bits = 32,
>> +             .reg_stride = 4,
>> +             .max_register = 0x3000,
>> +     };
> 
> Please move out of function
> 

Using local variables reduces memory usage, and this pattern is already
being adopted in other modules as well.

>> +
>> +     ret = of_property_read_u32(np, "dma-channels", &chan_nr);
>> +     if (ret)
>> +             return dev_err_probe(&pdev->dev, ret, "failed to read 
>> dma-channels\n");
>> +
>> +     len = sizeof(*aml_dma) + sizeof(struct aml_dma_chan) * chan_nr;
>> +     aml_dma = devm_kzalloc(&pdev->dev, len, GFP_KERNEL);
>> +     if (!aml_dma)
>> +             return -ENOMEM;
>> +
>> +     aml_dma->chan_nr = chan_nr;
>> +
>> +     aml_dma->base = devm_platform_ioremap_resource(pdev, 0);
>> +     if (IS_ERR(aml_dma->base))
>> +             return PTR_ERR(aml_dma->base);
>> +
>> +     aml_dma->regmap = devm_regmap_init_mmio(&pdev->dev, aml_dma->base,
>> +                                             &aml_regmap_config);
>> +     if (IS_ERR_OR_NULL(aml_dma->regmap))
>> +             return PTR_ERR(aml_dma->regmap);
>> +
>> +     aml_dma->clk = devm_clk_get_enabled(&pdev->dev, NULL);
>> +     if (IS_ERR(aml_dma->clk))
>> +             return PTR_ERR(aml_dma->clk);
>> +
>> +     aml_dma->irq = platform_get_irq(pdev, 0);
>> +
>> +     aml_dma->pdev = pdev;
>> +     aml_dma->dma_device.dev = &pdev->dev;
>> +
>> +     dma_dev = &aml_dma->dma_device;
>> +     INIT_LIST_HEAD(&dma_dev->channels);
>> +
>> +     /* Initialize channel parameters */
>> +     for (i = 0; i < chan_nr; i++) {
>> +             struct aml_dma_chan *aml_chan = &aml_dma->aml_chans[i];
>> +
>> +             aml_chan->aml_dma = aml_dma;
>> +             aml_chan->chan.device = &aml_dma->dma_device;
>> +             dma_cookie_init(&aml_chan->chan);
>> +
>> +             /* Add the channel to aml_chan list */
>> +             list_add_tail(&aml_chan->chan.device_node,
>> +                           &aml_dma->dma_device.channels);
>> +     }
>> +     aml_dma->chan_used = 0;
>> +
>> +     dma_set_max_seg_size(dma_dev->dev, SG_MAX_LEN);
>> +
>> +     dma_cap_set(DMA_SLAVE, dma_dev->cap_mask);
>> +     dma_dev->device_alloc_chan_resources = 
>> aml_dma_alloc_chan_resources;
>> +     dma_dev->device_free_chan_resources = aml_dma_free_chan_resources;
>> +     dma_dev->device_tx_status = aml_dma_tx_status;
>> +     dma_dev->device_prep_slave_sg = aml_dma_prep_slave_sg;
>> +
>> +     dma_dev->device_pause = aml_dma_pause_chan;
>> +     dma_dev->device_resume = aml_dma_resume_chan;
>> +     dma_dev->device_terminate_all = aml_dma_terminate_all;
>> +     dma_dev->device_issue_pending = aml_dma_enable_chan;
>> +     /* PIO 4 bytes and I2C 1 byte */
>> +     dma_dev->dst_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_4_BYTES | 
>> DMA_SLAVE_BUSWIDTH_1_BYTE);
>> +     dma_dev->directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV);
>> +     dma_dev->residue_granularity = DMA_RESIDUE_GRANULARITY_BURST;
>> +
>> +     ret = dmaenginem_async_device_register(dma_dev);
>> +     if (ret)
>> +             return ret;
>> +
>> +     ret = of_dma_controller_register(np, aml_of_dma_xlate, aml_dma);
>> +     if (ret)
>> +             return ret;
>> +
>> +     regmap_write(aml_dma->regmap, RCH_INT_MASK, 0xffffffff);
>> +     regmap_write(aml_dma->regmap, WCH_INT_MASK, 0xffffffff);
>> +
>> +     ret = devm_request_irq(&pdev->dev, aml_dma->irq, 
>> aml_dma_interrupt_handler,
>> +                            IRQF_SHARED, dev_name(&pdev->dev), aml_dma);
>> +     if (ret)
>> +             return ret;
>> +
>> +     dev_info(aml_dma->dma_device.dev, "initialized\n");
>> +
>> +     return 0;
>> +}
>> +
>> +static const struct of_device_id aml_dma_ids[] = {
>> +     { .compatible = "amlogic,general-dma", },
>> +     {},
>> +};
>> +MODULE_DEVICE_TABLE(of, aml_dma_ids);
>> +
>> +static struct platform_driver aml_dma_driver = {
>> +     .probe = aml_dma_probe,
>> +     .driver         = {
>> +             .name   = "aml-dma",
>> +             .of_match_table = aml_dma_ids,
>> +     },
>> +};
>> +
>> +module_platform_driver(aml_dma_driver);
>> +
>> +MODULE_DESCRIPTION("GENERAL DMA driver for Amlogic");
>> +MODULE_AUTHOR("Xianwei Zhao <xianwei.zhao@amlogic.com>");
>> +MODULE_ALIAS("platform:aml-dma");
> 
> Unneeded, please drop
> 

Will drop.

>> +MODULE_LICENSE("GPL");
>>
> 
> Neil
> 

