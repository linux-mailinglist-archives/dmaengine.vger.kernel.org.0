Return-Path: <dmaengine+bounces-6525-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FAC2B58BA1
	for <lists+dmaengine@lfdr.de>; Tue, 16 Sep 2025 04:01:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE90F1BC263B
	for <lists+dmaengine@lfdr.de>; Tue, 16 Sep 2025 02:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9CCE1C5D77;
	Tue, 16 Sep 2025 02:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="XPq/nZC0"
X-Original-To: dmaengine@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013070.outbound.protection.outlook.com [40.107.162.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98BC71B7F4;
	Tue, 16 Sep 2025 02:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757988080; cv=fail; b=XP/42bOl9VpH535epnbr8r9afMc1GvTEtiY+qnugAv1itIZm6WaCqrYqCcmu2KZ+yQigHRhYJva0dya+5q6VsDwPQVjDzjGeHfA8Lar4tiXEE6cHkcvlzwGjovLegDW1EBFrV4WxZTlPJU4XYx7/H5QvrrlXnuYV9qNM+Xsbk34=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757988080; c=relaxed/simple;
	bh=NBvTjJeDWZJlMplRpHE8xNGy69U+qWPqDcYfRTgVStQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ITkoeaM95d7VvSNnhw6wz0n4bD6hJAGLsj3ypzvwLoD2vcN7xQWDzOvJUxEdyHfeO0kUqu8h5KW/cEOEVZNVqVqgxw1r6zBuA7OQFbaa0u97avaR6uxG2AYTYr7XeyZxBSjlxpzsN/ltbO+B+0bHmuAJkQyKTufLS9EXNKdLeVs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=XPq/nZC0; arc=fail smtp.client-ip=40.107.162.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zw8YHL0mi4i5OL4L+8gDBcCVXFJG9hJY8ep2/BKLp2AWQnbAgoPoLdP12LeKP5tG4dOV6la41wBfeVp0Xoioheo2mQn0WcshlKVisGbIDIH4MCnEe0GNdgQfhjJv77hr7xnzIN+hrlhB/WHRflBNfhEpa6WFLJ5S26PNd2KVluffBxNfIN2Ocx4cNxqRbPB3+BDpp15VWQRrtb6LRBrJez9AcA34t5xPjag//nxAr1Ri/Z+6UZTV4h1lyI1OYUMVK2EYvUo4DpEat/IrXp3CSZU0ZwL1repjEQ9bVMYOarz5319jqy07GqDnjH73dLctD+69GrUFpDIoT2oWNOqvXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NBvTjJeDWZJlMplRpHE8xNGy69U+qWPqDcYfRTgVStQ=;
 b=a8pnxLkn3zqm3KdmBCOEWt2OvXDyjEv1Ll0OM6gwdfGw1/ALGgromWCGc7ebsDYeAB07b7d4rOjyRn8JoYEvrhesfF8zHsg15qYSGyf1jDyjDBJwHpnh/KykMwbp9A1Jw8boLi6nn87i/IrsS+no6Zba4JiGaj+31sf2cC4R4zYjeTu4uvivdEdaGJdcmweNueEHtPUAmzzd1VHm51LDMKCxsVnOyC++2Okk6fz22SXkfyTwVM46W5beYcwf/f3ddGgHEGbfQ1W5HQemEflHLmlajoQPcqRFIQtszyz7t1/4hD8da9xheFbzBlSE02Asa0LysG6AXm33hTzU6VTXUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NBvTjJeDWZJlMplRpHE8xNGy69U+qWPqDcYfRTgVStQ=;
 b=XPq/nZC0Eu5uxxEWH5tc7nHdERRIeWwAhdLDkrox20i8/IQwe9p4t557i6iRf/hw1HAkNrVMg+hmXxqSVXQjR4Hq6uWINTwDTTlA+uKn2B6PRIOGpu+RJIug+3ziUjRw09n4nIgp2Z7vejmv8aACiiINPHrNy9dYTe9h1GFX6ihY76Tytake3StbVk0jnXqn8yfz75OUM0l9Xyv8u+iVdXeId7WgKHazykcOh14i03IRGvWTl4eHecYgBHpyp31Rec57G2GEfAG+SDYzLgL8cIthTqvmuCebkufq6REN3eSkkGVjRDic1oHGDYkNLOhny2dRNfwuByrTV6EhHjdJ1Q==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAXPR04MB8543.eurprd04.prod.outlook.com (2603:10a6:102:216::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.12; Tue, 16 Sep
 2025 02:01:12 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9137.010; Tue, 16 Sep 2025
 02:01:12 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Marco Felsch <m.felsch@pengutronix.de>, Vinod Koul <vkoul@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam
	<festevam@gmail.com>, Jiada Wang <jiada_wang@mentor.com>
CC: "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 02/10] dmaengine: imx-sdma: fix spba-bus handling for
 i.MX8M
Thread-Topic: [PATCH v2 02/10] dmaengine: imx-sdma: fix spba-bus handling for
 i.MX8M
Thread-Index: AQHcI2cBPQgL+H9llEq5UNnrNOcCUbSVE6fA
Date: Tue, 16 Sep 2025 02:01:12 +0000
Message-ID:
 <PAXPR04MB84593838583159F5BD825DE58814A@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20250911-v6-16-topic-sdma-v2-0-d315f56343b5@pengutronix.de>
 <20250911-v6-16-topic-sdma-v2-2-d315f56343b5@pengutronix.de>
In-Reply-To: <20250911-v6-16-topic-sdma-v2-2-d315f56343b5@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|PAXPR04MB8543:EE_
x-ms-office365-filtering-correlation-id: 99091e3b-407d-4f43-e9ed-08ddf4c4e945
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|19092799006|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?dlA4SCtoa0RITFNaZnRJZ1dhV1lYeGJUbG5lZklzT0RoRVF6Y1huSmFPTU55?=
 =?utf-8?B?bElGanZrZW9YVmEyV2sxRlpuVk52SWNMamFqY2VtekR0SVZtT05oNDJQTld1?=
 =?utf-8?B?Z0w1VG1iR0d1bUxHQkhNQWQvY1NYSUNpTHdNWjFQTEdHRWZUVUoybDVRajAr?=
 =?utf-8?B?eDhUeVBqRnNZNUkzN1FNaXFzY3BhTmJjZklrYlJmeEo5UTJIdzhkQURQTEpX?=
 =?utf-8?B?TEpzdkFQMHlCRkZ1aW5qeVZzajNSZjl1NEdQR1orc1RTZlVHSzZsRXV5c2ox?=
 =?utf-8?B?MEsrckRCdDVNMURPaC9PT0tEVnhlRmYzMW9QUmorb2gzU0VZdkJvQUh2MzVa?=
 =?utf-8?B?ZjJxN2NIVFVQTjdJZzRndlFBNGp4cTc5WUZQNW1PSUh5dGhjdnBIWUJSbFc3?=
 =?utf-8?B?U21nNjRtYjkydCtMMFFWd0FteTAyTEg1NStuanF5Rm8vUnZ5dmJ6WUVWQnVa?=
 =?utf-8?B?eTR0NkRMQ2RreHlIdDVpWmJSaTZzUDUra0p4V3ZlakRtY21FZzJlSEwrQ3NS?=
 =?utf-8?B?OS8xa3JVd3NVMG5rVHJkOC8wS0UxVzExbHhvOXBSUy9Yb0RoWmpucURTQ3RI?=
 =?utf-8?B?V1FXZm5GODZiWGtmcHdPaVJZcWJwdHFrRDU5Nng3ZDNrZW44a0hTVFE3VDA5?=
 =?utf-8?B?VEh0dXM3YkpmNllsS3piK04vWURlN3JzZ2JxeEtIZWV3Q2gzYSs1enRXbzBF?=
 =?utf-8?B?eWpRQ1h0eHBQVVEzNlc4YU80YkJTVlY4VWJYVkhUcDZlK1RDWXdHcWR0ZlhL?=
 =?utf-8?B?TGw5b0x0cWZaa3RUQ0s1a0c5ZFN0VEdXRVdyQkJRa3kxZW1RWDArZjBJdEpD?=
 =?utf-8?B?aEQ4OGEzUlNmRmpETXhFbGdodUlJVWUxdjN4K1UxL2lHajdQbkwzSGRjNHVB?=
 =?utf-8?B?TkhGd0F6Y0VmUWNJUzJVeXFrdXFaaDRaVEEwVFUzeUFFUzQwWGYvdVVDOElH?=
 =?utf-8?B?SzQvRCtnekFEemsrNGpHTlQ4ZXF1Mk9lN3VsRUNjYXU3dEtUQzR1bjN1alFN?=
 =?utf-8?B?ZGh1a21VSjZGc1dDVkZuN1RnTmgwSUgvTE5FNUdJaHIxdExCV2l0SlBCRGlI?=
 =?utf-8?B?Qjd2S1pvbmpoTjRBcEIvd096RFZFVFhoQjV5WlEvWVdSQlpLRXRmVUxrREZr?=
 =?utf-8?B?NmhtMnZocmNsSkFIYWZlS2VBZjhhYXJ4SThHeWZCZmsyU3dmM05YOEpKWkdj?=
 =?utf-8?B?M1p4RzNyYnVGWVRSUnhsS1BsR3A4dkw2SXYySDVzd25RMW80d0YvOXZud21E?=
 =?utf-8?B?YllJVFl6KzdIQURrU1VhZndzdXdsZU5ZZkRlODBQVmVKdHdpNXdPTnpENEVo?=
 =?utf-8?B?bXltTXFmQ3ZUS1FETjYrLzN3MXdOMWZOVEIwcGU0Q251am40M1d6djFDL1do?=
 =?utf-8?B?eUpuUUFDUE1wNU5EdzJvUC9WSG9OZXA4TXBWS0hmbDNwOWI0YVRUZ3JVVGxR?=
 =?utf-8?B?MW8ycjdjUWh5cTRrV1NFY3RiRG9COXBSRjl4Y0I0U0dlV2JsK1NXK0hieFVC?=
 =?utf-8?B?dFRIOHVLUENqTXc3TFltbGlBV2tsU3RNeUdjOGNwS2o5Y1BzZ2Z6ejM4bXV5?=
 =?utf-8?B?UysxdVoxRmEvOFJhVkY3cVVYcm16dlB4SzZQU3VBTU04eTkzdDNmbFVhVWRu?=
 =?utf-8?B?M1VpdGdkRGlHa0ZQY2dWZ2M3NkpHa1lIQ0xxZGNtNGZ1V1lCQ3hWUXZqc2Rn?=
 =?utf-8?B?elc3T1FNNWlVWmtwcGNvU01pdEZicFRidldEMC9OeVFsUStYdURBbFFwNE5w?=
 =?utf-8?B?OE51Vy9zYnZQQVhvTU9OdWpWQVlXSDVLdHppVWR5VHRTR21nTlRlTVFicjQ3?=
 =?utf-8?B?c3JaeXlSdUcrcXliRzNkaDJoOHpDT3JUM1dNSm5QM1dXSzQ1eHpEUTJzL0NH?=
 =?utf-8?B?ZVRWbHJtd3pwZStyY25hM2x4YXlCc2ZPaDhIZ3M0c3FuRTkwZktXS0FmQ1RP?=
 =?utf-8?B?c3N0a0NOeFFvQ21pcjdldjhqdldObmNNTUxDYW83Z2tMUURGQk92NUVnV3c5?=
 =?utf-8?B?K2N0ZGxla3hBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(19092799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?b0FRckNEc1BMeldxeTNEazJQSndpZklMbDBOZHIxdFJxck11WVZiL09ud0Zv?=
 =?utf-8?B?N1pyb3A1NDNSanpyWEllS1lWK0NWQ0ZFL0dXdXJJdUdoTzlZazVjL0dGR0V4?=
 =?utf-8?B?VENwYjNLcGxTYm9TaWxPMEp6R0NYbG5tdVRQekhWY3owcytxK3pucUVmN0kx?=
 =?utf-8?B?VkJINFVvQ0pRZjB2NjBySWJWb1lNNEIxM3J5ODVQSk51M25YcWptdUhMZGZu?=
 =?utf-8?B?Ny9Pb0h3bkU4ZDNOT2NCakN1NnZuYWZFNnJLMmRpTnZPRlNVbTJmMktPL1Zr?=
 =?utf-8?B?VHI0NlFpRVB1YkxVRXA5TXJwTm4rL3pQMEw4aHJHQ2xETzZFZ2d3anlPb1pT?=
 =?utf-8?B?WEU1ZUxKQjFNZm9wRkxkWEphTDMwRWh4S083QWNlQVF5OE5VTjg5TDZKbm9W?=
 =?utf-8?B?SFpPVzNOck1lSW1rSTVsVzJUN1VxY1dVQU01VEphYTh5MWhBWUYvTExhVURY?=
 =?utf-8?B?WmNiTmZDdlhJeXgwM2VLWFhCSjgzdEpUYnNuQkdaNjV2d0RzVFFHdkpDWXB4?=
 =?utf-8?B?a0pHYlNzU3N2enRHaWQzSEhHQWJCRUxaWHJoMVVJYy9aRjFKUk5ZcUxEdUQ0?=
 =?utf-8?B?aGxSWTV6aVA2bkE4SS80V3YyNzM3NHVVL2xyWEhnMFZGN0J0T2thNUdPaTJu?=
 =?utf-8?B?Q25ZSFdrSTNzR0FJbDlVYisyNWhXRGNxdEpHL1gwM2p1Y0svSU5DUGhpQ1Jl?=
 =?utf-8?B?SnpKbUF0cWtQZ21EWUZIQS9yc3k2TDNDaGhKWEFFcmFyVUNTUkFZWk1BNktk?=
 =?utf-8?B?SFBQVTFJYjJMS3FQT3hsczVwbWpFVmoxZS9MWlVnZURqUVk1enRzbnliVEZn?=
 =?utf-8?B?bVlueml1aXBrcEZjMk9Ec1VlRGFUUVF5a0UrYjFaNnVEbjlvOEg3TS8rbW4z?=
 =?utf-8?B?a1Z5ZDIxMTRHMG4xS3llV0xXRzBZUHNEQW8raXNYMEZpR0s5TjBESDBPaFl4?=
 =?utf-8?B?QmRZaWY2aSswRmkvRVR5eHNMOFRjYXRkcm9TR3BYenVLelRyQ2xLSm5IUDF1?=
 =?utf-8?B?YytDdGlCdFZUcFhVOFFMZlpRUGd1aUx1bnE0M2tIVVhJZHFjY0phbU1uOVVI?=
 =?utf-8?B?ajNPcjFxdmdmVmZxTUdMY1hHQzcxbGJ5NkQ4TnF0WThrRFdQcDFjR1M1OFdY?=
 =?utf-8?B?VlMvcm10Z0J2aCs3alhrb2JVMXpWSzFTcldDQ2NJeWRuQm5LWXVRNk9YQVBZ?=
 =?utf-8?B?a2RnbFZBNXNlY1dPSWNTb05zVzZ6ZWN2WXVsYkpUcDlmUzFNQlB6MTZFdGoy?=
 =?utf-8?B?LzYxZk9URWVuMEgxZ1NuRUwxLzJqeEtLbkFPZXpLdC8wdVplOWZtZzB4SDlm?=
 =?utf-8?B?SnBNRE1mWG1PN0lnTHBwTGgyN2E1cGJxbzI5YzlBaW51WUhlbGJ1MU1RdVNI?=
 =?utf-8?B?VmV5Y05WYU4xMDlTR3p0dzYrdXJkMVJLbDV1N2ZPdVZYeENkc0pHd1owaG5a?=
 =?utf-8?B?RFkzcnhhYjA1YVpYN0ZhSVB6YnBtRHA2RjFtQWZtN2FIOWFzSWs2cGdYSTg2?=
 =?utf-8?B?WDlNb28rdTUxK3ExRmorZTFKNFl5TjJ6NFNhNm9Pd3B5U2s4eEx2RG5ndURQ?=
 =?utf-8?B?aEgwQnNaL0ZieVUvTE4xM0xCbW5OSVlJOS9VSzFyWkNDeWttY1dBZlBySWdj?=
 =?utf-8?B?bjNsOVZpK0ZZUXVqRVRrSnFJOGNRaHNkdXlTNTlFRFJ4Qmc3amtwcVgxRy9j?=
 =?utf-8?B?d3p5Tzh1NVhCbys0SE1qeklGK1hMKzBPcHRsQ254MkJTN0orM2F1OTVHVFZ2?=
 =?utf-8?B?TkFwQmRpeTl4aHQyaDZiSVhxK1V1V2lZOU1WY3Brc2Y5YzArTjdGRVcra2Rr?=
 =?utf-8?B?VnZBUkhzSUE3b2l3SVVYQjdtcmRDZU5Zd2lMaTQrNlNRdk1ibTlaTWlhRi9S?=
 =?utf-8?B?WmV2OXN1dE1SVS9YWGl3TlNYeTZIcDV5MGczd1R0YTFEekZFbWNRZ1R6UEpl?=
 =?utf-8?B?blZqVzFxRjMrVUFJR0lIZHYzUkNqMU4yeFRlUWt5NkJSajl5RUs5QWdqbjhx?=
 =?utf-8?B?aHRTMHg0Q2RWTExtY1ZRbVVXQzBHbzRMVHo3cFRqVXF6M2hUelZoTW5MeVRi?=
 =?utf-8?B?MXg5c2tMck5rTWVidUhJMWlZYSt2enBkTkNHZS8zdjZ3RVM4andsQmVjcHgr?=
 =?utf-8?Q?iODo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99091e3b-407d-4f43-e9ed-08ddf4c4e945
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2025 02:01:12.0420
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: seEdXzx4bM0GpdxhyeMXhRfAvd9L5gE3UzGNHjouobRwg+hadNfyDbkMQHc920s0E7qiYHO0zyG8KkHn4aXpuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8543

PiBTdWJqZWN0OiBbUEFUQ0ggdjIgMDIvMTBdIGRtYWVuZ2luZTogaW14LXNkbWE6IGZpeCBzcGJh
LWJ1cw0KPiBoYW5kbGluZyBmb3IgaS5NWDhNDQo+IA0KPiBTdGFydGluZyB3aXRoIGkuTVg4TSog
ZGV2aWNlcyB0aGVyZSBhcmUgbXVsdGlwbGUgc3BiYS1idXNzZXMgc28gd2UNCj4gY2FuJ3QganVz
dCBzZWFyY2ggdGhlIHdob2xlIERUIGZvciB0aGUgZmlyc3Qgc3BiYS1idXMgbWF0Y2ggYW5kIHRh
a2UgaXQuDQo+IEluc3RlYWQgd2UgbmVlZCB0byBjaGVjayBmb3IgZWFjaCBkZXZpY2UgdG8gd2hp
Y2ggYnVzIGl0IGJlbG9uZ3MgYW5kDQo+IHNldHVwIHRoZSBzcGJhX3tzdGFydCxlbmR9X2FkZHIg
YWNjb3JkaW5nbHkgcGVyIHNkbWFfY2hhbm5lbC4NCj4gDQo+IFdoaWxlIG9uIGl0LCBkb24ndCBp
Z25vcmUgZXJyb3JzIGZyb20gb2ZfYWRkcmVzc190b19yZXNvdXJjZSgpIGlmIHRoZXkNCj4gYXJl
IHZhbGlkLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogTWFyY28gRmVsc2NoIDxtLmZlbHNjaEBwZW5n
dXRyb25peC5kZT4NCg0KUmV2aWV3ZWQtYnk6IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAuY29tPg0K

