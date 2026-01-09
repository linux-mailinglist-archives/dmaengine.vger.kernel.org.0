Return-Path: <dmaengine+bounces-8187-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D1373D0C269
	for <lists+dmaengine@lfdr.de>; Fri, 09 Jan 2026 21:15:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 03BD1301FC08
	for <lists+dmaengine@lfdr.de>; Fri,  9 Jan 2026 20:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AF4936654F;
	Fri,  9 Jan 2026 20:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="hrpyU3jh"
X-Original-To: dmaengine@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013030.outbound.protection.outlook.com [40.107.159.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E97C32D0E1;
	Fri,  9 Jan 2026 20:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767989646; cv=fail; b=ogObU3raS4vtcSfD8bUYSUlF4GBCW+KRuI0ja6oDYn3BELGENQoLQgmNVw3R1+9Zs7movgkdMAlAec3B5yiN7DKYf6FZt+kQcLegOAZW5ORFWL9b87Hb6rv/fHfXE+E+j4fbwiml3PNDrtkjsPOfQ2XFYvgiDcNIUlkYvmY1uAc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767989646; c=relaxed/simple;
	bh=0uEb+CeRLmrIFPUmHMoyPwTkiP4swuUKx5QDw2GaOyk=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=UlywDBxi8fEZfHS5xeAYQcZWviz293y6ahqjhwvBI9k3ATnKOTA+eMeq+X5QUj4tbBrbmEDdagokn4km806VvHyZML2k5RG519f6piwctodVTg72AALJgeYtHcefStSMmvewlKP4gU/pPPmLl2w1sUOBw76rej7xBTSatZJzD7A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=hrpyU3jh; arc=fail smtp.client-ip=40.107.159.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rufvx7RcvBbU8KBVoN8rVPcy4F7HXmzBVG7ELQLI0/xleW8+mGdOa/p44ncQpXcnkv7ISgAyyYPigxqP7Idg31KFwwi1DMcfKLLIEjRC38p1o/Zu9YASj/ckpNX4L/TnD9rMcF4aQwHh+yZJSqBhGBp0QkCm2o8EA0n+OqyS5ATLS1ZHkkpon5Nh/4fsy2nWZT+voyuIBBEmVVMalK6Od36mgA3OIEd7Q97613ekMuujP6uCwvYaAe6gy1kFmDpqlEj1zt4VxogWbv4wLlVNs+cVt9yUuRH9FT7BV2hqlWNklOIvaZkRTAM4ntoyEosxLE4xHCl4Q+sMAQu4WNDA0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BguQmwcbMHvhaP7ijFgPsWVqt1YtZ25yA6ByQhIwqbE=;
 b=CRgZjmHbvyXywoxBTSiZO7XcU2qEznyTOlAbJHnS7O8XaXQ6+58Yd+inL+qLVHkV4zz92alqfsdLH25jvUhGc8fhFBPnUMbofSTmsgrJtK7BUyWKuBHpID72sj3+JqDbDBMJwwOU4r97Nz2dctaxlS4q/K8K5Wk5yTytSp5R2z9h/oPMrrJCjrwS0QQYAUcXVHb4LpwJbFJwvzYsy3N0oZf1z9FP9n65/3z0+wKhfVw1djekH0qqKz5p+/bZHkpcSYZ34IAC86RndKQJdmHBekkhlENqGhbJceB5I7pvf9idhwW2mLKy94WwP7XbIvp0ZV7iVtzzxTVoAnR0EK5Vdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BguQmwcbMHvhaP7ijFgPsWVqt1YtZ25yA6ByQhIwqbE=;
 b=hrpyU3jh+jYnZQWG4eF9UdvzcqXNsq0hyGH9LfbQYR1scN0E/Xov6QNXTeIu2EZIHm7Y/RiprPum5USIu9Ke/zWGY4ooXxpBQiv8CMjfMb5wC+/Kvr4lL9KyQjlLVYRhQlMGQn9GcWX8PaOvzj7fA9xmrV5SgKMRwTYLRYGo2xCn9L/QbmG/UKAdYtTlQnJNq7SIydIHgzg/cfYAmaNy6YSzRpJRRybhZQowxVaNZ15j+FeStW76m2VDdpnNggjVaT467gtStuNJxHv/eycJMuU+a2zNcJGLuHIRb+vubCMWIOquuoM3or7WNKV8328CbNHEIOVHkhN6Yev5ed2VbQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by PAXPR04MB9106.eurprd04.prod.outlook.com (2603:10a6:102:227::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.5; Fri, 9 Jan
 2026 20:13:55 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9478.004; Fri, 9 Jan 2026
 20:13:55 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Fri, 09 Jan 2026 15:13:26 -0500
Subject: [PATCH RFT 2/5] dmaengine: dw-edma: Move
 dw_hdma_set_callback_result() up
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260109-edma_dymatic-v1-2-9a98c9c98536@nxp.com>
References: <20260109-edma_dymatic-v1-0-9a98c9c98536@nxp.com>
In-Reply-To: <20260109-edma_dymatic-v1-0-9a98c9c98536@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767989623; l=2265;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=0uEb+CeRLmrIFPUmHMoyPwTkiP4swuUKx5QDw2GaOyk=;
 b=CzYjdZMTrWkFQs+v2j2CrZkCI2u+S9ZC4MlE+s+6zbiIieIF9m5MCh8w16cdUhTx8qhAGZGwa
 xZb16E+AqAUDzzgB2hD2r51+poR8AcRNLjRbymx/EN2EPT9Jjndn0vP
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
X-MS-Office365-Filtering-Correlation-Id: 61839085-0d07-4f1f-75c0-08de4fbb9db6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|19092799006|7416014|376014|1800799024|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cWlXemRyUTY3a2tFeklrZThXUGx6VWFxKzZBdjAwdE9Ga2Y4QVdWbVNuVkNv?=
 =?utf-8?B?NC9QbFZNdFpKQjE5a3I2MzlhMWUvTkpJZmFKUmcwbmthZjRsWXl6dURZY3V4?=
 =?utf-8?B?ZUJrZ0xSZEY3TFhBT3I2Mm5yNnFXV056QkQ4WW9pdGVRUHlrbXlnWnRwUGIv?=
 =?utf-8?B?d3hUalhBSHZGMnAwYnQ1QmwwMkI2QkZTNlY5VmZFWnJDUElaN3M0YUlsSDVv?=
 =?utf-8?B?dUtmRWNraFJkNnkrbk9FUzdFUTY2NmkwRW9KT0R1STJDbUsvM0Iyd05qbE9a?=
 =?utf-8?B?a0Q3WmR5Zjdvb1BTazBrcm54UDl0ZW9SUE5nejJabnlNaitlRzlSbFh6SVJs?=
 =?utf-8?B?d0RTNnJocUJIdHRLaVlvUmQza3pyUUxOSDRXTm1WZ3NnU3FlSmpiTTl1MjRx?=
 =?utf-8?B?bTI1SjNHeVZtdnc5S3hiTnZUeDdQQkJORFo3Z0pGbVkycWJKMTFrcmlPRkJ0?=
 =?utf-8?B?VDRRbjUyM0VJaVRGTHFVUHRDeVFESG5vdU1UU0VMYnAyeG9rQzU2NmUvb2dn?=
 =?utf-8?B?T3NUMGxMaFNaZWhwVUxScGdVaXBLMkpkWnJNSWpibk9pOHNrc0tTU2FrREJz?=
 =?utf-8?B?U1k4VUJqRlVXdVhLc3BIYUhYRUVucGY0YUxmcUIvMGlaTVNlRjNQbTlZQzMw?=
 =?utf-8?B?NEVkYWp4QUxqdGY3RUxvNFAvdFI0OWtzRE9zbzNFUlZVTDFtMkJUek5Tb2Uy?=
 =?utf-8?B?TU1LV1BLQXFBZGJpQTZ4VGwvUnRDSGQwU0FHYnBYdis2OFVHSll5ZHBHYU5i?=
 =?utf-8?B?UFBSV1k0TGxjRVErcGdtSElBZ2VKTXV6Vld5UEN3N3hOSlFxRklqQWtLR2o1?=
 =?utf-8?B?ZFdTRlBVNUlJSlArQVVQSXNtVkhIKzlZM1U5bW1LTTNOblg3N043cHl5bytu?=
 =?utf-8?B?bGovVFNNUHlpMGdTMUdUeXVvamVtUi9MTmwxUjFCVlNTTWtMaDlOVytqRE9m?=
 =?utf-8?B?UjFSUHhnM1Jud1dMR08zaDZMSW9lMk9OUFovQU90a2QxbzhxMDYwUzFBUXU4?=
 =?utf-8?B?bzZkd3IzSjltNzRmS2tnWWxIV0w5Nm42aFhRTHp0c0syWWVOOUkrZ0R3WUhI?=
 =?utf-8?B?VjVHWEN4NTZFTE9QWnJuKzB1S21wM3NSbnkwQmx0SThubzA5RGVaalYwWnhR?=
 =?utf-8?B?UDExQm9iSDBRWHdnMEJHUWpQYlJQNnNld0NmWjkvcmlFdzhuRXIyamZUMEF4?=
 =?utf-8?B?emplVm9KTU1yeTY5TmxscEt0cFJiNlFJMm9pSjZnZ3lXSjJGMmFxZm9sUmVs?=
 =?utf-8?B?d25CTGc2dGxxRWNZKytTODBrcld0N3JMUndUWnFXTC91dkVyMDZ1WEd5Yk0z?=
 =?utf-8?B?T3RLSnFmWEZtWGw3UThyWlNkTUEwWWZOMHZ3cnY4OExlbkNXRHRoWmVmbjU5?=
 =?utf-8?B?ajV0MVIxRTV0em9wZnlIOGNYRWJEYVJRUHVmTklycWYralpyWFdIUHVYTmtk?=
 =?utf-8?B?YzJFaE5ZNks3aU14WHVYQUJtaVpudk1VcC9FZnVRVk1ucGs3TVhIaWczUUZm?=
 =?utf-8?B?VWVUZWtoR2Y4L2hvT2JvVjZsWnlJbXhJdnFab2lBakR0a0JRcEVSQmwxam5x?=
 =?utf-8?B?bi9yVEVSY0pQYlZTSXpsZTJ0bmZYeVV0cFlVV1R1Vjc2TG9ZZG9HaVBXZG9x?=
 =?utf-8?B?TklaRTJ6Z1hOdzJiNzQ1Vzc4QjNkSHE5djZueG45MzM5MGUzZmlhRVJLdGZK?=
 =?utf-8?B?blVibWxiTUJMOWZrK3FIZ3NXMVN6YkFDRExLOHFjM1F1ZmpsTWV4clQ1WXdN?=
 =?utf-8?B?aTY0Vldjakk5Nm0wd2pobjliZWcwckVVQnMvek1URzlGaEU1Wnc1NTNuVktp?=
 =?utf-8?B?MzZzQ1BEMlVzdVFVUStVV2kxUkJURDVrc213Zm1vRGJ6RUEzbVpWSXNZQ1lW?=
 =?utf-8?B?ZnoyTXp3SnloYTZoL3FMOTArQTM1c1A3M2lORTNaMGlrenZla0U3R0kzWEg0?=
 =?utf-8?B?eHBCT3h1eTN3YWladmdlSnFqR2JWWGhWRWY0TjJTaDFOU0c5cklsV2dhSTdl?=
 =?utf-8?B?dXh4QTN3K3dPby9MdSs0bnhrb1BDcHpLWG15VnNXRU1HaWdkUEZOMy9LRDFF?=
 =?utf-8?B?OUE5RDVHaUNvSjl2T0RCK0g1RjF6MUVxTzkxZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(19092799006)(7416014)(376014)(1800799024)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NitRNlRQdGszMm16dGNhS1pJNkRJQjY3MWdGZEpnR21tUlgwMDVtb3FLM3Fr?=
 =?utf-8?B?SGJQRDU2WDdIQklEUHRSQ2dDVjdsVWdBL3Vwb2xOM3RkYjgrOEFGQWxKenk3?=
 =?utf-8?B?Znk5K3NqUy9qdUloMExkNXZ6d2d2dnp5eXVpRHNZNExaakJEVnRkL2lFZkZP?=
 =?utf-8?B?d2hoaFdVMmZWcGg0aWU0Q0ZxQ2JRQVFRU2h3RzViVFV5cGdyZ1Naemo4YXBS?=
 =?utf-8?B?eENFV2haeW9HN294dDE3dzlCM0xQVGE2KzIxSHNFQ3Q3QkFadW1IZVVYKzZB?=
 =?utf-8?B?MXI4ajVjMllIZTlZQUxiWDJZWE5jdzVjMU9DeDRtR2pNb0VHaE01N2l6eUZY?=
 =?utf-8?B?RTFDR0JvbXIvMTdzT015Y0lMaXV6NVRoZ3cxdU9wOWZsNDdPTGFZWW8yZFdX?=
 =?utf-8?B?OTllWHFiaERpUGRuVVhRZWhjNlVCcCtYejlEVmJ1eEM5Z3AyUG9iNjU4cHdm?=
 =?utf-8?B?SzdiUjM0aVpVb2U3WnNWU05COFdJVDZrdC94OEJjWDQzVEdzY3FIaHFwL3pL?=
 =?utf-8?B?MitYVzU4RHFHRWNYNmw1N1JLQXdoeStaZWZkTWc0bk9rUlZVR0JsR29DNHhE?=
 =?utf-8?B?TnFkMTEzalNwMHRtSXdZeCtzV3ZpZjMrQmltRERZaDRLK1hRTTA4eXBWRDlE?=
 =?utf-8?B?UUV1VEZGQ05GcVhhTk5KRmhSbXNHTTlmRzFleGFtNFNwcVhtcXVhZU4vVnc4?=
 =?utf-8?B?VmU4OFBnRHg4endQa2VSQ05IdUgrMk9YMW9KWEpNcm1OYllmUUsweDVDV1Rr?=
 =?utf-8?B?RUtHQ0Y1bVFYVzJNQUlmV1lVS2xtN3hDN25VaW9EQndEQzd5U1krblFsUWs5?=
 =?utf-8?B?bDM0NkdJSlB2UmxDczFUZ0UvUjZUQnZLRU81TmpGekU5anQvVTl1dG5UQ2Rs?=
 =?utf-8?B?Y3pvSFBxS3A4eUZUMGxaek5LeHZHQkpnTkpZN2RFZG8vZVdBY3I2ckcyOFll?=
 =?utf-8?B?OEpzNnd2OHAwK2ZaSXBwM3dRazNmMXFqb2Zsc3kwN3ZFcUYwRG52NW11K3U5?=
 =?utf-8?B?cFVWWENJMXU5QXJXSEdKVSthSkFWcXVlSm42YVBIU3dUU1lwUEl3MnpJQTZT?=
 =?utf-8?B?R1dyUnpkUkMwQkJNYjZ6TzBqTUg4N3ZqWWlBVm9RNXJka1ZJcCtiYnNjU2Nz?=
 =?utf-8?B?VjJMTVNLRXdhdnJwRlRUbU80dW5ScnNUcjdtenlkOWdmZ2w3eVh4WW5hbUgr?=
 =?utf-8?B?RzEzS1NvTk5BanpYVzhRVWE2NHZyNTBOS1A5SjVOM2trNWpQMGl4WkpmUFVL?=
 =?utf-8?B?ejZiT3V2TTQzSDlwMkppd0F1aUREU3dBN1pvcmFoc2pxRGJiTytYRCt5MDBS?=
 =?utf-8?B?S0lqWjltcm5LT0FCbDdkaFhTcEF4ZXpMQ0NGY1Iwc0F0TGd6VFlVWmNpZzFL?=
 =?utf-8?B?bmd4RnN0TVBybGJORVJXZEVMUmxwSUFpNmJYdGFtRkYzVlhWV0ZQalJ0UnZt?=
 =?utf-8?B?US9ydVo1eXI5WGdSeGhBeWtISUVTSzBNb01BZE15RThwemhYdWJJUkVndGEw?=
 =?utf-8?B?dTYxNm5EekNXUzFySUV1Qy9EWXdFTmxnTkF5c1V0QW4yMGs4bkRFUXoyTVRn?=
 =?utf-8?B?ZmxNQy9YNklEYnh5ZGQ0TjZueFZoR1BCdDRVYlZOeEI2aXFMS3pvRFgzazN1?=
 =?utf-8?B?WkNQUVRYZUNDTTBXUjN1K3dsbmdQSzNiR3NCUUhsdFpsdHNoMEN3c2lxT1Q4?=
 =?utf-8?B?TGlpRWhMemxPNzh6dnBPM2h0UWRKcWVwaHk0QWlSMUdNcHp6c0pWYmM2eVNq?=
 =?utf-8?B?U0dSZkhnTGg5TnVwN0F1eHB0VXJMOWF5citlcWpUYkd3SEoxNDBKWUdHb1M3?=
 =?utf-8?B?OXZtWGJuYURJaDgyQUFWQWRrd0VMS2pGU1BidEFwanpkQ1lJNjlOc2dUbUZM?=
 =?utf-8?B?SEFUME91Y0pGOE55QW9MMmo0UkVWLzJteE93WHBpUTQ0T3BLYitkNHpMWDQ2?=
 =?utf-8?B?Rk1JcmpDKys5T09IdVdvcjBLa041d2NmbzFLQ2VQMlVVdnVJUWxiQSswV2t0?=
 =?utf-8?B?aThXam1WUDZ0MzhaMkJkUmtqbFZoS3BKWHgxSHM4Y1dsa0UyaCswWDJDcTZa?=
 =?utf-8?B?ZXZpd2ZEdVhUWUtxK3h3Nkg2c3U2VGdXMFhoc2duQXp5MlBFRlBuTDA3eDIy?=
 =?utf-8?B?NkUwekNkdFJhRVhaK1hicVdvejdDem45azJTdUlYNzFza1JMM3hPNmk4aVow?=
 =?utf-8?B?R3J2WWZNaUF0K0JZSjZwUm96cXUxNFRwRzlrYjRRNFlZNU16aEdRWjdPNjJ5?=
 =?utf-8?B?NDhYQTJHbzRtUnRlbURxT2RGYWlENC9OdjRaU21FZGtjby9DYVFoeWVNN01h?=
 =?utf-8?Q?RB+VYkzF31giQHBZcF?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61839085-0d07-4f1f-75c0-08de4fbb9db6
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2026 20:13:55.8350
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lLDW672nDuXSsm0demacEZx+2XC+t7ZVL9ZcGkCJ6I+L2iYHIycMQxiDLEKzCtlF5O/yGD5INbNPoyR8L6VNpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9106

Move dw_hdma_set_callback_result() before dw_edma_device_tx_status() to
avoid forward declear.

No functional change.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/dw-edma/dw-edma-core.c | 50 +++++++++++++++++++-------------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index 1c8aef5e03b0e2c93aec9f1cb0588b4e8b1508d9..9fb7ae4001207b2ccb058d6efa9856dded379b8f 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -106,6 +106,31 @@ static int dw_edma_start_transfer(struct dw_edma_chan *chan)
 	return 1;
 }
 
+static void dw_hdma_set_callback_result(struct virt_dma_desc *vd,
+					enum dmaengine_tx_result result)
+{
+	u32 residue = 0;
+	struct dw_edma_desc *desc;
+	struct dmaengine_result *res;
+
+	if (!vd->tx.callback_result)
+		return;
+
+	desc = vd2dw_edma_desc(vd);
+	if (desc) {
+		residue = desc->alloc_sz;
+
+		if (result == DMA_TRANS_NOERROR)
+			residue -= desc->burst[desc->start_burst - 1].xfer_sz;
+		else if (desc->done_burst)
+			residue -= desc->burst[desc->done_burst - 1].xfer_sz;
+	}
+
+	res = &vd->tx_result;
+	res->result = result;
+	res->residue = residue;
+}
+
 static void dw_edma_device_caps(struct dma_chan *dchan,
 				struct dma_slave_caps *caps)
 {
@@ -488,31 +513,6 @@ dw_edma_device_prep_interleaved_dma(struct dma_chan *dchan,
 	return dw_edma_device_transfer(&xfer, dw_edma_device_get_config(dchan, NULL));
 }
 
-static void dw_hdma_set_callback_result(struct virt_dma_desc *vd,
-					enum dmaengine_tx_result result)
-{
-	u32 residue = 0;
-	struct dw_edma_desc *desc;
-	struct dmaengine_result *res;
-
-	if (!vd->tx.callback_result)
-		return;
-
-	desc = vd2dw_edma_desc(vd);
-	if (desc) {
-		residue = desc->alloc_sz;
-
-		if (result == DMA_TRANS_NOERROR)
-			residue -= desc->burst[desc->start_burst - 1].xfer_sz;
-		else if (desc->done_burst)
-			residue -= desc->burst[desc->done_burst - 1].xfer_sz;
-	}
-
-	res = &vd->tx_result;
-	res->result = result;
-	res->residue = residue;
-}
-
 static void dw_edma_done_interrupt(struct dw_edma_chan *chan)
 {
 	struct dw_edma_desc *desc;

-- 
2.34.1


