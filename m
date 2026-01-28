Return-Path: <dmaengine+bounces-8561-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KANvH8hQemnk5AEAu9opvQ
	(envelope-from <dmaengine+bounces-8561-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 28 Jan 2026 19:09:12 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 22AA2A77F2
	for <lists+dmaengine@lfdr.de>; Wed, 28 Jan 2026 19:09:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E6D1A30328BE
	for <lists+dmaengine@lfdr.de>; Wed, 28 Jan 2026 18:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1697F376BD5;
	Wed, 28 Jan 2026 18:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="CYYOHBvD"
X-Original-To: dmaengine@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013040.outbound.protection.outlook.com [52.101.83.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 032FC374192;
	Wed, 28 Jan 2026 18:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769623563; cv=fail; b=jv7wxeoGhGD9TUIsOXYHbWG7eSPAmGn1A0/avS8SxTteQo0Jvsb+T+vulSRfbX0iJUUl+nyFJ90E+ial2WCAachlmK/sKzpztfSiAObI56JQ37AALKZ2fYI4AnWcXEdnxkZZ4e7/R19rPqhQlVgnZchrwf5vwTbF2GjfuNVmuvY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769623563; c=relaxed/simple;
	bh=ceG5CMSbcj29zpEeQr+qYgnT7Bsn3bmbIjY76x0dur4=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=M4FKWDuEY1IYH9xHZGwdTf7oIHjUIrfuEi19fNYekaGLwdOde66goWJAbrM33V+XP2Be200mCSmJrAw2XgIubpyQCTo2Wu3yu+z6AbKl4I86fsA0Yzas6sBsTrcA1DfgM3tlGauEGme/4k4I5QHK2DH9zExlqIJAbxkpUo/kVZ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=CYYOHBvD; arc=fail smtp.client-ip=52.101.83.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gc1Z5nxwQiecgIkUy/Pddj+A+HjeRtGOsbuKLm9MQutGaFKOO1wpXqA0jthGsRbIFpeQoRibyN8OSOyfHpV8/hMyLHFrFsR/GanKvkTXQ16AfaHAwNEYXNk9kIPnostmxRlEdBP0nIEs116d62IogCXl3yr/eUe/52zoGZn0tq+o4NHI/bEOQ8LFumVstqjfpPLJiNuMInhJiHxadj46xT/ejHr7UHFlNNokJxKDe7YFzt2fQFjKIuFOjoN093KvkYVhgHb/MqnCq4dhvE2k0D2YSaZcA3ux96emUxpF8hUS7zG8ZIYOY5m78ImOA6FkAMJ6D9x7aUvgMgboJLFjGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rDcYsJOyPt/0ZtO7BQYGHHI+YYTyC7C52SKwBudWWJA=;
 b=ZiFmijCwpltcMzD1fegpHNu/qnXYULWGPJdQqPe2xAJxpkjFB5t236H08Cqw4Fr2vfABLT0/8e8w9ec7miRAbmIpmGTcpVMQzfBAaRZIowp5y7uW5Tf/xKbHC8CtttxlNjmmhpDIBibdeBZKeVuUWE9G1Dsekzk5qq6M6Frr/vzqp6ojuFQOi3bfizBgfxqdzVc6GxoNOWWkpevdmEt3a0lF8uriDVwuqmaESGJtW9ofrjCRU/UhrnqRUwibBIIcxzLasffj/CQSbEOL4EvRypfUIrfBZCpXV+xGUQt2z5cumLx3vb9Es/CdH6Kpx6vFMWH1mNKQiEGlVf3VQ8kMpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rDcYsJOyPt/0ZtO7BQYGHHI+YYTyC7C52SKwBudWWJA=;
 b=CYYOHBvD+ht8S3gex4l08vfnLxOicNJzu5QgKcW374PjFYX8D9Eglp2KNv0I3l9hk2qvm8PRbA4urF7+44ROFBrEkF0wuRrTGW+ImtlpeX6Xa39mkvNmFpDSMTkbQyUY5yYV+8tOj+OZXTGORdJufiwPFoC8HrPlCybGTct7Df6zprnJGCrJAbMGIT1VjGw0U2+CaAwFJ3gpCvWzkuuXKvqd0oe3FPKjulO9lqVzte8XvGivXTaX2o0RnbIeKbL/yQptyw5KRCN9zfwpupgQ4civ2O2OkJjK18shIKV7PjFPSuxSgBvyiFZFQGgrO3TOen4o1tBXye70IpxnrJRPQg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by AM9PR04MB8145.eurprd04.prod.outlook.com (2603:10a6:20b:3e1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.8; Wed, 28 Jan
 2026 18:05:53 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9520.005; Wed, 28 Jan 2026
 18:05:53 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 28 Jan 2026 13:05:23 -0500
Subject: [PATCH RFC 04/12] dmaengine: fsl-edma: Use common dma_ll_desc in
 vchan
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260128-dma_ll_comlib-v1-4-1b1fa2c671f9@nxp.com>
References: <20260128-dma_ll_comlib-v1-0-1b1fa2c671f9@nxp.com>
In-Reply-To: <20260128-dma_ll_comlib-v1-0-1b1fa2c671f9@nxp.com>
To: Vinod Koul <vkoul@kernel.org>
Cc: linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, 
 imx@lists.linux.dev, joy.zou@nxp.com, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769623545; l=11897;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=ceG5CMSbcj29zpEeQr+qYgnT7Bsn3bmbIjY76x0dur4=;
 b=yeVsbRQi4U8sY9QEIaJ+d15CvNx9/FtzAcOAvu/K4Ff/lA2BMiYeWzJ3AE+QqSQUEUK5+Mc7f
 wLI4FU7AuNmDIzwtwm6PwCLjenXtrokhw4qWA75CxoJV4QxBCbHhNcA
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
X-MS-Office365-Filtering-Correlation-Id: 7ea071f1-a632-47ed-3a83-08de5e97e094
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RUJKYitUbW9yWVk1OUlzQlpUVE05NC9oaDN4Y2xNd3dHYlJnbDhZK1VvM3RL?=
 =?utf-8?B?c1F6R05MUE1xWFpEM1RHbXNmOXBJV1lSc3B4NG9EOFdxSnV0T2cvSGpYTmhR?=
 =?utf-8?B?c01HanlNazBUamtwQy9OSlNDTnVqZmpZd25odENrRHd0QS9iWlhmdWlzczNS?=
 =?utf-8?B?UkZxcm5yVU8rR0xZQUFmd0M3Sjh2QzAwVEorRXduU1pMaitnSVUwa01VVkph?=
 =?utf-8?B?VG5Kd016NlJmaDNCbnhpa0lFUDdlMEdxQ0dXUjBhaTRaaGJRTjZsSGEzdzZ3?=
 =?utf-8?B?M00vL1d4eWdXWElvaVU3L05BdWlPMmU0ekpLWWRBOWlLZVhxMjZGK0ZnaWE0?=
 =?utf-8?B?RldFWG9kdkR4TmFuTU5aUnNuZnRyUU9LeFh6ZGllWVNGUldZZ3MrQ3BvTFcz?=
 =?utf-8?B?ZFYwVittNkcwRVh1VG1yWFpXYm9LV1NucTVRbWUwOFpVYW9zU3FCKy9ESUJm?=
 =?utf-8?B?T1JpZVMwY2trQldaNFo1RlhXbFhVVmJhT3Y1aFMxWUFwbWl1L3ZhcEptcXl1?=
 =?utf-8?B?RzdncEQzRWRCTnNxeDh2ODdpQVI3NXQwWVF3NGRISVZUbHViMXNvQ3RjSHZG?=
 =?utf-8?B?cVdiS2dpZHg3WGc1UWRhd1FWSDdqMk11TEp2bmQ2REVkU3hpSDhNcWtJUmpp?=
 =?utf-8?B?L1lwbmVPaTRSVjN6bUVEUmRTdjI1akh5UFdKUHpTKzdtRXhXUm9TQnAxamZJ?=
 =?utf-8?B?NTYwM3g1Qjd0VzZienFzekY2R016YlFxdHFQcmhoaUtXb1NIMjJZaDBLei9F?=
 =?utf-8?B?eW12YUU0a1o4ck04M2duamtieFRLOXI5aTlLdmcvZndTK2w1azZoTVUyS05U?=
 =?utf-8?B?SlMrekJNdjdRTzRIby9kTWtBei9KOTNZVktBTW15N1Z3MW9WVmxjMkhrWWNM?=
 =?utf-8?B?N0UzdzNsaVQxY3k3MmtHbTVqZHpOMXEvQzFRR2ZybVlVZHJ5Yk1LL1B3eGVx?=
 =?utf-8?B?M09iYW9JeXc2OTY4OExpdS9aZExYVXlqNGw0TlZZOU5XMWtBRmlHeUsyVU9m?=
 =?utf-8?B?dHlZUmJDWlF0OEFHaC9DbGdxNTZWQ3VhaDd4eG1oS1lnL24zam5PYWpMZHgz?=
 =?utf-8?B?Z25GUCszTUtETnhVV0srK2tsN2lLSkZUalBhL2RkZmJhdm5xNUpZRVFtSkVC?=
 =?utf-8?B?OTgzL3dDc1NMM1lldzVmc2FVM3J1VnpUS0dSTy9vM293VmNZbEtQdFVvZUxx?=
 =?utf-8?B?MUcvc3RES1JoNktFeHBJK2UreEdqdkRURE5LRXZtQ05FU0hDMnVrY3YxSkJI?=
 =?utf-8?B?K3RRRU5iOWVrcGlIRUc1TG1hM0VObzAzYnhVOFNod2ZSbC9HL3U0NlNhRWFs?=
 =?utf-8?B?aU85aXBOS0t5bDM5UDRSRjFib2VHWFdqczhSS2R1YmRpMjVBMVg3MG8vK0t6?=
 =?utf-8?B?WHVEa2QxTmd0MSt0ZmRuMVJ3KzZ2S0ZYcEQ0b0ZBTms5YkJiMjFOWmJmYW51?=
 =?utf-8?B?MW9rcjg1SVcxVnA4aDU1Vzdwd0p5Vk9kL1JwSmhwd0RYcTY0QWpZRVVsWUpV?=
 =?utf-8?B?WjZpMTJZZEVPQzNoK1hkL3doQ3h4ckJqQnlNUlRZbkU1bnB6b0VkQUFUYjR3?=
 =?utf-8?B?YnJlR1NSbVV4Rm9FZUFTS2kvaUNQYkR3UVFnQUFvV2NOZll1dE00S0FIWno1?=
 =?utf-8?B?Rm1VNlYyQjdqTkxGSlk1TjBid1BaZk5uMVpTWnZoR0JmbnZYSmNuU2J4MG1T?=
 =?utf-8?B?ZmZubzg4K1pyQVo1OVBTdWJZeXhDUFpnV3pnZGowaG5BZHBmODM4NnpheEpW?=
 =?utf-8?B?dnNKcnNML0EvSTgvV3ByeUFYRGs1TG1RRTkyK05JbWNvcGFQc0trbkw4NTZ4?=
 =?utf-8?B?TnNFb3hvaEoxOWRVV0owMFhCM2t1eU9hQk9uNWp4SEVxakNWWW96MlV4RlFz?=
 =?utf-8?B?dW02UUxmZ1hNbWcyVjRtZ215RXFWRlpMaWx3dE81Y1hYNHZGMzZzNXcrY0FZ?=
 =?utf-8?B?cWcrTEJzZUlSZTRvNVozclhac2ZnWlQrckM0OUdxMDFndE5oWTBzRUhXRjNx?=
 =?utf-8?B?UkQ3RE1wOHRTaWhrNVV2UWdLSnA5Yk5wL1ZrTGQ5UWxEZnRReXp2NWgxLzFv?=
 =?utf-8?B?cjFuWExUclVMdXhtdXlQTGRBTnQ4S3dSQ1B4bi90WHVlZjZZM2dVMEtNUFZM?=
 =?utf-8?B?SFZzVzJKNlgwSTZ5cEE2azJMOUszVi9lZWN6MExvTVY4TmhtQlc5eFhJTkNB?=
 =?utf-8?Q?nvn3pdRncKIMa/t4DH9tB7c=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Uy9MTW5COGlVaHpVZTNyVHI4eFBwa1VIOWQvVGZEQXp0UDUxTG9jbFBxWjg3?=
 =?utf-8?B?MHdaSDg4b29VMEFiRnJNcDMrdWNQd3RlQWttUHNTM2ZqbTAwLzR5V1d2R1pH?=
 =?utf-8?B?cGJuUEJYc3hTQlB5NWhubThEb0s5Qm1qanFGbHVLQ215cytyQ1dyUWwvYkRC?=
 =?utf-8?B?T3I1ZWg3ZVk3VVdBTXRDclMybU43ZnI0dUdSMGlMd1lGSitUbWZ3TE5BM000?=
 =?utf-8?B?N2hjS211SHNnbGsyM240bDdBeVhsRjBOcmlVQllEaXdrNVdNUWxxMzk0VG95?=
 =?utf-8?B?ZlBKZUtmb3pHUlliZy9uYnBVMzd0bmFZbFBWd0ZvN1JIYVUzMTFoUks4Zmhm?=
 =?utf-8?B?R0REaG9LTVdlaWpESEZCQmZRUHBiUSs0Y1M1MWN6VDZ0cWttN0VvM0RvVkNq?=
 =?utf-8?B?S3BnWWZodGx4T1RGODFDdG9XWEdTaXQ3eXRBTmNUenVYYTN4V2lKZEYrOUFN?=
 =?utf-8?B?L0NRRzhOazI0VzdJR2o5d3ZnUjBqbEhhMVA5bWlUVEswNUlHcTdvZ050cGZ3?=
 =?utf-8?B?Wm94SzltWGh2Z3Bvd01hV1B3a25PNTVOYjQ3QzFNRGNDc3RMQnBzZWNVa1Fh?=
 =?utf-8?B?VFloTDNiQmRSSWtMcTlGRlRpcDN3Uml4VUU3bkRYZkVZSHgvYmFDTGg4MUNI?=
 =?utf-8?B?OWQxalFCMWhhOVp6YlZDK2taQm9sNTZwV3ZFRmt2WFYvQ09weFZUTmJsYjlr?=
 =?utf-8?B?UjBYY0UyMmlJOU5hV2ZMQUJQVkNjZjM5emFCUUpFWVFldzFkaUxHTGlwZVZI?=
 =?utf-8?B?b05FUW15ZVpTUnhlTXJOV2k4UHAwY3l5MFRGMzNMb2dmUS9SZGZEc2pFQk9x?=
 =?utf-8?B?emJHcnBDbFE1eFNZRmFOQ2xuVEFiamlqRTdLUTBCUzQ1a3MrQ0ZKdTNtWW0r?=
 =?utf-8?B?NzNRR09QTGpJaERNUklJR0NqSXVUR2RDOC83MXpsTWVmL0ZmeXkvaFNFTEZL?=
 =?utf-8?B?WjlRMHVWSXVGVGIvNDFuY2pvdWZDVzRJNkI5N2VGcFpseUY0Y2s5NGV4NVVr?=
 =?utf-8?B?eTlzZElTUU1Zb3MxSFRKRnkzTmp6NU1NdVh0bUlXR3pzcEhNT3FjN0FuMVg0?=
 =?utf-8?B?S21UOGcrbHEza0tRU2FTZE9HOTg2MzV2a3hUcHRIOGdsY2pUMnVHVFpzbm1o?=
 =?utf-8?B?Q3c1TnIzMlZjaHgrQUR5TXRYME1mMmdhbk43RTArRkFXWU9SdDF4VDZpRzVL?=
 =?utf-8?B?cGdjb0RMelhrSFlTbGRTbUU5dmxjdERwTS9rdFE4amJwTzhhR1NGb0VMbW1w?=
 =?utf-8?B?OVFFWERqeGx2djBYNG12aXpZWXdSOG9JRmlkZEZDZHBxM3JMYTFwdzFSQ3RY?=
 =?utf-8?B?UFlROHR1VEl0NS9VY3IwdUhUMjZka0dPRFZnbkpNd2xtVWYzajBTMVZkekFH?=
 =?utf-8?B?bFNwbDhQL2xzL0JoWXVPaVdNMEhwY2RvQkJKWVhLc1hwVnVESG9SSGVaMDVJ?=
 =?utf-8?B?TktiOVh0SzRGNkNhUWgvRHE5M1A3ajcyaU0rOER4WUprR1B1VTZ2UnVZMGJu?=
 =?utf-8?B?SUpzdnoyNGZBT054QjliOUVGVUtSRUZCZDhCWmhhWkZFT25CRkNpblZOR0dm?=
 =?utf-8?B?T3A1czhOcTMzUkRmMm9lQ0tna0J5U0RNSStNcEE0MkZTYnVrY2dOWENYWWhO?=
 =?utf-8?B?YzVscUNXUVdIU2xtUW05R3BSc2VUUWdjVmNPYTIxR2NONHVwMmxCUVBiQ2dx?=
 =?utf-8?B?T3ptWmYvZXpuMCtDQUJ0NE1rZ3RPM0VaYkh5MTdHRWxMbmRBaFJXQjVJcG9q?=
 =?utf-8?B?aFpJclFtc3N0YjlUTm04VFFNcGdYTHVSenRKUW1wdWd0WSt3RVBRMWpFSEJT?=
 =?utf-8?B?eEtseG5aZkZRNzNsUnlCdDBNR052aXVwSm1NbWxjRWVTcDJLbnMwV0x3MHlt?=
 =?utf-8?B?SWlPR2hIOTkzQ2JUNzI5dEhTYlJ6WDNDSUZIZzNteWYrOWhSRHBMRU1CUnE3?=
 =?utf-8?B?Ky9MQTk0cys5R3JuMXRWMFBLQUNoZXRLNlVKdmpSTVp4YzB2UjVuUmNUdmNK?=
 =?utf-8?B?TkloS1RsSTRoN3pVcXBodkV4Z1ZxL3YxZU9uaEZMbEtaZFdOOFIvOTRSWHN4?=
 =?utf-8?B?MnRZdDJHV2VScldjeDZxR0VEdFJ6WElzTjFDTkhVLzh3emREUzJDTXpidFZj?=
 =?utf-8?B?RnBmdFYxNFpoTFZwOExsdkY4TzNpNnJrMFhValJVMlEvNE9ha3V5QjEyMlJi?=
 =?utf-8?B?UzlKMm03NElIaGxxU2h0bjVWSDJIK25IQVZQYzFBcjBCTWprRy96cWxrSitU?=
 =?utf-8?B?bHI1aUNHOTZnUmxwNVo5OXVzcWJtQ0o3SW9CM1hCVnYrNXBaeWtXaGxEQUpj?=
 =?utf-8?B?TnJ3aG43YzdBMEl5TVFHQ3FlRjNiVTFEZ2YxdHJSUDhxZU1rR2x5UT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ea071f1-a632-47ed-3a83-08de5e97e094
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 18:05:53.5231
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H7XEn3jPymlH2ZdLDkyLPDUsxlAyZWnDUtQbaTwHr2kcqitAVAj6ykiacrF94GfHl78HfPqq/uSdXxZJsby4PA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8145
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	TAGGED_FROM(0.00)[bounces-8561-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.Li@nxp.com,dmaengine@vger.kernel.org];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[nxp.com:+]
X-Rspamd-Queue-Id: 22AA2A77F2
X-Rspamd-Action: no action

Use the common dma_ll_desc structure in the virtual channel implementation
to prepare for adding more shared APIs to the DMA link-list library.

No functional change.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/fsl-edma-common.c | 95 ++++++++++++++++++++++---------------------
 drivers/dma/fsl-edma-common.h | 20 +--------
 2 files changed, 50 insertions(+), 65 deletions(-)

diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
index 61387c4edc910c8a806cc2c6f0fee2e690424bac..17a8e28037f5e61d4aafbd7f32bde407ecc01a4d 100644
--- a/drivers/dma/fsl-edma-common.c
+++ b/drivers/dma/fsl-edma-common.c
@@ -223,14 +223,14 @@ static unsigned int fsl_edma_get_tcd_attr(enum dma_slave_buswidth src_addr_width
 
 void fsl_edma_free_desc(struct virt_dma_desc *vdesc)
 {
-	struct fsl_edma_desc *fsl_desc;
+	struct dma_ll_desc *fsl_desc;
 	int i;
 
-	fsl_desc = to_fsl_edma_desc(vdesc);
-	for (i = 0; i < fsl_desc->n_tcds; i++)
-		dma_pool_free(to_fsl_edma_chan(vdesc->tx.chan)->tcd_pool,
-			      fsl_desc->tcd[i].vtcd,
-			      fsl_desc->tcd[i].ptcd);
+	fsl_desc = to_dma_ll_desc(vdesc);
+	for (i = 0; i < fsl_desc->n_its; i++)
+		dma_pool_free(to_virt_chan(vdesc->tx.chan)->ll.pool,
+			      fsl_desc->its[i].vaddr,
+			      fsl_desc->its[i].paddr);
 	kfree(fsl_desc);
 }
 
@@ -342,19 +342,19 @@ int fsl_edma_slave_config(struct dma_chan *chan,
 static size_t fsl_edma_desc_residue(struct fsl_edma_chan *fsl_chan,
 		struct virt_dma_desc *vdesc, bool in_progress)
 {
-	struct fsl_edma_desc *edesc = fsl_chan->edesc;
-	enum dma_transfer_direction dir = edesc->dirn;
+	struct dma_ll_desc *edesc = fsl_chan->edesc;
+	enum dma_transfer_direction dir = edesc->dir;
 	dma_addr_t cur_addr, dma_addr, old_addr;
 	size_t len, size;
 	u32 nbytes = 0;
 	int i;
 
 	/* calculate the total size in this desc */
-	for (len = i = 0; i < fsl_chan->edesc->n_tcds; i++) {
-		nbytes = fsl_edma_get_tcd_to_cpu(fsl_chan, edesc->tcd[i].vtcd, nbytes);
+	for (len = i = 0; i < fsl_chan->edesc->n_its; i++) {
+		nbytes = fsl_edma_get_tcd_to_cpu(fsl_chan, edesc->its[i].vaddr, nbytes);
 		if (nbytes & (EDMA_V3_TCD_NBYTES_DMLOE | EDMA_V3_TCD_NBYTES_SMLOE))
 			nbytes = EDMA_V3_TCD_NBYTES_MLOFF_NBYTES(nbytes);
-		len += nbytes * fsl_edma_get_tcd_to_cpu(fsl_chan, edesc->tcd[i].vtcd, biter);
+		len += nbytes * fsl_edma_get_tcd_to_cpu(fsl_chan, edesc->its[i].vaddr, biter);
 	}
 
 	if (!in_progress)
@@ -372,17 +372,17 @@ static size_t fsl_edma_desc_residue(struct fsl_edma_chan *fsl_chan,
 	} while (upper_32_bits(cur_addr) != upper_32_bits(old_addr));
 
 	/* figure out the finished and calculate the residue */
-	for (i = 0; i < fsl_chan->edesc->n_tcds; i++) {
-		nbytes = fsl_edma_get_tcd_to_cpu(fsl_chan, edesc->tcd[i].vtcd, nbytes);
+	for (i = 0; i < fsl_chan->edesc->n_its; i++) {
+		nbytes = fsl_edma_get_tcd_to_cpu(fsl_chan, edesc->its[i].vaddr, nbytes);
 		if (nbytes & (EDMA_V3_TCD_NBYTES_DMLOE | EDMA_V3_TCD_NBYTES_SMLOE))
 			nbytes = EDMA_V3_TCD_NBYTES_MLOFF_NBYTES(nbytes);
 
-		size = nbytes * fsl_edma_get_tcd_to_cpu(fsl_chan, edesc->tcd[i].vtcd, biter);
+		size = nbytes * fsl_edma_get_tcd_to_cpu(fsl_chan, edesc->its[i].vaddr, biter);
 
 		if (dir == DMA_MEM_TO_DEV)
-			dma_addr = fsl_edma_get_tcd_to_cpu(fsl_chan, edesc->tcd[i].vtcd, saddr);
+			dma_addr = fsl_edma_get_tcd_to_cpu(fsl_chan, edesc->its[i].vaddr, saddr);
 		else
-			dma_addr = fsl_edma_get_tcd_to_cpu(fsl_chan, edesc->tcd[i].vtcd, daddr);
+			dma_addr = fsl_edma_get_tcd_to_cpu(fsl_chan, edesc->its[i].vaddr, daddr);
 
 		len -= size;
 		if (cur_addr >= dma_addr && cur_addr < dma_addr + size) {
@@ -546,29 +546,30 @@ void fsl_edma_fill_tcd(struct fsl_edma_chan *fsl_chan,
 	trace_edma_fill_tcd(fsl_chan, tcd);
 }
 
-static struct fsl_edma_desc *fsl_edma_alloc_desc(struct fsl_edma_chan *fsl_chan,
-		int sg_len)
+static struct dma_ll_desc *
+fsl_edma_alloc_desc(struct fsl_edma_chan *fsl_chan, int sg_len)
 {
-	struct fsl_edma_desc *fsl_desc;
+	struct dma_ll_desc *fsl_desc;
 	int i;
 
-	fsl_desc = kzalloc(struct_size(fsl_desc, tcd, sg_len), GFP_NOWAIT);
+	fsl_desc = kzalloc(struct_size(fsl_desc, its, sg_len), GFP_NOWAIT);
 	if (!fsl_desc)
 		return NULL;
 
-	fsl_desc->n_tcds = sg_len;
+	fsl_desc->n_its = sg_len;
 	for (i = 0; i < sg_len; i++) {
-		fsl_desc->tcd[i].vtcd = dma_pool_alloc(fsl_chan->tcd_pool,
-					GFP_NOWAIT, &fsl_desc->tcd[i].ptcd);
-		if (!fsl_desc->tcd[i].vtcd)
+		fsl_desc->its[i].vaddr = dma_pool_alloc(fsl_chan->vchan.ll.pool,
+							GFP_NOWAIT,
+							&fsl_desc->its[i].paddr);
+		if (!fsl_desc->its[i].vaddr)
 			goto err;
 	}
 	return fsl_desc;
 
 err:
 	while (--i >= 0)
-		dma_pool_free(fsl_chan->tcd_pool, fsl_desc->tcd[i].vtcd,
-				fsl_desc->tcd[i].ptcd);
+		dma_pool_free(fsl_chan->vchan.ll.pool, fsl_desc->its[i].vaddr,
+			      fsl_desc->its[i].paddr);
 	kfree(fsl_desc);
 	return NULL;
 }
@@ -580,7 +581,7 @@ struct dma_async_tx_descriptor *fsl_edma_prep_dma_cyclic(
 {
 	struct fsl_edma_chan *fsl_chan = to_fsl_edma_chan(chan);
 	struct dma_slave_config *cfg = &chan->config;
-	struct fsl_edma_desc *fsl_desc;
+	struct dma_ll_desc *fsl_desc;
 	dma_addr_t dma_buf_next;
 	bool major_int = true;
 	int sg_len, i;
@@ -599,7 +600,7 @@ struct dma_async_tx_descriptor *fsl_edma_prep_dma_cyclic(
 	if (!fsl_desc)
 		return NULL;
 	fsl_desc->iscyclic = true;
-	fsl_desc->dirn = direction;
+	fsl_desc->dir = direction;
 
 	dma_buf_next = dma_addr;
 	if (direction == DMA_MEM_TO_DEV) {
@@ -625,7 +626,7 @@ struct dma_async_tx_descriptor *fsl_edma_prep_dma_cyclic(
 			dma_buf_next = dma_addr;
 
 		/* get next sg's physical address */
-		last_sg = fsl_desc->tcd[(i + 1) % sg_len].ptcd;
+		last_sg = fsl_desc->its[(i + 1) % sg_len].paddr;
 
 		if (direction == DMA_MEM_TO_DEV) {
 			src_addr = dma_buf_next;
@@ -649,7 +650,7 @@ struct dma_async_tx_descriptor *fsl_edma_prep_dma_cyclic(
 			major_int = false;
 		}
 
-		fsl_edma_fill_tcd(fsl_chan, fsl_desc->tcd[i].vtcd, src_addr, dst_addr,
+		fsl_edma_fill_tcd(fsl_chan, fsl_desc->its[i].vaddr, src_addr, dst_addr,
 				  fsl_chan->attr, soff, nbytes, 0, iter,
 				  iter, doff, last_sg, major_int, false, true);
 		dma_buf_next += period_len;
@@ -665,7 +666,7 @@ struct dma_async_tx_descriptor *fsl_edma_prep_slave_sg(
 {
 	struct fsl_edma_chan *fsl_chan = to_fsl_edma_chan(chan);
 	struct dma_slave_config *cfg = &chan->config;
-	struct fsl_edma_desc *fsl_desc;
+	struct dma_ll_desc *fsl_desc;
 	struct scatterlist *sg;
 	dma_addr_t src_addr, dst_addr, last_sg;
 	u16 soff, doff, iter;
@@ -682,7 +683,7 @@ struct dma_async_tx_descriptor *fsl_edma_prep_slave_sg(
 	if (!fsl_desc)
 		return NULL;
 	fsl_desc->iscyclic = false;
-	fsl_desc->dirn = direction;
+	fsl_desc->dir = direction;
 
 	if (direction == DMA_MEM_TO_DEV) {
 		if (!cfg->src_addr_width)
@@ -745,14 +746,14 @@ struct dma_async_tx_descriptor *fsl_edma_prep_slave_sg(
 		}
 		iter = sg_dma_len(sg) / nbytes;
 		if (i < sg_len - 1) {
-			last_sg = fsl_desc->tcd[(i + 1)].ptcd;
-			fsl_edma_fill_tcd(fsl_chan, fsl_desc->tcd[i].vtcd, src_addr,
+			last_sg = fsl_desc->its[(i + 1)].paddr;
+			fsl_edma_fill_tcd(fsl_chan, fsl_desc->its[i].vaddr, src_addr,
 					  dst_addr, fsl_chan->attr, soff,
 					  nbytes, 0, iter, iter, doff, last_sg,
 					  false, false, true);
 		} else {
 			last_sg = 0;
-			fsl_edma_fill_tcd(fsl_chan, fsl_desc->tcd[i].vtcd, src_addr,
+			fsl_edma_fill_tcd(fsl_chan, fsl_desc->its[i].vaddr, src_addr,
 					  dst_addr, fsl_chan->attr, soff,
 					  nbytes, 0, iter, iter, doff, last_sg,
 					  true, true, false);
@@ -767,7 +768,7 @@ struct dma_async_tx_descriptor *fsl_edma_prep_memcpy(struct dma_chan *chan,
 						     size_t len, unsigned long flags)
 {
 	struct fsl_edma_chan *fsl_chan = to_fsl_edma_chan(chan);
-	struct fsl_edma_desc *fsl_desc;
+	struct dma_ll_desc *fsl_desc;
 	u32 src_bus_width, dst_bus_width;
 
 	src_bus_width = min_t(u32, DMA_SLAVE_BUSWIDTH_32_BYTES, 1 << (ffs(dma_src) - 1));
@@ -783,10 +784,10 @@ struct dma_async_tx_descriptor *fsl_edma_prep_memcpy(struct dma_chan *chan,
 		fsl_chan->is_remote = true;
 
 	/* To match with copy_align and max_seg_size so 1 tcd is enough */
-	fsl_edma_fill_tcd(fsl_chan, fsl_desc->tcd[0].vtcd, dma_src, dma_dst,
-			fsl_edma_get_tcd_attr(src_bus_width, dst_bus_width),
-			src_bus_width, len, 0, 1, 1, dst_bus_width, 0, true,
-			true, false);
+	fsl_edma_fill_tcd(fsl_chan, fsl_desc->its[0].vaddr, dma_src, dma_dst,
+			  fsl_edma_get_tcd_attr(src_bus_width, dst_bus_width),
+			  src_bus_width, len, 0, 1, 1, dst_bus_width, 0, true,
+			  true, false);
 
 	return vchan_tx_prep(&fsl_chan->vchan, &fsl_desc->vdesc, flags);
 }
@@ -800,8 +801,8 @@ void fsl_edma_xfer_desc(struct fsl_edma_chan *fsl_chan)
 	vdesc = vchan_next_desc(&fsl_chan->vchan);
 	if (!vdesc)
 		return;
-	fsl_chan->edesc = to_fsl_edma_desc(vdesc);
-	fsl_edma_set_tcd_regs(fsl_chan, fsl_chan->edesc->tcd[0].vtcd);
+	fsl_chan->edesc = to_dma_ll_desc(vdesc);
+	fsl_edma_set_tcd_regs(fsl_chan, fsl_chan->edesc->its[0].vaddr);
 	fsl_edma_enable_request(fsl_chan);
 	fsl_chan->status = DMA_IN_PROGRESS;
 }
@@ -855,7 +856,8 @@ int fsl_edma_alloc_chan_resources(struct dma_chan *chan)
 	if (ret)
 		return ret;
 
-	fsl_chan->tcd_pool = dma_pool_create("tcd_pool", chan->device->dev,
+	fsl_chan->vchan.ll.pool =
+		dma_pool_create("tcd_pool", chan->device->dev,
 				fsl_edma_drvflags(fsl_chan) & FSL_EDMA_DRV_TCD64 ?
 				sizeof(struct fsl_edma_hw_tcd64) : sizeof(struct fsl_edma_hw_tcd),
 				32, 0);
@@ -880,7 +882,8 @@ int fsl_edma_alloc_chan_resources(struct dma_chan *chan)
 	if (fsl_chan->txirq)
 		free_irq(fsl_chan->txirq, fsl_chan);
 err_txirq:
-	dma_pool_destroy(fsl_chan->tcd_pool);
+	dma_pool_destroy(fsl_chan->vchan.ll.pool);
+	clk_disable_unprepare(fsl_chan->clk);
 
 	return ret;
 }
@@ -907,8 +910,8 @@ void fsl_edma_free_chan_resources(struct dma_chan *chan)
 		free_irq(fsl_chan->errirq, fsl_chan);
 
 	vchan_dma_desc_free_list(&fsl_chan->vchan, &head);
-	dma_pool_destroy(fsl_chan->tcd_pool);
-	fsl_chan->tcd_pool = NULL;
+	dma_pool_destroy(fsl_chan->vchan.ll.pool);
+	fsl_chan->vchan.ll.pool = NULL;
 	fsl_chan->is_sw = false;
 	fsl_chan->srcid = 0;
 	fsl_chan->is_remote = false;
diff --git a/drivers/dma/fsl-edma-common.h b/drivers/dma/fsl-edma-common.h
index a0d83ad783f7a53caab93d280c6e40f63b8e9e5c..56d219d57b852e0769cbead11fadac89913747e2 100644
--- a/drivers/dma/fsl-edma-common.h
+++ b/drivers/dma/fsl-edma-common.h
@@ -155,17 +155,12 @@ struct edma_regs {
 	void __iomem *errl;
 };
 
-struct fsl_edma_sw_tcd {
-	dma_addr_t			ptcd;
-	void				*vtcd;
-};
-
 struct fsl_edma_chan {
 	struct virt_dma_chan		vchan;
 	enum dma_status			status;
 	enum fsl_edma_pm_state		pm_state;
 	struct fsl_edma_engine		*edma;
-	struct fsl_edma_desc		*edesc;
+	struct dma_ll_desc		*edesc;
 	u32				attr;
 	bool                            is_sw;
 	struct dma_pool			*tcd_pool;
@@ -194,14 +189,6 @@ struct fsl_edma_chan {
 	bool				is_multi_fifo;
 };
 
-struct fsl_edma_desc {
-	struct virt_dma_desc		vdesc;
-	bool				iscyclic;
-	enum dma_transfer_direction	dirn;
-	unsigned int			n_tcds;
-	struct fsl_edma_sw_tcd		tcd[];
-};
-
 #define FSL_EDMA_DRV_HAS_DMACLK		BIT(0)
 #define FSL_EDMA_DRV_MUX_SWAP		BIT(1)
 #define FSL_EDMA_DRV_CONFIG32		BIT(2)
@@ -468,11 +455,6 @@ static inline struct fsl_edma_chan *to_fsl_edma_chan(struct dma_chan *chan)
 	return container_of(chan, struct fsl_edma_chan, vchan.chan);
 }
 
-static inline struct fsl_edma_desc *to_fsl_edma_desc(struct virt_dma_desc *vd)
-{
-	return container_of(vd, struct fsl_edma_desc, vdesc);
-}
-
 static inline void fsl_edma_err_chan_handler(struct fsl_edma_chan *fsl_chan)
 {
 	fsl_chan->status = DMA_ERROR;

-- 
2.34.1


