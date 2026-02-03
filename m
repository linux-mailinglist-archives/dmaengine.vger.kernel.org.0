Return-Path: <dmaengine+bounces-8695-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iLcGMhIwgml5QQMAu9opvQ
	(envelope-from <dmaengine+bounces-8695-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 03 Feb 2026 18:27:46 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ABAEDCC80
	for <lists+dmaengine@lfdr.de>; Tue, 03 Feb 2026 18:27:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D33013046755
	for <lists+dmaengine@lfdr.de>; Tue,  3 Feb 2026 17:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D990E2FE59B;
	Tue,  3 Feb 2026 17:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Cv2lA5CI"
X-Original-To: dmaengine@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010005.outbound.protection.outlook.com [52.101.84.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8572D2493;
	Tue,  3 Feb 2026 17:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770139612; cv=fail; b=F36+Ei/jm269l8OnWJ4RPaEqKzI5VbWlIPPRE/xJsQH0dqzb8R5k13J6UeWP4haqrEGlwE0uz7Pet1ouKCFcq2ABkF77cINWlsWK3JMkykMdbGNhH0r3CJwDMQ986QPZeog8FnEvRU3PKX0oXG+cNunEI+2tC0V/dWYG0wjNmaI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770139612; c=relaxed/simple;
	bh=BvAYMMBzYvc6qjzfarsOrgtXc6PC2MqYskpAwtrmlGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jyYfFIs/YAuw0XRwyqoSW+oc2fZ9cmpdz+nm4Hf6C+ZEq5JoELiCdLyER2qZRH69ZriigMsTKLkBmMmYuTeQtbQDcLsVh3WwFxV63x7rfxt/uAo5uenv0XZ/BlJlDGUP/9VgFhMd20MygFLxydX9lBNWBrsWQL8yF8QE7+NqUl0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Cv2lA5CI; arc=fail smtp.client-ip=52.101.84.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZA754Nuw9lx3d79QXPLllb/6AiExkXP0LI4phblffkP4Se8lmDdgj2ZXF00aK4qOXmteWJno3O7+T9wGhNFCBNL/os+7im8C4k//oCQ6tmFSW/zY9skNZJRfY/h8F+c8Tym9m8ZtLpCFhkMnL30t/rnZG4JaMC6DE8kSi6oVjCBrg1L7PtHz9p36fmyw5F8KEbHo9kPIwpRD2oiL9srC2smzl6gS1iRIG0dqJabwrVvQrxbxp/Re+CmQ4FR5hFgamfHlW9JW95K6/JgHqMMWZbNDvc5A2BxsH3BMd2HXqXVUjYD3bod9d5R3uTmAfBmKUVViYsUhV56VBHdGZ719qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pmBKN0PoZo+s24D7Vl+eowlkQb9YrrazL+q0Cp8AHXQ=;
 b=buXKwsK1EAj0dFJNaV12ZibENbR3kCb1rGhm8BAgBuGaYI6q3aHJquPEazLc7FHAs3Ck121NjB2UY3cEkV66sWsLg6/p4alJoZ6eV0qtm+j85Aetg5SF5hihY5Hf9p2gJgHMLNF/E54KbQYUAHMcOLPIxoXOx86Kw/dU+T6dqyoxsoNkxJ2rd6uK6Qwo0X6qyIJsFp+KJFkIgB/wqDSsijbW/7hwdzE2Fkd6LzAEIrcDLRltLT4jt9YXiAS+qzXfaqujcVF50S0pkhkrVhQGKsV6X+MDTYlZQk8CJ+e5OJU39e8LgZGHExcN8g0z55ER61GIj546/xJF4AnKwdXG5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pmBKN0PoZo+s24D7Vl+eowlkQb9YrrazL+q0Cp8AHXQ=;
 b=Cv2lA5CIkUYSXH2WS+OaeQMXuTj1F82v84W4yG9tBqyZXyGVK74pTSCFgNm4DQvKx+TTthSXXctaEkeHs0zhDZ/sbNJY8y8s4mBQyfRyoebEDerEyMkVoVZNhbfgRH6QE28/IRZdzP9vq+kL5IZ9ozqqi8YZbiKV/A9AwEvSCdilJdN1//L1bC83XKHDpqzWPl/cnPOdz7RZXV6787fDJfGGxmucUiS8TupIDL7mydYIx4p3mZkIUVIyVBXvk8ePMuXi8rlcnqxRFiqyACefk6P02/0W7McWSQV9b21kkGITSYdGjeaf2yeVNOBCZ5ECIApCQ7iDb3uYP3dKwmW74g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by PAXPR04MB8240.eurprd04.prod.outlook.com (2603:10a6:102:1c5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Tue, 3 Feb
 2026 17:26:45 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9587.010; Tue, 3 Feb 2026
 17:26:43 +0000
Date: Tue, 3 Feb 2026 12:26:34 -0500
From: Frank Li <Frank.li@nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: vkoul@kernel.org, mani@kernel.org, jingoohan1@gmail.com,
	lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org,
	bhelgaas@google.com, dmaengine@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/7] dmaengine: dw-edma, PCI: dwc: Enable remote use
 of integrated DesignWare eDMA
Message-ID: <aYIvyvHR8s//8STf@lizhi-Precision-Tower-5810>
References: <20260127033420.3460579-1-den@valinux.co.jp>
 <h3uhcd426u32lmn4ajjcrclabuptiy3d4lmtdbwhtu5ca2dv2s@co5piltmkhx6>
 <aYDX2Y0n8lD/iUcJ@lizhi-Precision-Tower-5810>
 <cujofbyvnhwaqpto5pjyxdl3gosat2frixuyhic6tr6zf32rzs@rvtfrcueqq2h>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cujofbyvnhwaqpto5pjyxdl3gosat2frixuyhic6tr6zf32rzs@rvtfrcueqq2h>
X-ClientProxiedBy: PH8PR02CA0014.namprd02.prod.outlook.com
 (2603:10b6:510:2d0::6) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|PAXPR04MB8240:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e3152dc-f351-43db-06a8-08de63496680
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|7416014|376014|366016|19092799006|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eGx1ZTJJQm5xcGdPNDRkYTBpOCtzUUM4TzRZWFBEWGJjSGhERGNKVDYxbVEr?=
 =?utf-8?B?cTJJb1d0MnZQZzZmaWtSa25xLzh3alJRTXJwN0h3amF5YVFuZnpsbUhxU2hz?=
 =?utf-8?B?akUvZnZmem9RaUFCNWRteVUrUGNQM0JFU25uSEI4aENjcVdvZm5ta0pucEtD?=
 =?utf-8?B?L05QRGtSS3RabUVTdnpEbGxuMlBTSEtrd2ZIbkpVOXZVNm1LWThxeHlOanh5?=
 =?utf-8?B?SDJmb0k0eGJ2QkllekJ2dVk3TWhSUHFDN3JET0RIS1grNkF3TU11Ly9GYlJl?=
 =?utf-8?B?eDRnd0RrZ1RaKzlYSzNybEFiRnJJZlBJaHhrdStyVWtzTGwyQWN5YnpNeU1P?=
 =?utf-8?B?VEliLzg3em5tMjlJSUhYY2Z5eWs3d1Z1NW12cVo5aU1xbHNmVTNhZU9yZmVs?=
 =?utf-8?B?eUVyMGVLTmRpUnJSYTZQck5yTGhLc1lZNjUxeUptVDA0U29XRDlUNUY1NmZE?=
 =?utf-8?B?REdUZEJxczNRdUJvUFNhSlVXQ09pSHp2eDludmc3Vi9GOEZPY2dLRG51ZEZU?=
 =?utf-8?B?QU5Rb0pHaDFnbDdHRVV3M0FkOFdMLzlvaFM4cmdCcVZ6NENUTlFVYmc4WUxO?=
 =?utf-8?B?bE5zUkE5ZE9IQ01ZUWE5dHdzQnpiTzhCNkpMMjkzRGNGbFpvUzN6WEtCM0R1?=
 =?utf-8?B?M1FuWFhLa3gyTFNJYVlYMGJKUlJkd1IxWFFrZW1SWWJiUWFOVFNDcXRUd0I0?=
 =?utf-8?B?WUpLTzdwblpwQTE4NGJ6LzV4R3gvaWliY1BGUFdSSHFYSUt6VTcvdTN3NHc5?=
 =?utf-8?B?Z28vVFhrZnVjNjBYdkw5Y1RkMmNDSjU5TnpjTFEzcmxxN3gxVjRKOXkwQU1s?=
 =?utf-8?B?enh4WCtXZ1NIMWYxWVlOR2RJKzN0Tzk0QUt3UFNDR3pqWnRtQlBtWlI5NmF2?=
 =?utf-8?B?OUY2bm5RZU5FckhnNXhLM3R4eEZBdDBjanBGTVBWdFhDNHFXYUcxQ2FNNlZx?=
 =?utf-8?B?aExhcDJGN3RUQmk3bHZscHQyYU1qYXk1R2VnTmRnR1BqMk5BOVlwaDNoRldF?=
 =?utf-8?B?U0JDeDJEa01CUERvZGZDUWQ2YklITnBQODRKZGg0QXE1eDh0QW9wRllRbXNj?=
 =?utf-8?B?WE1VeTBJd3h2RHdVRGlNTysvQUVrYXBNYkhLMjE0YkhMMDVUa2MzVkswOFRX?=
 =?utf-8?B?Vjh3T0lzREJyNDNLQ0dRTHFZM2ZhUkJ0ZEhlc3hRNTVlaEovSnUzSS8xQmRE?=
 =?utf-8?B?S1dTeFpZamIvQ3BRVjgwcEowSk9ldGplWkRPRVQ1enhxZDJUaG5KellpWmd4?=
 =?utf-8?B?SFRVajBoTFBDVUE1TWt1NnNHMUM0ZnQzNENWK2dvTjU1d0lxUC9pb1JZcVNO?=
 =?utf-8?B?OTJmTWp5L3hnQWVkaUVGN05UN0Z0blpmZ3dVS2NMcEM2RWJUelF2d0l2TnZ6?=
 =?utf-8?B?YnozeFJEVTdUcnFOalo1clFjdUlseXd6S3c2bm40NlkyS1dGNFRwUHZ6d0E1?=
 =?utf-8?B?WmkwV0RjeDcrK2NQb01DZHdJK3hYMldYZy9NUnJpUzJSczRncFBLcXpBQ2Qv?=
 =?utf-8?B?WStKWmVEZWE3WFU4M1g0TkJ4K2N0QzhFNGJETFF1UzNXVjRXTHNLTzVnYXpK?=
 =?utf-8?B?WGI5KzJJWTgwZCtIRlRjdFlUTWtheE5pL0ZZMkkwaWtldTlHbzBibHcvTmhw?=
 =?utf-8?B?MzFHNHplMGtrSjl2QnBXMWpwaVROZlpVMUk0eGo5M3Zvb3FnOGhXZDFKNVlm?=
 =?utf-8?B?TUNlUjFsKzh1azdYLzF0KzF2NzZqbU1LS3pIejY0UWdaNG1VTFk2cDZJNHoz?=
 =?utf-8?B?R0trQjhPUC9ZM29CbTZQUEM0SzRLb1dObTV6WFJndUtsT2hUWkpNdTZSMzFU?=
 =?utf-8?B?QUhPTlk2K3JCbzhseXMwY1NQY0VQd1VKZGtSaEN2ZEo1WmF1MGovR0RQQTc4?=
 =?utf-8?B?ays1N1Q0THQ0V0xhdFdVaDBrc0N3RG1kWlloNjZia2xHTGhVNWdrWFV0ZndI?=
 =?utf-8?B?RnpkemJtV1NnOUhhWHdRVnNBM3EycVhJQWVNQlBGVk9BNUZmVU55RzlPbkJp?=
 =?utf-8?B?a3Vka2dESzRmVnd5MDExY0xvNkZyQVRhcDJxK2FUbFBSdU9HcC9USWNYR3gz?=
 =?utf-8?B?RzJmaFUvTFBDNzlSc1YyeFNGTDBNaEN0Y2h4QTBOd25GakZEZDd1eWMyY3Ev?=
 =?utf-8?B?aWk5Z2ljak02YU9QMG5iQzQzTG16QjU2ZWFibWFHaDVRMEpGV1paVlU2NHVw?=
 =?utf-8?Q?7y81v8Eum4iyMWeHADgK8Ns=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(7416014)(376014)(366016)(19092799006)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RTVEV1FNK3pFZDMwZHhUVDcvdGpNQndONmZhdGtzVUlxLzhlbGord0JZeCtn?=
 =?utf-8?B?NzFaaEhwZTdMNUVqcXg4K0NaMjlYaG5IUDNLZTh4NlcrYXNWNk1lVDZZTGdt?=
 =?utf-8?B?RzZDZTNBejJVT2JkeERvQWNPMWdTYm5raC9zU1JmcUNFZnhTL1pKQURqV1g2?=
 =?utf-8?B?bnc5NVBsS2FzaDdHc290QmtRblpjeUFnMm42QlBkempleVB6em9RV1czbjIw?=
 =?utf-8?B?Zmo1Qmh0c09Ta0RDS1VPUThOcnRrUGd6d2JNajM0eVBRWWkrU2QwdTVLZms4?=
 =?utf-8?B?c0V5L3JMaCtQUG9KdkZPZXJyd2VydE12dEVaZHRIRkRESmwwa1Zlb2hzWGhF?=
 =?utf-8?B?akVyMENHSnlNSHQxdmdUQnorTDMxL1JLbUlMckZyMWYxcFRmNXFqVnhySFlm?=
 =?utf-8?B?SVRXaEcwWmhhREpINlZWNFJERlFnUk9WRkNuMmVVbmdNZG8yM1QrS3RGN0NK?=
 =?utf-8?B?bXM5UDVmOS84ZTloSDhMR0Z5SFJBZnpxaVU4dlZqMVdjRWhKaDk3TGVhK1pG?=
 =?utf-8?B?V1Ixb2hzWDN3ZzgwVVdHWE5vcTlnWDdPc0NBUE9SSWxFOEw2L0JGR3loVkF1?=
 =?utf-8?B?YzRMT3gzMlo1b01zWHBNMC9VVlJTditBUnA3Smg3SXdVVUlxSlhpY2lzV0U5?=
 =?utf-8?B?MkorNmo4a2UybG5wcWFoUnhQaEo2ZTUwVDR0eGhOaFNUREM3TEdCMFRuNjJO?=
 =?utf-8?B?Sjg4Sk9VOXVDK3pzQUd5QlhnOXJGalFWRkFwVzdhaXB1SFd1VlB0Y3JBOXpa?=
 =?utf-8?B?Z0VTRXMybFpmV2pnUUwweEJ3N2tQUGx1MjdQeXZRNGRCMXdiSm9TWFdKVlJy?=
 =?utf-8?B?dVd1SVRoekJiYVNhZnFZNi8zNk5HK1FCRXQ2aW1ERk5DOVJrZjBobDJsaERY?=
 =?utf-8?B?RHo3bGRmUVh6aUdVT09KeW9QR1JJVm9EcXZHcGV6aDdqSlJoT0c2RnlDc1hl?=
 =?utf-8?B?N3BHTGNkVkVNcUdyeUNTUHRIakJRQjNHZlNnMk9pZDZuOTl2eGpHQldpY1Zn?=
 =?utf-8?B?b1BDYUJGRGNKaHpuUXQydG1HOGdSNkVGV1k1YXFIM29NTEVGandqK25lOVlS?=
 =?utf-8?B?OTNyUXpGdXA5cmJUNmFkTitRVHNlSHZTZHRvMHpzN2RtelZxU2g1TGdERmFk?=
 =?utf-8?B?aHBJSnE3VnMzUGVFWU1Xdm5XZnV1bnlkMjkwNXhQUjhjNUtnait5VU1VNTVU?=
 =?utf-8?B?RGFRUmoycG9TRURjSzR5ZTkxZFV6Y3NGZ3Jib0UxaHFaRmx1YjlpL2hBb0pH?=
 =?utf-8?B?MldHTGtwdm05TWgzNGsvbW5XeWZ1TkhCY2ZoMzJPL2ZDTGpxS2J2blVTYlBm?=
 =?utf-8?B?NXRSTGt4Q2ZaUjU5b1FaYzhzYTFwZzh0M2xOaklFb2R5MDNhczhGMXpDSVZF?=
 =?utf-8?B?ZmNwcFpiWlhaN0lwMi9XdUY3MU9MV3V1YzhibmIwbXAxUzhyczFReHNpSEJu?=
 =?utf-8?B?NG40alowOWlGQzZtNHFzWmNTNVgrV3JxT1liRzR3T1BnOTN5b05VaDFSOHEv?=
 =?utf-8?B?bEZDMVJhM3Q5S3lLYU1meU9COFBYTkJ6REZvcFlBT2dRbUFxMVpHRjhvRE9I?=
 =?utf-8?B?MUJyYWVGTk1DejYxdnJ4UGZKVXJKOHRNT0VnRDlqRlo1TWNNQUpGS1QwSkZN?=
 =?utf-8?B?WURiRUM3T3M0ZkV2KzhOdyt6aC9MV3lxd1d2VktpditIUzQwbEppd0RlRUM4?=
 =?utf-8?B?eWNWMkdsbmwrdXJwYnQxd3p5M2EzM0l5UklnNDlEWFVkUUNoWDYxcmVLWEEr?=
 =?utf-8?B?ZU0xQVNOK09TVDRlNzhHUy90cHpDT2lZcVhiM0tpcjEwVW5rdE4vKzhZdTh6?=
 =?utf-8?B?d1lMazZhbEZZeTZZZSt2RXhZeTd1TG5YWnZVaEllOTRjaXVJNktzVHN5R1J1?=
 =?utf-8?B?N0h5U2VEWXNQMElodHBQbDh3MnkzL3lsRDQ3aVFWNHVTSTRoTDdYWUM4QXl4?=
 =?utf-8?B?YkVDeVBmWDVvUTV4NWIweE93cFpzdHVPTDc5azJXNE90VVg2aEt0SThOcFIz?=
 =?utf-8?B?VjZnMk1jSlM3ekV0TlI3WXhUYmtLR1lBMHJsQThlWnM5bzN6VTdkZHJjcE93?=
 =?utf-8?B?bVd4Tkk0NDVjOVZpUEo0OTJVczF2MEw4R3pYTG4zVmw0aDRySTVqb0dJaTRl?=
 =?utf-8?B?REJ3WHFBWjdXeml6YjAvVGpXejJVYm5UbHBnd25URzZhNlZiWkJWZEZPeVhv?=
 =?utf-8?B?VFNsZjE5RVpFWmtnOGpocU1BTHhFREJZcFk3UWhjbFU0c0xHMmlYSzF5M0xt?=
 =?utf-8?B?bHg2THBHRm9NV1N3dTJUbFM4dnBwQTRDZ1drVXdzTHQ2ekVsdHlrcWJ1V29N?=
 =?utf-8?Q?EsF2qTw9VeKKzzHUMA?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e3152dc-f351-43db-06a8-08de63496680
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 17:26:43.8334
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F3gWmpxTdgDM1P8pMaPMjzqFdyHvQVCBmyqDN8NAEEerVyctfvPk1wOz6mfnqveg3l3JSRfvYiQhd5wjzKCyTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8240
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,google.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8695-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 8ABAEDCC80
X-Rspamd-Action: no action

On Tue, Feb 03, 2026 at 10:59:10AM +0900, Koichiro Den wrote:
> On Mon, Feb 02, 2026 at 11:59:05AM -0500, Frank Li wrote:
> > On Sun, Feb 01, 2026 at 11:32:23AM +0900, Koichiro Den wrote:
> > > On Tue, Jan 27, 2026 at 12:34:13PM +0900, Koichiro Den wrote:
> > > > Hi,
> > > >
> > > > Per Frank Li's suggestion [1], this revision combines the previously posted
> > > > PCI/dwc helper series and the dmaengine/dw-edma series into a single
> > > > 7-patch set. This series therefore supersedes the two earlier postings:
> > > >
> > > >   - [PATCH 0/5] dmaengine: dw-edma: Add helpers for remote eDMA use scenarios
> > > >     https://lore.kernel.org/dmaengine/20260126073652.3293564-1-den@valinux.co.jp/
> > > >   - [PATCH 0/2] PCI: dwc: Expose integrated DesignWare eDMA windows
> > > >     https://lore.kernel.org/linux-pci/20260126071550.3233631-1-den@valinux.co.jp/
> > > >
> > > > [1] https://lore.kernel.org/linux-pci/aXeoxxG+9cFML1sx@lizhi-Precision-Tower-5810/
> > > >
> > > > Some DesignWare PCIe endpoint platforms integrate a DesignWare eDMA
> > > > instance alongside the PCIe controller. In remote eDMA use cases, the host
> > > > needs access to the eDMA register block and the per-channel linked-list
> > > > (LL) regions via PCIe BARs, while the endpoint may still boot with a
> > > > standard EP configuration (and may also use dw-edma locally).
> > > >
> > > > This series provides the following building blocks:
> > > >
> > > >   * dmaengine: Add an optional dma_slave_caps.hw_id so DMA providers can expose
> > > >     a provider-defined hardware channel identifier to clients, and report it
> > > >     from dw-edma. This allows users to correlate a DMA channel with
> > > >     hardware-specific resources such as per-channel LL regions.
> > > >
> > > >   * dmaengine/dw-edma: Add features useful for remote-controlled EP eDMA usage:
> > > >       - per-channel interrupt routing control (configured via dmaengine_slave_config(),
> > > >         passing a small dw-edma-specific structure through
> > > >         dma_slave_config.peripheral_config / dma_slave_config.peripheral_size),
> > > >       - optional completion polling when local IRQ handling is disabled, and
> > > >       - notify-only channels for cases where the local side needs interrupt
> > > > 	notification without cookie-based accounting (i.e. its peer
> > > > 	prepares and submits the descriptors), useful when host-to-endpoint
> > > > 	interrupt delivery is difficult or unavailable without it.
> > > >
> > > >   * PCI: dwc: Add query-only helper APIs to expose resources of an integrated
> > > >     DesignWare eDMA instance:
> > > >       - the physical base/size of the eDMA register window, and
> > > >       - the per-channel LL region base/size, keyed by transfer direction and
> > > >         the hardware channel identifier (hw_id).
> > > >
> > > > The first real user will likely be the DesignWare backend in the NTB transport work:
> > > >
> > > >   [RFC PATCH v4 25/38] NTB: hw: Add remote eDMA backend registry and DesignWare backend
> > > >   https://lore.kernel.org/linux-pci/20260118135440.1958279-26-den@valinux.co.jp/
> > > >
> > > >     (Note: the implementation in this series has been updated since that
> > > >     RFC v4, so the RFC series will also need some adjustments. I have an
> > > >     updated RFC series locally and can post an RFC v5 if that would help
> > > >     review/testing.)
> > > >
> > > > Apply/merge notes:
> > > >   - Patches 1-5 apply cleanly on dmaengine.git next.
> > > >   - Patches 6-7 apply cleanly on pci.git controller/dwc.
> > > >
> > > > Changes in v2:
> > > >   - Combine the two previously posted series into a single set (per Frank's
> > > >     suggestion). Order dmaengine/dw-edma patches first so hw_id support
> > > >     lands before the PCI LL-region helper, which assumes
> > > >     dma_slave_caps.hw_id availability.
> > > >
> > > > Thanks for reviewing,
> > > >
> > > >
> > > > Koichiro Den (7):
> > > >   dmaengine: Add hw_id to dma_slave_caps
> > > >   dmaengine: dw-edma: Report channel hw_id in dma_slave_caps
> > > >   dmaengine: dw-edma: Add per-channel interrupt routing control
> > > >   dmaengine: dw-edma: Poll completion when local IRQ handling is
> > > >     disabled
> > > >   dmaengine: dw-edma: Add notify-only channels support
> > > >   PCI: dwc: Add helper to query integrated dw-edma register window
> > > >   PCI: dwc: Add helper to query integrated dw-edma linked-list region
> > >
> > >
> > > Hi Mani, Vinod (and others),
> > >
> > > I'd appreciate your thoughts on the overall design of patches 3–5/7 when
> > > you have a moment.
> > >
> > >   - [PATCH v2 3/7] dmaengine: dw-edma: Add per-channel interrupt routing control
> > >     https://lore.kernel.org/dmaengine/20260127033420.3460579-4-den@valinux.co.jp/
> > >   - [PATCH v2 4/7] dmaengine: dw-edma: Poll completion when local IRQ handling is disabled
> > >     https://lore.kernel.org/dmaengine/20260127033420.3460579-5-den@valinux.co.jp/
> > >   - [PATCH v2 5/7] dmaengine: dw-edma: Add notify-only channels support
> > >     https://lore.kernel.org/dmaengine/20260127033420.3460579-6-den@valinux.co.jp/
> > >
> > > My cover letter might have been too terse, so let me add a bit more context
> > > and two questions at the end.
> > >
> > > (Frank already provided helpful feedback on v1/RFC for Patch 3/7. Thanks, Frank.)
> > >
> > >
> > > Motivation for these three patches
> > > ----------------------------------
> > >
> > >   For remote use of a DMA channel (i.e. the host drives a channel that
> > >   resides in the endpoint (EP)):
> > >
> > >   * The EP initializes its DMA channels during the normal SoC glue
> > >     driver probe.
> > >   * It obtains a dma_chan to delegate to the host via the standard
> > >     dma_request_channel().
> > >   * It exposes the underlying HW resources to the host ("delegation").
> > >   * The host also acquires a channel via the standard
> > >     dma_request_channel(). The underlying HW resource is the same as on the
> > >     EP side, but it's driven remotely from the host.
> > >
> > >   and I'm targeting two operating modes:
> > >
> > >   1). Standard use of the remote channel
> > >
> > >     * The host submits a transaction and handles its completion, just
> > >       like a local dmaengine client would. Under the hood, the HW channel
> > >       resides in the remote EP.
> > >     * In this scenario, we need to ensure:
> > >       (a). completion interrupts are delivered only to the host. Or,
> > >       (b). even if (a) is not possible (i.e. the EP also gets interrupted),
> > >            the EP must not acknowledge/clear the interrupt status in a way
> > >            that would race with host.
> > >
> > >                                   dmaengine_submit()
> > >                                           :
> > >                                           v
> > >        +----------+                 +----------+
> > >        | dma_chan |--(delegate)--->: dma_chan :
> > >        +----------+                 +----------+
> > >       EP (delegator)              Host (delegatee)
> > >                                           ^
> > >                                           :
> > >                                 completion interrupt
> > >
> > >   2). Notify-only channel
> > >
> > >     * The host submits a transaction, and the EP gets the interrupt
> > >       and runs any registered callbacks.
> > >     * In this scenario, we need to ensure:
> > >       (a). completion interrupts are delivered only to the EP. Or,
> > >       (b). even if (a) is not possible (i.e. the host also gets
> > >            interrupted), the host must not acknowledge/clear the interrupt
> > >            status in a way that would race with the EP.
> > >       (c). repeated dmaengine_submit() calls must not get stuck, even
> > >            though it cannot rely on interrupt-driven transaction status
> > >            management.
> >
> > According to RM:
> >
> > WR_DONE_INT_STATUS
> > Done Interrupt Status. The DMA write channel has successfully completed the DMA transfer. For
> > more information, see "Interrupts and Error Handling". Each bit corresponds to a DMA channel. Bit
> > [0] corresponds to channel 0.
> > - Enabling: For more information, see "Interrupts and Error Handling".
> > - Masking: The DMA write interrupt Mask register has no effect on this register.
> > - Clearing: You must write a 1'b1 to the corresponding channel bit in the DMA write interrupt Clear register
> > to clear this interrupt bit.
> >
> > Note: You can write to this register to emulate interrupt generation, during software or hardware testing. A
> > ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > write to the address triggers an interrupt, but the DMA does not set the Done or Abort bits in this register.
> >
> >
> > So you just need write this register to trigger a fake irq. needn't do
> > data transfer.
>
> Thanks for the comment.
>
> One concern I have with using the fake interrupt mechanism is that it is
> effectively channel-less, while the only documented acknowledgment path is
> via {WR,RD}_DONE_INT_CLEAR[x], which is strictly channel-based. The RM does
> not describe how a channel-less, emulated interrupt is associated with (or
> cleared by) a specific channel's INT_CLEAR bit.

According to spec, it should only generate a irq, but no bit set at status.
so needn't clean.

>
> Because of that, I don't think there is a spec-backed guarantee that
> writing INT_CLEAR for an arbitrary (even if reserved) channel will reliably
> clear a fake interrupt, though I might be missing something. In the very
> first RFC v1 series [1], I ended up writing 1 to all enabled channels
> simply as the most defensive approach. However, that clearly does not
> compose well once the same eDMA instance is used for real data transfers,
> since it risks clearing real completion events.

Transfer a dummy data is not big issue. Only have to write at least 2
register to finish a data transfer to trigger remote doorbell.

If write INT_STATUS work, which will most likely push doorbell. I have not
did test, dose write INT_STATUS work?

Frank

>
> What's your view on this?
>
> [1] https://lore.kernel.org/all/20251023071916.901355-16-den@valinux.co.jp/
>
> Thanks again for taking a close look at this.
>
> Koichiro
>
> >
> > Frank
> >
> > >       (d). callback can be registered for the dma_chan on the EP.
> > >
> > >                                   dmaengine_submit()
> > >                                           :
> > >                                           v
> > >        +----------+                 +----------+
> > >        | dma_chan |--(delegate)--->: dma_chan :
> > >        +----------+                 +----------+
> > >       EP (delegator)              Host (delegatee)
> > >              ^
> > >              :
> > >       completion interrupt
> > >
> > >
> > >   Patch mapping:
> > >     - (a)(b) are addressed by [PATCH v2 3/7].
> > >     - (c) is addressed by [PATCH v2 4/7].
> > >     - (d) is addressed by [PATCH v2 5/7].
> > >
> > >
> > > Questions
> > > ---------
> > >
> > >   1. Are these two use cases (1) and (2) acceptable?
> > >   2. To support (1) and (2), is the current implementation direction acceptable?
> > >      Or should this be generalized into a dmaengine API rather than being a
> > >      dw-edma-core-specific extension?
> > >
> > >
> > > Any feedback would be appreciated.
> > >
> > > Kind regards,
> > > Koichiro
> > >
> > >
> > > >
> > > >  MAINTAINERS                                  |   2 +-
> > > >  drivers/dma/dmaengine.c                      |   1 +
> > > >  drivers/dma/dw-edma/dw-edma-core.c           | 167 +++++++++++++++++--
> > > >  drivers/dma/dw-edma/dw-edma-core.h           |  21 +++
> > > >  drivers/dma/dw-edma/dw-edma-v0-core.c        |  26 ++-
> > > >  drivers/pci/controller/dwc/pcie-designware.c |  74 ++++++++
> > > >  drivers/pci/controller/dwc/pcie-designware.h |   2 +
> > > >  include/linux/dma/edma.h                     |  57 +++++++
> > > >  include/linux/dmaengine.h                    |   2 +
> > > >  include/linux/pcie-dwc-edma.h                |  72 ++++++++
> > > >  10 files changed, 398 insertions(+), 26 deletions(-)
> > > >  create mode 100644 include/linux/pcie-dwc-edma.h
> > > >
> > > > --
> > > > 2.51.0
> > > >

