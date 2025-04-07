Return-Path: <dmaengine+bounces-4844-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D6BFA7E742
	for <lists+dmaengine@lfdr.de>; Mon,  7 Apr 2025 18:52:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75993165028
	for <lists+dmaengine@lfdr.de>; Mon,  7 Apr 2025 16:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3B552139D4;
	Mon,  7 Apr 2025 16:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="OKA1E8p1"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2077.outbound.protection.outlook.com [40.107.103.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C6B21147D;
	Mon,  7 Apr 2025 16:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744044428; cv=fail; b=GFBPlEP7I++WSnkjx/iAcSYcZmz/7Q0V/ruQVR07cNM48ZZICuT5iry/5T25TiVz4ld5QQxFuR2EVaIFsvk6lzanCqS61+PujxmhRYOeCZ6AczfKKSTrTNDbdNC0YlSnHbKOPvRPDe9VbW6vuh3wQct2u9njsVVeuVmx5lVuv6k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744044428; c=relaxed/simple;
	bh=1AFVQHt4H23CcosWD8DcZzdIorbj1T3FaPy8ZCMZkvE=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=qjoNYlr4MrpHwI/k9p7UUJgY5uB98k0EE98r1f+LR0rCOe28gmHNnmVU/OxHmAcdCsk+1LxdXqtwEpWGzepglFRFMS2rESofLietHb2uCPxAm4EKp/++oZH/hWQyMXvIKuLVIkhXn4jVO5JUDpkV/USjm0327DTZY3X7sjQ5C+w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=OKA1E8p1; arc=fail smtp.client-ip=40.107.103.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ec2jhxoUm1foHFimxvvWvuWDNkOA7R2TTDbW9I6liONkC07bJWkG1SJ4EJllT7+vSFTbfOf/k5z4aCbKD6Z5hxY5+X24WyBD9jQLnEc5/+vRWUMTgHuyyV2TCRollfuIwdVGvWPNoW9URnimjafbuGiqbfE+hgxQ11nyb/+EI6r9ttHtP4hqCdG6oHo5gX3E3dIglWNo5sLJWLXb/sRngmCYAqgGEvlNJoSa7EZC88ZbAObM4ESyFgHpkuk7iPeoYjA28qnf/2dBzZ9c7Dl8YTEY+e/ASFevHsXJdQeDAhVWVs9QnXtPibNaJFWZOMbz24cy3kGo901QiFkMnKEvgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IXCYBvQHP6LoD8UvUjr2imJ3HBeclffkcBbYNbZRrcY=;
 b=iR/tATZj9GSj2Z43BUvJxmfZ0F+Gq7oBxkgxFPYmtk58l10kwCLQpAi7zemzxEQe3jPB5w6YXLp1JSmBN8/tyMJmp+Dj/HyZXN8rrWsubQUk2dwHqZ+5tawMHmGYEyPydNvvYJmKyaJkk2iqsIjKfdMOYBiCBUs1LRFS/HKr5ZvKg9Q1ArU5+PWGxLzFcILUju1Ai5dKFdO2LO1X3ScDFEUeFhDctnLG8+CMX1pq6Po18uke7hjUEwJwUrmMfwXjXdId+4XSsM95t75j3Ig6mfOS+13FGQiwcmAIz/fqMvk9scGPriQzGJYIfFIX9Tm2fryy/tjQiAlJZAJ1A5vqSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IXCYBvQHP6LoD8UvUjr2imJ3HBeclffkcBbYNbZRrcY=;
 b=OKA1E8p1AHknD6e95qGd9l7DD3/ss25iBJN9AZLEocgNoLNUrr1r4r10NUQP+1rGiZkC+6y3vb7Edo9ZfIMlyTkFZv4Q3fTWwJ0eqc2dLt7SYoUbUuOs+QAzx50CxCyrVy3C+q0BavC3i42D9Q5briVgFdpcDXQAwYSXzkHjcMMm3tkoYo7nqVrRJxP9mJ3aE6NTrPhFZMiY0f8Rz+xxpxNf75o/jTYZinHfzr0G5X1kzbrBwhF6ZTyxCGmbloiwkk4/HwlPAsbA6KlfL9fMmcWbYZj0ZJtvCRgtHlgdEpRugcSMdlnukCKTlfFWdNpzIXpHBfgHOKyELsbHxRczIQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM7PR04MB7029.eurprd04.prod.outlook.com (2603:10a6:20b:118::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.33; Mon, 7 Apr
 2025 16:47:03 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.8606.029; Mon, 7 Apr 2025
 16:47:03 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 07 Apr 2025 12:46:36 -0400
Subject: [PATCH v2 2/3] dmaegnine: fsl-edma: add edma error interrupt
 handler
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250407-edma_err-v2-2-9d7e5b77fcc4@nxp.com>
References: <20250407-edma_err-v2-0-9d7e5b77fcc4@nxp.com>
In-Reply-To: <20250407-edma_err-v2-0-9d7e5b77fcc4@nxp.com>
To: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Peng Fan <peng.fan@nxp.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: imx@lists.linux.dev, dmaengine@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Frank Li <Frank.Li@nxp.com>, 
 Joy Zou <joy.zou@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744044406; l=10170;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=LD6Mp7AzKiFOHMUjSiRbTwVIAnQ+zTBqUt1To6QgEGs=;
 b=c4S+b13BD+b4d/L3v4s5sBQhq0TVsEKD1MF315h0P3igZTBADsBA6ThgfePbuY46fN41Q6UMc
 yejUcGGKpLHDBp1aAbXnpimAGwyn3Kd9DDDHjEqgCfKlCLP5NrlxZ/a
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR03CA0243.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::8) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM7PR04MB7029:EE_
X-MS-Office365-Filtering-Correlation-Id: 729e436c-d24a-45e6-8721-08dd75f3d2e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S2RNZVZGWFA0UFVPK3B6M1pFQlVvbnJhY0JPSXRkUzFkMHZKdGhDT3ZudzJF?=
 =?utf-8?B?ZkRBSUpzU2R3bDZnMzhUdlY2bUtlNjJzUGlNREpBRmtBamtGNEVlb0hLbDdo?=
 =?utf-8?B?d3ZEeTBtcy9Yc2VWakJLY3Y1aWd1R0ZRam9FNUZKbDZtaEZMWmVib1o5Q0N4?=
 =?utf-8?B?OG81MlhEeUlwcWdMaTE5dWdDejExalprVUsvWnZJTHJxWkhXNGU3YTFjbTh1?=
 =?utf-8?B?WFB3enh5ZENTNy9IdUJlT21Vb2lBY3poZ2FUbWhmM3kva0w3QU1vc2tiOXk2?=
 =?utf-8?B?Rks5OFFYblY0YUc3eWFxa01BenpZc2sxWnROSzFDWG1RVXlld0NNRUNYWnZO?=
 =?utf-8?B?SXBGUXYraitUV2IzVmRPZHVhMlFId1FFZGVDUFUwWHBWMHd3RXNGOHdRWUNo?=
 =?utf-8?B?RXh0ZGZTU0gyT3hIamt5aE1BUEFWN3AzbUlLbHVHR2pJVVdDL0l2eC9yeWts?=
 =?utf-8?B?WUt2ZDlLMUNJRUlmS3JORGJ4SzAzbnJjTVBoTHNWMVJzVmhEaWV1NTVQeHNI?=
 =?utf-8?B?UmJvUnlKT1M4eUMvekFKRnRTS3Z3cEt3TTh0bk5lK3J4ZHp4eE9BY2hNcThH?=
 =?utf-8?B?ZU9vSjlDem92ZU9wa1QrQll5OE1JUkVhbElBTTlGcit4UDU0TW1UZ0RieVFY?=
 =?utf-8?B?OUlrbkI3T1J1cnN4aTIrZVYweWpOUkx3UkpzSXY2bW40Z3F5MHZ2c1d1WmdJ?=
 =?utf-8?B?WVRRRkdPck1nakV6cEJIMGF1N29mY2lzVDVvb3E2UnRSZzJINGZxRDU0ODZC?=
 =?utf-8?B?YVFzQS9XcmpSWmV2OFZ3eXduTjYzUUdQVHV6OHpFZ2pWU2dXbzZueVd0MStI?=
 =?utf-8?B?L3V3MFVkQVVTZ3hYZCtiWWdVNTBSaEk3eFV0RitRS0dVMEJxSG5JRkhORCtq?=
 =?utf-8?B?RDhLaVQ1OCtMbUFTSC9TM3JQTkc5SmhFcXlMM1pSWCsxMS90L3VSSlNwMjQy?=
 =?utf-8?B?ZEpKRDRyRXNhNXhlUGd1aklFVTNrUHMyRmkveUVFaXVoNDVEdGhMb01XY3Zs?=
 =?utf-8?B?QldPTWxtajN5RGdESUJYTkNnUlBtTWZrTUY0cnRBRmJybitmRlBwVXU1TG9k?=
 =?utf-8?B?VUxSOHlTdGdsa0RUV1d1YzUzZjBjeG94WXBONnozcTRRWTdmNXRDWnc4TTd3?=
 =?utf-8?B?NnpadExmU1NXVVVBNTM2WW1rZHJHcnFiUTVOSldoZXZmRUFkSFoxWVJabTBV?=
 =?utf-8?B?Z0xHY2d0SkUzVGc1MFd5eGVPTlAvc3BkN1BQT3VncWxZWlBKWVo0K3VaOHE5?=
 =?utf-8?B?RFMveEsvL1dyZkNnaEwrbkNMb3lVVGxiaE5Vd3RzMkJYdXYwTDZYeHl2WEo1?=
 =?utf-8?B?TFBhelJwOE1YQ044WVMwS1F3YXR0MzhQS3VHOEQ5RVhBWjFqVTZrMTFZMklR?=
 =?utf-8?B?MGlZaHVpaEt5MW1DMVh1ZjgzcEovY00zVnF4cyszdVhOemdwbkRqK0RHQ3Zu?=
 =?utf-8?B?ZUdwSEZhdjJKN1BhK0FPUDlydXMyUlJjTDNDSngrQXREbmhaUzgyUnIwdmI4?=
 =?utf-8?B?Rmo3YjlTSjc2Z21OZURSMGQvV3Z5Umhqd1dBUmY4Ukg5SFRuWFl1ZzRydkRP?=
 =?utf-8?B?Z0Q4cytYM0FiU0owSVRlNzBuKzk5RHVFcEx3RUlMdDZYTDl1OC9uZXBnOEtN?=
 =?utf-8?B?SVByNDN3TE1BOHZDN01lM005dVU0WDdHdzdvdVZpeDBSWlBEWkt0N2E5SlNr?=
 =?utf-8?B?Z0NxSWp6TEhvL2hWT1REL1M2N0JQWTltb3FMalRYck9sa1hCSHQ5aEt6cUlu?=
 =?utf-8?B?T0JOYnBtSGxNNXg4YjhEbmZQVVB3di9GNVE0SVBGSmlreHMrSEkxYTdLa3ZT?=
 =?utf-8?B?RzJyNlZYQXdGTXY3RTlUUUl1REpZMDhBNDI1bVUwSnFjanNmekpjaVUyMHQz?=
 =?utf-8?B?Z3oyWTZhZFR0YXNLZ1pjcjBscGN0bmVtUXZpVXV6WTN0N2J2WU40ZjduY29T?=
 =?utf-8?Q?HkjMV5svrxKk4iU1UaYGA9/TiBEsU2Oq?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MU5tK0tydEVoaTgwUTF1UnAvdGZuNWJ3M0I1SlFkSTNOckJFeWFNamIzZHhh?=
 =?utf-8?B?MElHWU5pbzdubzc1dlp0b1N4cVdvUnV3czRVWmhBR1FYMnB3cXpMK0w3MkpN?=
 =?utf-8?B?VVVjelNKY1JuZXRTTU8rUWJ1bXd4bUtTZGd3SGRUcUo1L2hIWTJZdngxclFU?=
 =?utf-8?B?WnFPdks4VjJEZm9BMWpWSk5GV25MOUNrM1VJdWhnYUdIK1c1YUJyRVNtL05N?=
 =?utf-8?B?blVreGUwalcyZzZkWThHdEdFYTRCa1Q0eEtzZ2owbkgxOUVSa0R4WDFHSVAw?=
 =?utf-8?B?QUFtYm1Qb0dDVlFWRC83bTdzM24wTXdOS0FHUjBlazhMdkZQNmRaVWF2V0ZZ?=
 =?utf-8?B?eVlnYzV6UHBQR1hBR2N5RmhtVXEwL3JXeWgrSGtlcDhaRk00K0MrK0hFK1VI?=
 =?utf-8?B?V2NVM3ZqY3NwYzZReVNMSjBmNGFRLzdMQVdQZDg0R2lMSzNtWVVhd3BOanZB?=
 =?utf-8?B?NU1mOEowaFhCR293ckhjSkd2bUN6cytyQ2VqZXZTc1dRcTQ4MHBZYjhOMEJK?=
 =?utf-8?B?TDZUMkNqREpBUkhreUl6Ylk2VUFBNm5GQXZOK3FDWmhRdnBRaXI2aVY4RHo1?=
 =?utf-8?B?MkR2UDFTaGNTMlhWOUxPVmtKUEZFNzhSOWpoWHVUV1pUOFJJVGxhNjZ6T2hD?=
 =?utf-8?B?di9uVFpyeDYyNk9rdFptNlg0VTJKMmhmeUZvejlobDNvTi9SdTF6L3U2RU5s?=
 =?utf-8?B?UnBlVmVseHNFNy9ING1peEYrK0JMNlM4RE1YRFZJd1JGYUp5K2hzeWNWNkYz?=
 =?utf-8?B?YzNYbm5iaXh4YnlETlNYL3RlSE44Mm9iZmZBRmpWNFJGV3llTkVVQXNpZ0hM?=
 =?utf-8?B?Y2hQMTN2YUx4YjYrbXlXUlgzaEQzTm9mdkMvV3ByMEhUSHpMZndZazBmQ2pN?=
 =?utf-8?B?R2pGTmFKMS9OZzhTVXJjM09YeENDaEZ6YUdWU0JoTkEybm5mL1dVQlhtV2Uy?=
 =?utf-8?B?cHBGNFQ5K1VENWlMWFFJVnNTdHB4UTVqTzV6N0lNYWErRjRnT1lNMnVFTkpu?=
 =?utf-8?B?Z0cvUEVKSllIWEhhQkpneXJ4a0ZSTDRiQ0NpRStvbmwweVFvWXlsejhqalFy?=
 =?utf-8?B?ZXVvamlHMFpSa0lYQWRlWXlZTjdManlGL1RQNTFJVGpvZk9KTWN5Y1dvcmdw?=
 =?utf-8?B?MnJ1WERyNjVtQjVJMnVJSEh5SEVzK1dTbmhyR3FJUE9WcG05cFA3TDNDOUJq?=
 =?utf-8?B?cHBZM2J6d3BGREt6MFJ6c1I4aHpleWd4TkRpOUsvK0dzdmQrV3I5NkhLdlVO?=
 =?utf-8?B?YzV6T0lXditLcWtoNGkrTlhnVUZUMThmSHEwVEFZMWtnaWV5YWdyZHF3bVFU?=
 =?utf-8?B?QmlWdlNwdWRxRCtHT1hmdVd0K2huQisrRnR2TEsrY0VJWk9wRWl4UHB6Yjc1?=
 =?utf-8?B?cGEzTEpTM21ES2hWY2VNWGV0NFNTVXUySTBaNDZBMnMxMkh6eXR0SkkrNmFy?=
 =?utf-8?B?T2FHL2Jhc2Y5UHNkOVJVOWlnRlpPak8vTnRDcUFyNEt1TlY4ZHg1cjFBS1R1?=
 =?utf-8?B?UzdjUGZHMTdiT1VtaXlJSy9oQklnM1RCWGw1ZnBuRUdPQWR4b1ZBTEVEeDF4?=
 =?utf-8?B?TkUrcmd1RkpGK05HSS9BTGtaNFVaSE5OUTIwRXFqQ2FkelRYWXJDSlVTSzlO?=
 =?utf-8?B?eUhLNkExOHd0TzA2OUorZ2IyUUZyWXF0dDNiR1lIaFk2RmM0ZEZ5dzRFcDRn?=
 =?utf-8?B?Mys1Z1poQUkwMWVoYzhuMFlBY3Jnc1IyL2tNZVZNR3lOeTFLYXRTQXQzSWll?=
 =?utf-8?B?RTlCcjNnUWJWekNiQmVWWFBIdTB4WWozUGJKeEc5dkVXNlAybUNiVm9VYUg1?=
 =?utf-8?B?SEY3dXpHanV2ME1uZmNwRkNCZ2xMSnZHTmtDUHJZd1ZhdFdVblMzK2dCMlcv?=
 =?utf-8?B?b0ZjY1Rhc2V0SWp1VVZicGhGenhBZ29QWENpODJNSERHb3JwR2NnUHV2KzlH?=
 =?utf-8?B?bGdmdW0yN2NaQktmZ09DdjlSaUhVNEcyYmo5Z2hXcktRKzVRRXVqVTlUS0ZV?=
 =?utf-8?B?MzFSL2dTTTlwNTk5MEdQbjZzNHFtejVkMmY5MThxb0JhUWlDQVBDNml3dkd0?=
 =?utf-8?B?SDJ3dWQ0VTBUVDhRLy8yekQ4SnJzYjlKZXRUQmFkUXl4dUl0d1A3bE4yL1NW?=
 =?utf-8?Q?n5oa/IgKd8wPhvwdD/8BfMtc4?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 729e436c-d24a-45e6-8721-08dd75f3d2e9
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 16:47:03.6415
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MD41jmgC1HCBN19heYLdiokj+8oUxIrRgthP6oekL3X0DXEdVZOWwWvhPC55/lGLe99xCGB7uBX/W2ZLZQDgkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7029

From: Joy Zou <joy.zou@nxp.com>

Add the edma error interrupt handler because it's useful to debug issue.

i.MX8ULP edma has per channel error interrupt.

i.MX91/93/95 and i.MX8QM/QXP/DXL edma share one error interrupt.

Signed-off-by: Joy Zou <joy.zou@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/fsl-edma-common.c |  30 ++++++++---
 drivers/dma/fsl-edma-common.h |  18 +++++++
 drivers/dma/fsl-edma-main.c   | 114 ++++++++++++++++++++++++++++++++++++++++--
 3 files changed, 149 insertions(+), 13 deletions(-)

diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
index 443b2430466cb..4976d7dde0809 100644
--- a/drivers/dma/fsl-edma-common.c
+++ b/drivers/dma/fsl-edma-common.c
@@ -95,7 +95,7 @@ static void fsl_edma3_enable_request(struct fsl_edma_chan *fsl_chan)
 	}
 
 	val = edma_readl_chreg(fsl_chan, ch_csr);
-	val |= EDMA_V3_CH_CSR_ERQ;
+	val |= EDMA_V3_CH_CSR_ERQ | EDMA_V3_CH_CSR_EEI;
 	edma_writel_chreg(fsl_chan, val, ch_csr);
 }
 
@@ -821,7 +821,7 @@ void fsl_edma_issue_pending(struct dma_chan *chan)
 int fsl_edma_alloc_chan_resources(struct dma_chan *chan)
 {
 	struct fsl_edma_chan *fsl_chan = to_fsl_edma_chan(chan);
-	int ret;
+	int ret = 0;
 
 	if (fsl_edma_drvflags(fsl_chan) & FSL_EDMA_DRV_HAS_CHCLK)
 		clk_prepare_enable(fsl_chan->clk);
@@ -831,17 +831,29 @@ int fsl_edma_alloc_chan_resources(struct dma_chan *chan)
 				sizeof(struct fsl_edma_hw_tcd64) : sizeof(struct fsl_edma_hw_tcd),
 				32, 0);
 
-	if (fsl_chan->txirq) {
+	if (fsl_chan->txirq)
 		ret = request_irq(fsl_chan->txirq, fsl_chan->irq_handler, IRQF_SHARED,
 				 fsl_chan->chan_name, fsl_chan);
 
-		if (ret) {
-			dma_pool_destroy(fsl_chan->tcd_pool);
-			return ret;
-		}
-	}
+	if (ret)
+		goto err_txirq;
+
+	if (fsl_chan->errirq > 0)
+		ret = request_irq(fsl_chan->errirq, fsl_chan->errirq_handler, IRQF_SHARED,
+				  fsl_chan->errirq_name, fsl_chan);
+
+	if (ret)
+		goto err_errirq;
 
 	return 0;
+
+err_errirq:
+	if (fsl_chan->txirq)
+		free_irq(fsl_chan->txirq, fsl_chan);
+err_txirq:
+	dma_pool_destroy(fsl_chan->tcd_pool);
+
+	return ret;
 }
 
 void fsl_edma_free_chan_resources(struct dma_chan *chan)
@@ -862,6 +874,8 @@ void fsl_edma_free_chan_resources(struct dma_chan *chan)
 
 	if (fsl_chan->txirq)
 		free_irq(fsl_chan->txirq, fsl_chan);
+	if (fsl_chan->errirq)
+		free_irq(fsl_chan->errirq, fsl_chan);
 
 	vchan_dma_desc_free_list(&fsl_chan->vchan, &head);
 	dma_pool_destroy(fsl_chan->tcd_pool);
diff --git a/drivers/dma/fsl-edma-common.h b/drivers/dma/fsl-edma-common.h
index 10a5565ddfd76..205a964890948 100644
--- a/drivers/dma/fsl-edma-common.h
+++ b/drivers/dma/fsl-edma-common.h
@@ -71,6 +71,18 @@
 #define EDMA_V3_CH_ES_ERR          BIT(31)
 #define EDMA_V3_MP_ES_VLD          BIT(31)
 
+#define EDMA_V3_CH_ERR_DBE	BIT(0)
+#define EDMA_V3_CH_ERR_SBE	BIT(1)
+#define EDMA_V3_CH_ERR_SGE	BIT(2)
+#define EDMA_V3_CH_ERR_NCE	BIT(3)
+#define EDMA_V3_CH_ERR_DOE	BIT(4)
+#define EDMA_V3_CH_ERR_DAE	BIT(5)
+#define EDMA_V3_CH_ERR_SOE	BIT(6)
+#define EDMA_V3_CH_ERR_SAE	BIT(7)
+#define EDMA_V3_CH_ERR_ECX	BIT(8)
+#define EDMA_V3_CH_ERR_UCE	BIT(9)
+#define EDMA_V3_CH_ERR		BIT(31)
+
 enum fsl_edma_pm_state {
 	RUNNING = 0,
 	SUSPENDED,
@@ -162,6 +174,7 @@ struct fsl_edma_chan {
 	u32				dma_dev_size;
 	enum dma_data_direction		dma_dir;
 	char				chan_name[32];
+	char				errirq_name[36];
 	void __iomem			*tcd;
 	void __iomem			*mux_addr;
 	u32				real_count;
@@ -174,7 +187,9 @@ struct fsl_edma_chan {
 	int                             priority;
 	int				hw_chanid;
 	int				txirq;
+	int				errirq;
 	irqreturn_t			(*irq_handler)(int irq, void *dev_id);
+	irqreturn_t			(*errirq_handler)(int irq, void *dev_id);
 	bool				is_rxchan;
 	bool				is_remote;
 	bool				is_multi_fifo;
@@ -208,6 +223,9 @@ struct fsl_edma_desc {
 /* Need clean CHn_CSR DONE before enable TCD's MAJORELINK */
 #define FSL_EDMA_DRV_CLEAR_DONE_E_LINK	BIT(14)
 #define FSL_EDMA_DRV_TCD64		BIT(15)
+/* All channel ERR IRQ share one IRQ line */
+#define FSL_EDMA_DRV_ERRIRQ_SHARE       BIT(16)
+
 
 #define FSL_EDMA_DRV_EDMA3	(FSL_EDMA_DRV_SPLIT_REG |	\
 				 FSL_EDMA_DRV_BUS_8BYTE |	\
diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
index 756d67325db52..32a52a6acd60b 100644
--- a/drivers/dma/fsl-edma-main.c
+++ b/drivers/dma/fsl-edma-main.c
@@ -50,6 +50,83 @@ static irqreturn_t fsl_edma_tx_handler(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+static void fsl_edma3_err_check(struct fsl_edma_chan *fsl_chan)
+{
+	unsigned int ch_err;
+	u32 val;
+
+	scoped_guard(spinlock, &fsl_chan->vchan.lock) {
+		ch_err = edma_readl_chreg(fsl_chan, ch_es);
+		if (!(ch_err & EDMA_V3_CH_ERR))
+			return;
+
+		edma_writel_chreg(fsl_chan, EDMA_V3_CH_ERR, ch_es);
+		val = edma_readl_chreg(fsl_chan, ch_csr);
+		val &= ~EDMA_V3_CH_CSR_ERQ;
+		edma_writel_chreg(fsl_chan, val, ch_csr);
+	}
+
+	/* Ignore this interrupt since channel has been disabled already */
+	if (!fsl_chan->edesc)
+		return;
+
+	if (ch_err & EDMA_V3_CH_ERR_DBE)
+		dev_err(&fsl_chan->pdev->dev, "Destination Bus Error interrupt.\n");
+
+	if (ch_err & EDMA_V3_CH_ERR_SBE)
+		dev_err(&fsl_chan->pdev->dev, "Source Bus Error interrupt.\n");
+
+	if (ch_err & EDMA_V3_CH_ERR_SGE)
+		dev_err(&fsl_chan->pdev->dev, "Scatter/Gather Configuration Error interrupt.\n");
+
+	if (ch_err & EDMA_V3_CH_ERR_NCE)
+		dev_err(&fsl_chan->pdev->dev, "NBYTES/CITER Configuration Error interrupt.\n");
+
+	if (ch_err & EDMA_V3_CH_ERR_DOE)
+		dev_err(&fsl_chan->pdev->dev, "Destination Offset Error interrupt.\n");
+
+	if (ch_err & EDMA_V3_CH_ERR_DAE)
+		dev_err(&fsl_chan->pdev->dev, "Destination Address Error interrupt.\n");
+
+	if (ch_err & EDMA_V3_CH_ERR_SOE)
+		dev_err(&fsl_chan->pdev->dev, "Source Offset Error interrupt.\n");
+
+	if (ch_err & EDMA_V3_CH_ERR_SAE)
+		dev_err(&fsl_chan->pdev->dev, "Source Address Error interrupt.\n");
+
+	if (ch_err & EDMA_V3_CH_ERR_ECX)
+		dev_err(&fsl_chan->pdev->dev, "Transfer Canceled interrupt.\n");
+
+	if (ch_err & EDMA_V3_CH_ERR_UCE)
+		dev_err(&fsl_chan->pdev->dev, "Uncorrectable TCD error during channel execution interrupt.\n");
+
+	fsl_chan->status = DMA_ERROR;
+}
+
+static irqreturn_t fsl_edma3_err_handler_per_chan(int irq, void *dev_id)
+{
+	struct fsl_edma_chan *fsl_chan = dev_id;
+
+	fsl_edma3_err_check(fsl_chan);
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t fsl_edma3_err_handler_shared(int irq, void *dev_id)
+{
+	struct fsl_edma_engine *fsl_edma = dev_id;
+	unsigned int ch;
+
+	for (ch = 0; ch < fsl_edma->n_chans; ch++) {
+		if (fsl_edma->chan_masked & BIT(ch))
+			continue;
+
+		fsl_edma3_err_check(&fsl_edma->chans[ch]);
+	}
+
+	return IRQ_HANDLED;
+}
+
 static irqreturn_t fsl_edma3_tx_handler(int irq, void *dev_id)
 {
 	struct fsl_edma_chan *fsl_chan = dev_id;
@@ -309,7 +386,8 @@ fsl_edma_irq_init(struct platform_device *pdev, struct fsl_edma_engine *fsl_edma
 
 static int fsl_edma3_irq_init(struct platform_device *pdev, struct fsl_edma_engine *fsl_edma)
 {
-	int i;
+	char *errirq_name;
+	int i, ret;
 
 	for (i = 0; i < fsl_edma->n_chans; i++) {
 
@@ -324,6 +402,27 @@ static int fsl_edma3_irq_init(struct platform_device *pdev, struct fsl_edma_engi
 			return  -EINVAL;
 
 		fsl_chan->irq_handler = fsl_edma3_tx_handler;
+
+		if (!(fsl_edma->drvdata->flags & FSL_EDMA_DRV_ERRIRQ_SHARE)) {
+			fsl_chan->errirq = fsl_chan->txirq;
+			fsl_chan->errirq_handler = fsl_edma3_err_handler_per_chan;
+		}
+	}
+
+	/* All channel err use one irq number */
+	if (fsl_edma->drvdata->flags & FSL_EDMA_DRV_ERRIRQ_SHARE) {
+		/* last one is error irq */
+		fsl_edma->errirq = platform_get_irq_optional(pdev, fsl_edma->n_chans);
+		if (fsl_edma->errirq < 0)
+			return 0; /* dts miss err irq, treat as no err irq case */
+
+		errirq_name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "%s-err",
+					     dev_name(&pdev->dev));
+
+		ret = devm_request_irq(&pdev->dev, fsl_edma->errirq, fsl_edma3_err_handler_shared,
+				       0, errirq_name, fsl_edma);
+		if (ret)
+			return dev_err_probe(&pdev->dev, ret, "Can't register eDMA err IRQ.\n");
 	}
 
 	return 0;
@@ -464,7 +563,8 @@ static struct fsl_edma_drvdata imx7ulp_data = {
 };
 
 static struct fsl_edma_drvdata imx8qm_data = {
-	.flags = FSL_EDMA_DRV_HAS_PD | FSL_EDMA_DRV_EDMA3 | FSL_EDMA_DRV_MEM_REMOTE,
+	.flags = FSL_EDMA_DRV_HAS_PD | FSL_EDMA_DRV_EDMA3 | FSL_EDMA_DRV_MEM_REMOTE
+		 | FSL_EDMA_DRV_ERRIRQ_SHARE,
 	.chreg_space_sz = 0x10000,
 	.chreg_off = 0x10000,
 	.setup_irq = fsl_edma3_irq_init,
@@ -481,14 +581,15 @@ static struct fsl_edma_drvdata imx8ulp_data = {
 };
 
 static struct fsl_edma_drvdata imx93_data3 = {
-	.flags = FSL_EDMA_DRV_HAS_DMACLK | FSL_EDMA_DRV_EDMA3,
+	.flags = FSL_EDMA_DRV_HAS_DMACLK | FSL_EDMA_DRV_EDMA3 | FSL_EDMA_DRV_ERRIRQ_SHARE,
 	.chreg_space_sz = 0x10000,
 	.chreg_off = 0x10000,
 	.setup_irq = fsl_edma3_irq_init,
 };
 
 static struct fsl_edma_drvdata imx93_data4 = {
-	.flags = FSL_EDMA_DRV_HAS_CHMUX | FSL_EDMA_DRV_HAS_DMACLK | FSL_EDMA_DRV_EDMA4,
+	.flags = FSL_EDMA_DRV_HAS_CHMUX | FSL_EDMA_DRV_HAS_DMACLK | FSL_EDMA_DRV_EDMA4
+		 | FSL_EDMA_DRV_ERRIRQ_SHARE,
 	.chreg_space_sz = 0x8000,
 	.chreg_off = 0x10000,
 	.mux_off = 0x10000 + offsetof(struct fsl_edma3_ch_reg, ch_mux),
@@ -498,7 +599,7 @@ static struct fsl_edma_drvdata imx93_data4 = {
 
 static struct fsl_edma_drvdata imx95_data5 = {
 	.flags = FSL_EDMA_DRV_HAS_CHMUX | FSL_EDMA_DRV_HAS_DMACLK | FSL_EDMA_DRV_EDMA4 |
-		 FSL_EDMA_DRV_TCD64,
+		 FSL_EDMA_DRV_TCD64 | FSL_EDMA_DRV_ERRIRQ_SHARE,
 	.chreg_space_sz = 0x8000,
 	.chreg_off = 0x10000,
 	.mux_off = 0x200,
@@ -700,6 +801,9 @@ static int fsl_edma_probe(struct platform_device *pdev)
 		snprintf(fsl_chan->chan_name, sizeof(fsl_chan->chan_name), "%s-CH%02d",
 							   dev_name(&pdev->dev), i);
 
+		snprintf(fsl_chan->errirq_name, sizeof(fsl_chan->errirq_name),
+			 "%s-CH%02d-err", dev_name(&pdev->dev), i);
+
 		fsl_chan->edma = fsl_edma;
 		fsl_chan->pm_state = RUNNING;
 		fsl_chan->srcid = 0;

-- 
2.34.1


