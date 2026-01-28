Return-Path: <dmaengine+bounces-8559-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CM9MHeVQemnk5AEAu9opvQ
	(envelope-from <dmaengine+bounces-8559-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 28 Jan 2026 19:09:41 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A1BAAA7826
	for <lists+dmaengine@lfdr.de>; Wed, 28 Jan 2026 19:09:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9809230015AA
	for <lists+dmaengine@lfdr.de>; Wed, 28 Jan 2026 18:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C339737419D;
	Wed, 28 Jan 2026 18:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="gW6X2Lq6"
X-Original-To: dmaengine@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013040.outbound.protection.outlook.com [52.101.83.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45E1372B5D;
	Wed, 28 Jan 2026 18:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769623558; cv=fail; b=bChEqrmFZQGllSesTaNPZXkpZd1w4DRj3i2yhL6+wcWg00t6LQgPYySM7M+8WaaLvcYTt+wqGWL5HO4IADi20yMufgn1kWSEL/IRJJWlbAd1qktXb96H5xMKhLxbo5aMS2AKPGl4vrFwHAgrJENp1OmtBqypZu2uC4gWeL7tAjE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769623558; c=relaxed/simple;
	bh=gAsBE2ah1Lbrx0HXmMSNthkqL7+XI9w7fc//duOoH4g=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=g2eR1nblj6tw3lrBsQQZhwJSg0bXuyd5k0bHazcF7t5sQdOnuYVVbx/dlM1QXRi4DT1MiRAZkJqS+3xgdUO7HXy5XSOjV4D/1L/LemU6uukoz0oyy50pR0R8CNPdDk5ZwfRgSDb935KprizgCNau0p/yDRTnVK6ZYOZnJVbBqXQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=gW6X2Lq6; arc=fail smtp.client-ip=52.101.83.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z/1OzLK1MqMRHVvzb86S6hTi1RU4yUfemOUt9ODOtNOEjknN4Lk/L6DzuSwgr9v0/ZQ0W/6ibVR8s5YHKlNzJXgdh0Z19g6EabAvBRGitorhmuOqbnjQgpVAogOmAGJDvWMydtLqyHYcs1o/MKYDMyU61huvXyskzfXb3UWOBeDag2JbCDziUdF3bsxgSq689JC7TAPMg6dZFkWnfWRNqpCAI7lKD0JvFwYSPZUeezavYefCyTqnHAO1JHLxfvsT23REm/OWBiGhr83sC2+/nzT1RZOb9hGHEfJ7qYqJdRuqjMLnxT+Xiqi87YGQ/rzmcslD7gffzKavVPnXB4+CKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5H/6wapJW9zRPQR6qu4bKNb+ofZdq/MLrZ/VkKEcaoQ=;
 b=MdQ/TSLmsK4bZVfds1OLlCGa2AT+mY7N7TeAyIZbp/VrgYdVHwD3aha9PbQxXErpxMnfX3n0JCmbRuthm6LyAMTbp+83wml7hqW83sk9p2VIO3xecSOqQzYVR0JDZDNHLump164KnE6kO5Sg4gQlbbtJeKUyklQclHDWsltGt2ZK/GWQ63HVDJu6Nt7453qfm7SS5cNDLRw3tYo2swhpRT7KNuGnCvvd0nq3CmqRtj1XqNXAVA2jEV92BhYa3Om+hdAVJB4yj0B90BhO77pLMMa/tRxMdHKZjr+Sf16VzTk6xLIVxbSr4anjZ/apzOZkjNYIoaNUdXUeVpxhn9pFKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5H/6wapJW9zRPQR6qu4bKNb+ofZdq/MLrZ/VkKEcaoQ=;
 b=gW6X2Lq6ZG9r9CYmsNY02lfg3RRQJu3YspDqSqUE4L2geZ/j2JKGqqfjdbkNQ7Hu4zvYXIOExjh6dIIL75l7dEBQoGxtQaD8ZiPf4aTmhoVRxIiU5S+JNd/0//+13KMLrrhukxyXOHeuWTLI8h38fiMc0sLMb+R2ta9Ja0k6QPrLqinNVoTNAWgShQdIYp20bAISJUIFyORFHSbp9LGpm+eMG2mOAEUNcx2d0LnwYMMo9FsjO8596IzXg+ONn13kWw77n++bYBtq5AVvI1JQ4iG7aMsdV2AqYF03jusYEhO+EyjPElD8myro3Wmmy/eIllbWEyQkjyXDKNmROjGDUQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by AM9PR04MB8145.eurprd04.prod.outlook.com (2603:10a6:20b:3e1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.8; Wed, 28 Jan
 2026 18:05:52 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9520.005; Wed, 28 Jan 2026
 18:05:50 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 28 Jan 2026 13:05:21 -0500
Subject: [PATCH RFC 02/12] dmaengine: Add common dma_ll_desc and
 dma_linklist_item for link-list controllers
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260128-dma_ll_comlib-v1-2-1b1fa2c671f9@nxp.com>
References: <20260128-dma_ll_comlib-v1-0-1b1fa2c671f9@nxp.com>
In-Reply-To: <20260128-dma_ll_comlib-v1-0-1b1fa2c671f9@nxp.com>
To: Vinod Koul <vkoul@kernel.org>
Cc: linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, 
 imx@lists.linux.dev, joy.zou@nxp.com, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769623545; l=1669;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=gAsBE2ah1Lbrx0HXmMSNthkqL7+XI9w7fc//duOoH4g=;
 b=XFS1RIMhK1wec5T3bB43rZP7FsqCX7M1n5GPkKbacmGPHRbOR64d43WQGu1INyz8QpvvgaoiH
 snIDIOQwPhbAa5SfbAN4fQIuRVvh6pp3T89I54tuep2e9R/UKs+1kv2
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
X-MS-Office365-Filtering-Correlation-Id: f41723e9-2cfb-463c-7460-08de5e97dee1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SWpIYk03cXZtTktxYkVxMVhTelNib2phNjBvZUN5Z0wxN0ZLYyt2RDhONmpV?=
 =?utf-8?B?cjB3ajVEcXYrUkUrUzVQMzd6aXNONk1mcGR2NFVoSXQrcGJnclFGd1N2L0Fn?=
 =?utf-8?B?eEdlMGJwdmM5cE9jNDY5dlVnSlJ4OWgyZFJVZlhJK1QyNkcvSFU3Y1FIV0NJ?=
 =?utf-8?B?c09sUkRMdmVxdFVvZjRtN3oycE5PYnkzK3pGektOTFZQdUtpU0dCeGxQMzRv?=
 =?utf-8?B?TWwzdCtOblZHQnhXRDl2MGZBNlRGTHZZdXFCeCtRcHh5UkIxWUFPV3lmTldC?=
 =?utf-8?B?YVdXcklHZzVIUkM5Y3NTbjVScmNVWUowWHZOTHIyK1FwSndLTG1GNEQ0Wll3?=
 =?utf-8?B?QlJOUzFUS2YrcmwyNmdhSkxXR3VBbGpCNmRId0EvblVFQStwdytmMDJCWGpH?=
 =?utf-8?B?Z3RSTGFFT2RTTU4rd2VaT2FUNVZRVC9McWhtMlVzcFV1aUQyYzgyakFjU3pP?=
 =?utf-8?B?bGVTTkRDSThQaDl2dXY5dHlQY1JPZkQ1R3QzYmlaNk15aC9xY0hwd0lnVitw?=
 =?utf-8?B?NGNKL2F4VkpOU0hrbm9qdlZkUmpURWdQR2RFbjNLNjErUVc0aVY3dkVLMGU2?=
 =?utf-8?B?UEl0Z1RWeXk3OWxCRllqbERxNlV5ZVQvZElETkVhVVY1THppZFFtZmtLOXFT?=
 =?utf-8?B?OUhQTEd3cEo0NFMvMkswOXFUSjVkbzc4K2hRbnc5ZitmbmVNVUorYTM2YlpQ?=
 =?utf-8?B?QndHZmg1Y3BrQng4RXF6cUdJYzczZXcwWC9pUi92QzNrOThDaloxUWlYZmVz?=
 =?utf-8?B?R2RBWHNMa2ZTcFZtV3NvdHMxUGNwamE3MUMzdEYzVzRLNjE0Z0UrdjFUcFZG?=
 =?utf-8?B?V0tOYXJBNEVpZXNRaWJnVDR4Ny9xOVozYUJ6QWdjbnN2QUUxcVc5a0lwRnVI?=
 =?utf-8?B?ZWlNd1EzeDYyTTltMGpDLzRvNElqYXk1S3dlV2V1dHhBdmxFOXg2THpFTno3?=
 =?utf-8?B?dHBqUFlDNEFhNXBxMzJCc3BmMXJENk43QWd6ZlpLZWVIQytzUVBCVzQ3RWIw?=
 =?utf-8?B?VkVuV2FQblBvdzBtSEx1SXhWZCtVQlExbEJhcG9YcDVtNnRUUE1Ha1VFUnFP?=
 =?utf-8?B?U2RCS1grTjg0RUZBeUxRc1I1NitFbnljRExubXJvTWd3VXFRR0JDaCt3QWJa?=
 =?utf-8?B?L0tMMFk4WGRKRlp1bmFna2VUWSsrSTUrNkUxUUJpRzlUV0dGUWtSMXptQ0Fn?=
 =?utf-8?B?bzd3cTVoVm9tQ2k0RFo0SzJFVWNidG1TRlFKN2cyamptRW81YUdnbG94Nk9N?=
 =?utf-8?B?N2xpNk1oTGRmMmhYRXJIZnA5WVgwYWZTUCt0dEQ1VW9ZRjAyYndOTmRYL0Nj?=
 =?utf-8?B?cDI5WG1COC9tdHVLRjhMbWN6NXFFbzhwWG40MC9TdDJjbnhFcTZMWHNTUXZJ?=
 =?utf-8?B?UUljSnorcjdEZWRSQkxKTEwvVnZuTjc5aUxnRW1hUzBQeDI0b3dqZUpQUFkx?=
 =?utf-8?B?eHZocjdiTHVSVndDWVhmTHNrbjBKeURzSHpXdkZsRzhOdW9sSWt0VnAweUNI?=
 =?utf-8?B?cXZ4VnNjdFpaT0RYaFUvRFRqRkYvNzJvKzVrdTl3Tk82UitHMENWbUlVRXFn?=
 =?utf-8?B?bkZBT3ppc1o2Vk0rMXo1MGw2VDVaVDNzZUZDcVZSaC84RTF0c1NLYzIxbTFE?=
 =?utf-8?B?ZHNvL2dMYWRiK0Q1M2NhUjU1UW1mMkF2VGZFT2lJUlpXTUxNZGNibmhKMER2?=
 =?utf-8?B?WnhGZDlGSjJLakFIMEFNc3BvSHVEOUlRMHZBWEEvcVUvc2thQWxkVHlSTU1Z?=
 =?utf-8?B?VDJJODVSRktLaVFmS1FaVk44ZkFpTHFXQllJeXhYUDhZWG5XZkZIVVNuc2Z3?=
 =?utf-8?B?U0h2YWlTa0p6WlBRcXBRRFlHWTFISjU5N2pwckxBWjBzK2VOYTIxUW0yTUxB?=
 =?utf-8?B?SVFHeWVrenhGaGRHUVV5ZUg3bWNDMVJjN0tHTlg0SkpRaXVQc2l4dU1tTDl3?=
 =?utf-8?B?QTRmNmdTMldndW9mWnpoeC9PdzR0NHVqellidXpzZG9VZXBwYnMrUGp1ZCth?=
 =?utf-8?B?MktlNWF1K3lHdG5CMlBjcFJRTmpoZ29ERkFjdWRBZlpVak85amUvOWlkZWJL?=
 =?utf-8?B?Q1c1bXY1T1JzWis0TzYrUXhqYUFzb2FhY3J4RHZGa1EvL1pvQUJOSjhXSlJU?=
 =?utf-8?B?SHlFMGxJd1NFZzIvVHUvclNOUzExQ2k2QjIwNDIzc0g5d2kvcmd3UHNoTGZP?=
 =?utf-8?Q?ZVhILL7no1wFDL37Gu3UHTk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S3pjU25RL1dRQy9uSk9mMEdFQm0xMXpHcFZqTENBQnZ0VWIrWVcxcU42eEVk?=
 =?utf-8?B?blZqNlh3dkwyd2ZPUFdKSkNKdys4NzlqeU8zbHRoQmttTmVGYWtNRk9scFhj?=
 =?utf-8?B?VG5hMCtWbUpEazZoVzV2djdjM3RUcXBkY3ZSZ20zQjFCZ0JSOTBQNWNLUDMr?=
 =?utf-8?B?ek82UFRJc25MWStsRmJ3bUNMQ1F4akgyWjF6Z3VFTXI3SDZpbEFvTjIvSkhK?=
 =?utf-8?B?cDQyZDBSWGFnZFlrUElKd2JreCt3MDlaQy9VWXcwZzNzRndZY0pFbnhJWjlo?=
 =?utf-8?B?QTR5d0k5TGE5SXROVlZZN0l1Ynl5RjRQaENxSGdTaU4xYUg3Yy93L2lrbERO?=
 =?utf-8?B?dmhlbm10RS9NMTFTRGVPQVgzdkpkeGFFZFF3RDdzSEc4b3gwd3BkOE1QUDNw?=
 =?utf-8?B?TzJkZlBhc3FDQmJvR2l2NGVlSE91OWZSL0sySTAzMmZ2Wkp0ZDVtQzg2RDZZ?=
 =?utf-8?B?ZWdLWDZReWU4OWFFWHR5RU9HeTJKY3VlQlpLYkRQVHY0WWdpN1RlemphV3Fi?=
 =?utf-8?B?OHVzMW8zelpNUmduZFVieCtQZzljQkJRbDNBWjhhMlljakhyVUdPSkMzMXB3?=
 =?utf-8?B?d1ZseHNCUXN5S3ozMUI5OFQxbGNvRlo1aWk5VkVpaFF2SGhFOUFXL0NRSXd0?=
 =?utf-8?B?aG5lTU00dWIvWmlCeVg2aSs4N3Y2L05DVk1JWmU4YnlWN2h4N3dNWDNBQWN4?=
 =?utf-8?B?MjVNQjNMOU12bjdBanpXSFJGNVFwY2EyampmQ1FtV1dLQWxkMXpqMEFtQ3p3?=
 =?utf-8?B?aUc2ekIvNk5zN2EzZ3hURVAxYmFyK0t6VUgvTlZOdnVNZEZiZlN5TlpjR0pl?=
 =?utf-8?B?VFZacG5PVTlpWGplYWJmMmtKTkdXWktnTE5KdHl1eEUwbVlSeTlpZmh1UUw0?=
 =?utf-8?B?OUwvMVhrS09IdHdkdS9VZ3kxTnFWeG9oNWxEWFZ3Qldpem1nYXpLVVdsNjBK?=
 =?utf-8?B?RmJGQ1AxeE80Y3BXRDlPOHVCbGR5VWpqWktMcG5ENzM4ZUFuOTdlOEZHbVZ1?=
 =?utf-8?B?TmxBN1d5alFwTFQvMFdqeG82UFBIRUtLRWVlOHZrSVp5Z3NjVU9FTU5JNFFr?=
 =?utf-8?B?U2VLQTRWZ1VmYlNnS1UrWHIrWHBSdWRYTjNhUTc4ei81V3p2TUVlNWpadHk2?=
 =?utf-8?B?amZlaWRBS2RVTHlBT3dwNkVXRXRMVnc5UW5nU1RkQjZhYzR3OXNiNFpXakRY?=
 =?utf-8?B?L1pHSDRUOUdOa1hJb0VxdWU3VlhXdHJDY3VZeVJvY0x5ZG9YM2NCK0xpcmJr?=
 =?utf-8?B?RnRVVFJ6ZFoxY0tnUURGZHB5ODY1aTJSR3dNY00vQlkwUlNsWTRQQU5taEI4?=
 =?utf-8?B?aE1KVXpWakw1VGpYVkxhQUVMWkZGcGhWYkRKb3loRGxlaXh1Mk5yektjdWJu?=
 =?utf-8?B?eitwcDQ4SFJoN0RRRSt6OUUzZ2tYYnJ6WDl4RnpoN3FMamFZSEJvK1h2SmFy?=
 =?utf-8?B?S3kyS3lod3U0TW9nL3dMYUo0cGQrYjhOclVhcmNtcG11cXFuMy9hVXNpL3ZE?=
 =?utf-8?B?M2pYS1NpcDdoR3ZtSGFCeDdIS1huTy9IUk9MbkhUL2JtRWdFZmNvUjBMby9x?=
 =?utf-8?B?STdBZ0FEb0R6dmt4N3I0TWlWNXYycnNYT2VFM0dESmhhK05RRlUwOThuRkZx?=
 =?utf-8?B?NGx4cCs2QU4raHhPeGlTMFZJM1AzZ29MRFlUdllBUEZRTmRZNjlIRUFBN0k1?=
 =?utf-8?B?VXozYWNoWTBaSWsvY25tb1pkWTBzeGNFeTRCV0xuY2YwU3RBdXR6SEx3MFdo?=
 =?utf-8?B?SmUrN2RqcktHK1d0bUpUMFcra2Z5T296dGJEQ2VBVkUvSU8zTWN1S2tkZnNa?=
 =?utf-8?B?aTZuUndJYWw3bW9wa0gzTDltREkyUzNYZGh0ME90TlBLNkVJbFE4bnFBM0t2?=
 =?utf-8?B?TFJuUXVvSTJZRVloaFgwQS9QWEJ0M0J1SnVLOERvbzhITDUrR05NcDFId25i?=
 =?utf-8?B?OUswUHJ1SXlrN0hDMVJPdFVwSFFVNW9EbGM5cDUvY3N2MnJyUnpZM3QxTFNt?=
 =?utf-8?B?b1hVS1ViS3d0U0o2K2ptYXdNc20vb3Evc1RXeGowT2FnWjlpc1NoM21Kc3p2?=
 =?utf-8?B?aFplVUFXYUtRS0dSak83ZmppSnhTdHpXWm9PenNNakhSSkxaa21TRzZ5V0Vj?=
 =?utf-8?B?Uzhmb3Q4cEk3bDU3c1hrakh1MWZ1MUVOQXZxNTR1T1JNcEZLdy9jc09rb0J3?=
 =?utf-8?B?YW5EVUx0VUVqdWJMUVQwRXgxVkhIMElwTjlUdlBZaVBiQTVicWw2Y29MU1Fj?=
 =?utf-8?B?VEZDUGpyL2Fwdk9DY3JzN2V2ZmUwSDJ5UW41bEx3b3paZkNNYXR4SDdCaGJC?=
 =?utf-8?B?NXFoMlNOTmprLzNUUG5xaHV6M2FoaXB2bEl3UDMranB6bEhTN0FIQT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f41723e9-2cfb-463c-7460-08de5e97dee1
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 18:05:50.6895
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Dq6gfXBc9XfYKabCSxboIewPRewyHI038Sjiz//CA95ZpLcjNV6C8bY7DR4bQlSNC7H5hjZmGrypkuIAmPamg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8145
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	TAGGED_FROM(0.00)[bounces-8559-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.Li@nxp.com,dmaengine@vger.kernel.org];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[nxp.com:+]
X-Rspamd-Queue-Id: A1BAAA7826
X-Rspamd-Action: no action

Introduce common dma_ll_desc and dma_linklist_item structures for
link-list–based DMA controllers. This lays the groundwork for adding more
shared APIs to a common DMA link-list library and reduces duplication
across drivers.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/virt-dma.h | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/dma/virt-dma.h b/drivers/dma/virt-dma.h
index 081eb910d0b0cd2b60232736587c698fff787cb9..82f3f8244f6eca036a027c9a4c9339fcb87e8d2c 100644
--- a/drivers/dma/virt-dma.h
+++ b/drivers/dma/virt-dma.h
@@ -19,11 +19,32 @@ struct virt_dma_desc {
 	struct list_head node;
 };
 
+struct dma_linklist_item {
+	dma_addr_t paddr;
+	void *vaddr;
+};
+
+/*
+ * Must put to last one if need extend it
+ *   struct vendor_dma_ll_desc {
+ *	...
+ *	struct dma_ll_desc ldesc;
+ *   }
+ */
+struct dma_ll_desc {
+	struct virt_dma_desc vdesc;
+	bool iscyclic;
+	enum dma_transfer_direction dir;
+	u32 n_its;
+	struct dma_linklist_item its[];
+};
+
 struct dma_linklist_ops {
 	int (*stop)(struct dma_chan *chan);
 };
 
 struct dma_linklist {
+	struct dma_pool *pool;
 	const struct dma_linklist_ops *ops;
 };
 
@@ -247,6 +268,11 @@ static inline void vchan_synchronize(struct virt_dma_chan *vc)
 }
 
 #if IS_ENABLED(CONFIG_DMA_LINKLIST)
+static inline struct dma_ll_desc *to_dma_ll_desc(struct virt_dma_desc *vdesc)
+{
+	return container_of(vdesc, struct dma_ll_desc, vdesc);
+}
+
 int vchan_dma_ll_init(struct virt_dma_chan *vc,
 		      const struct dma_linklist_ops *ops, size_t size,
 		      size_t align, size_t boundary);

-- 
2.34.1


