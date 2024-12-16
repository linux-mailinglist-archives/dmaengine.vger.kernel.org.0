Return-Path: <dmaengine+bounces-3978-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ACF29F2B4F
	for <lists+dmaengine@lfdr.de>; Mon, 16 Dec 2024 09:00:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F0C018871D2
	for <lists+dmaengine@lfdr.de>; Mon, 16 Dec 2024 08:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8360E20103F;
	Mon, 16 Dec 2024 07:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="EXWDehPW"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2070.outbound.protection.outlook.com [40.107.20.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98381201018;
	Mon, 16 Dec 2024 07:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734335927; cv=fail; b=H1oyi0jTuseg4Dr2ZOJDEWb+lmVO+s7rumlmgBs40+Mf6F/QQZdP100Z0OXVbnpz0hn7BcpqsdbiKpEIAs821sY8W1wQQGXoPZcUxNVuR9QKsw32zjrwna3IUyegJFfUbqkV2h2TchP2h9IhzsndVrYX6hqhbNN/P4MaWakpr0Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734335927; c=relaxed/simple;
	bh=QNMrE4cGtLRiu6GXLbpQl+n4TI93KWI5YCfGuvQpDRw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FnBmpuY7CJgqh62GuNYf8kliCjk4ikK+qdSuV2Jd5x6jAKNzXzaJ3Vgaj38Z8xQeQLoMUd9f3xPa2Ssne/rTC5vUHN8tTOWk2MDo1sxKEfu2MN4CaXo3mWyH6lTPUmQDF0xJoezn6uToZUIsCOjWdTxQtqihxoL49VlT9QSoIag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=EXWDehPW; arc=fail smtp.client-ip=40.107.20.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i4qGZgA/ALEP/9d/KCBckPuZHuLFZgJzhE5m7NsS6iJm40XrGSE+awe31rKYp9RUoAjbntd8sL50y0cF8eoyUizNwLC2arRBIgvw3KHEDcdI64Oo0rESgvlXYMF1G3TkOEqoLdF5xSi+7TWWA7hjAaSBAPL54vMWh/XkabYBfrhYCZK8yTQtliCwq87vjkabCLzb4SeLu7N4poWYAWPwow2XXbdwMDM4XAJf8PSFPnXOdhlylBijN/8w7DXDyXexzFA6k+zouGWmY1sHIToPKullRTKihsfN1bXDf3V43WEn9dgujvSfMuWogQ5wPwf+roQCPan4w5x6y6No+N7QpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fqv9B4/qYt9ftsmCLi1SEDyfj0arZQP6CX2ytCd69zo=;
 b=aCf9ZQizWEXPmi47FpbSR0qvdToLGZOlmOwes2a0b/Q7wzExkjF3+9A7AllS2TUFXsKNcVp/croT1kBIqDtT6BZ3u4uKUgOcNcKbGoUOOyuSlvzqQ4LkNGOJqQnsFaLHICcVUAyUK1WvS6AxsvO+obHa8Dsj5oKzz/nHfeu9q4m/Sx4RUzpzC2g9e2aAR/F8sqi0xdOrTWS+aCMFgmdoM6fm5ipx5LrGUJWYkB8JfdEFMXFRotaEBPDXgS5GEV8w0VeydH6jHPi+PespNDU9aE3FCDVHxTa6wL57tF745sjRsgVlE3sG7mN0pEIFqdLqpWd6iwJ2hUr8lz8uHotpvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fqv9B4/qYt9ftsmCLi1SEDyfj0arZQP6CX2ytCd69zo=;
 b=EXWDehPWWjp2lQtf1EJuim7t476wHN4CuY5Sof7p6GGLw2Ijg2UqmBK7AJh0Vwox85lJysRxYrUeSfpHlkKbSRGvmZhGQAToDR+kv/GbgiYhUBoFDNeduh/fr6iaRhxIZRDaUUVkHDN02lZS1QC6t2/M1Uh1r2WBbNKVrdz1ge1u11YwdDkjKFXwtGlNUmODl3GbUA4lP3QsYdlrqTexQVvvZQQ+b8HqTqv7V+CmNszdZ5bIHPiPudL6bX1a7b+PltvZoHCRjuMCftZQ9Hv/8dBa75bJHHWw68WtIs+rclQnEvEzhPPBX/ekjp4+B4i5waeg1VDJHZGo1glriP4Qjg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AS4PR04MB9550.eurprd04.prod.outlook.com (2603:10a6:20b:4f9::17)
 by DU4PR04MB10361.eurprd04.prod.outlook.com (2603:10a6:10:55d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Mon, 16 Dec
 2024 07:58:38 +0000
Received: from AS4PR04MB9550.eurprd04.prod.outlook.com
 ([fe80::e28d:10f8:289:baf7]) by AS4PR04MB9550.eurprd04.prod.outlook.com
 ([fe80::e28d:10f8:289:baf7%6]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 07:58:38 +0000
From: Larisa Grigore <larisa.grigore@oss.nxp.com>
To: Frank.Li@nxp.com
Cc: dmaengine@vger.kernel.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	s32@nxp.com,
	Christophe Lizzi <clizzi@redhat.com>,
	Alberto Ruiz <aruizrui@redhat.com>,
	Enric Balletbo <eballetb@redhat.com>,
	Larisa Grigore <larisa.grigore@oss.nxp.com>
Subject: [PATCH 7/8] dmaengine: fsl-edma: wait until no hardware request is in progress
Date: Mon, 16 Dec 2024 09:58:17 +0200
Message-ID: <20241216075819.2066772-8-larisa.grigore@oss.nxp.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241216075819.2066772-1-larisa.grigore@oss.nxp.com>
References: <20241216075819.2066772-1-larisa.grigore@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR04CA0082.eurprd04.prod.outlook.com
 (2603:10a6:208:be::23) To AS4PR04MB9550.eurprd04.prod.outlook.com
 (2603:10a6:20b:4f9::17)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9550:EE_|DU4PR04MB10361:EE_
X-MS-Office365-Filtering-Correlation-Id: 51a1f368-0467-4380-9fb0-08dd1da772b7
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y0F1QjVKMXhOSll3eEo1SGlKZk40UkdSQjBWMVcrSUhXSUQ3MlR5ZmpIOGlP?=
 =?utf-8?B?V0FtdEhiaHNDVEdDR1N4K25ORy95QUdGRENHMGt5OElWWmNpT2FVSjF2WElM?=
 =?utf-8?B?S0s2Mm9wUi91dTdQOHVua2dFdXNSZExwRXBUeUVxajJxdzZjZmVxNzBlVmdK?=
 =?utf-8?B?YUV3WHFLSWx4ZjY2SXM1ck9zcTFVcyszVXRXVkgwQkxTNGpaOW52RUhwa3Y5?=
 =?utf-8?B?ckthMExBTVVMeDhSa25hZHdUdmU3VjBtc21aOGo0bVNMWGUzeW1HL1ZUa1Nw?=
 =?utf-8?B?MHVJMjBERDBMLzI2RVBrL1gvUDlzazlIL0s0ZllWMHZ4Qm5zMmRjc1V1SHhU?=
 =?utf-8?B?QVlnMXQxMjRadmVCSU1uV2FuaGhnWThnU1lzSnNIRXl2S25PcmgzQnQ4bjhD?=
 =?utf-8?B?UWRkY0ppR0tTaVF6ZzEvWDRlMkl6V0UxZ0lTTWFCS0d2QWdEZlNsYm5GYUFI?=
 =?utf-8?B?bkVKaUoyZVRXYVVKdDROV3lZcnZpYjBuR0d5ZThhNXVDUGx6cC9LY2VkZnU3?=
 =?utf-8?B?Ykdia1FWdHlFNTZoQmJXWVFlNFRhYTM1emEzV3ZTcGRIbjFOaDVheXZqOEdv?=
 =?utf-8?B?V29HWlI1aFhOUmpEMTR3MzFPMHQxQUk0ZktrOVQ1ditvcWlIL2ovazY5RUtG?=
 =?utf-8?B?Z2htVWl2ZC84R3U4UVN1YmxIaGtIUVVOZDJvTEhGZGsvaUcxMFNLbkpiNFV5?=
 =?utf-8?B?c1VrQWZVcEdDZkd4ZnBMRGhEOUhTK0YraE9KU0dtRFBvSEk5bmM0WlFGaElQ?=
 =?utf-8?B?c3BkRVRjYjdkWlQ4b0dSMm5LeW40V0hUOWtzMlc2WlV0bjd0YnFkQTZBTWZB?=
 =?utf-8?B?VFp3ZmhNUjFtSEd5dGhMV1VTajBTVnYvWVlrYkJNNUFtTE9Ka001Y1p1Szl6?=
 =?utf-8?B?YjNGUjJYVHhVbEgrMkUxOXZOL29FVE1Ya2JqOVBtRlVObjJKNnBpS0g2d1JE?=
 =?utf-8?B?OUxMVU1zb0UxMmllM2lwRDBISEh4UmVOMm5RSTZ4dEE3MkROdXBHeVp4MUV6?=
 =?utf-8?B?eEVCUE1HaS9xdlk1UEFoMWErV0g4M1FSOE80N1pKWGd0WE9QQk5hbUJiUElH?=
 =?utf-8?B?RGQxcHNoOEZWbjVSS1dnY3J6c3NGZmlMWHA5aHVUUXlORmc2bU1HOUd3engy?=
 =?utf-8?B?NlFoK1paM1VxTXRjS1pFM21ycDRIYklpSjJmdXlzbXVrdGRZWm8rdVlkeU84?=
 =?utf-8?B?bS9OcUtCdDM2U0hSMjg3RUJ5RDFxVm5wanZ6L2sxTW9obWcyWHE1dlJobmRS?=
 =?utf-8?B?eW1QeU1kbmhvYjJVUHBiMW05YnpQY1BiTjVUWHhwQlovRHJ4bGtlQk4zaTlx?=
 =?utf-8?B?VXhTVG11b3d5eDBnZ1FDdEk4VHlvNXFsclFsWlk1NGpWVTVFb1NUM0RjVUR4?=
 =?utf-8?B?Vmk4OXB0MDU0d0xJcDlFaGp4ZlI3dTFYbkVOM3ZaYlBkeDZ2Z0hrSlR0NWd2?=
 =?utf-8?B?cTMyQmRSL25BUVdXSGcxZjB6aG5hblQ5bFJ4U2pBUlozanJaaVhsWlBuUCtF?=
 =?utf-8?B?UjRMRi95T2t3d2tLQ3VRcmVjd3FTbkdoeHk5MFl3Y3FLTGFYZGpGT1hHQTlP?=
 =?utf-8?B?RG9YMWErd1RmejVFVEI5RjNEWXcwTEt2RUlQVldrRVFwTU45dGgyMTlCUnFs?=
 =?utf-8?B?S0thdk1Ca0N2eUx2ZEVMUDlrZUFVdzZJTkpPSnRkUGdtRGVkNlJDMVRDVjdU?=
 =?utf-8?B?NkwzQ3NZNmQ1Y3dadnBMNXYwZGRScWJMRVlRWFRlYUhsejZyamcwamRHdzRW?=
 =?utf-8?B?ZmVEN1U3NUhRcVpONVJWYTZSQVBSZSt1RjA1ME9xakFlV0xrV292cFN1MVZC?=
 =?utf-8?B?bG9KTmVDWWRjaFU0NnpDNG5wTjM0b3NTUTlNL1pRViszVGJyWnRaWURzVTFG?=
 =?utf-8?Q?payVKml44VY8v?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9550.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UG5VbnVHVWNQd2hrbmhwT0ZWaDNRMFExS3Bta2dtdjNGeUc4bW5XTGp6NVh1?=
 =?utf-8?B?WTZnNTBtVUZVZEhZS0NjUVJzV3phS0RTS25WdGdKMEg2aXVkaXJGZjBlY2d0?=
 =?utf-8?B?bG5pM2VFUFNUUXg5OFhwZ0F4Z1hBNklkKzYzNGJuWVdCcHVMekFVQmtpRWdV?=
 =?utf-8?B?UXBtMlowSUhzVDhUUWoyUy9semJsaTJHamtteiswNU1KOGk3dFFkZkxIS3JU?=
 =?utf-8?B?K3c0QWFpQW9ic1h1VTNnc3BmMEpqRFR4SytrVEgwKzRDN2dxdlZ1OHlDQmp3?=
 =?utf-8?B?SjZhK2FnbEk3TEFobzA3aGJjQUVyLzFEeksyTCtUL0tWTWYxTDI0bDFMMnZj?=
 =?utf-8?B?UFZESlcvancrNUw0UWF5TFI1WkwyaTk4U0tQVEE5TXhlTmRYQUtWbDBYNExW?=
 =?utf-8?B?UHdlNkZWaFNBY0lhL2M3MWUrdXRFZHpEenZUbXhBYm4zWmpPOS9hMkFSaHo3?=
 =?utf-8?B?bG93QnZWejNXWXllaFRGZjVoTERsM20rOGJZcm5pT29xWTQ3YkFyMENaeGpp?=
 =?utf-8?B?WE1icnpodzhueUZULzBIeDRiTmpNN2NpS0ZFOEorZDFtWmZyUDVSVkVSd3Jo?=
 =?utf-8?B?c0ZuWlA3YjZqaGVnQmlWNXdWQjZDN3ZQMjdHTUFYc2s2OS9EVzQ5L2owMlNN?=
 =?utf-8?B?SXlwMlptLzNoS2lxS21tNVNPQVcxVy9BV1hNZ0UzdnVEdUhJQnZTclZlMHR6?=
 =?utf-8?B?czdSNGFyUG9wZFEwSlhiVnh3d2h1OERmb0J0d3A5VGdKQ1IvbmVhV3RBTGNo?=
 =?utf-8?B?ZEdyN3pWRXNOcDFxNlgrRTFPcmp0VVVTeTIvbDRKTWVLdUNXVnEzL3o1QlN6?=
 =?utf-8?B?UGZWenpXRWRNeUE3WTdLTFE0eWRJVmEzdlJYZjEzdEZlTlN1S3RYN3lYbldq?=
 =?utf-8?B?RkUyU29RNXZCb3cwSWxkRFRLNU1mL3JwK1M1Z0xBcHJOMVZDa1lSS1UrWGYz?=
 =?utf-8?B?RG9SeXZFWDh0alhpZTdWZm5JZE5vK0VTZXJQVENWeFJnTnY3TDZtU2tMK3dC?=
 =?utf-8?B?d3d5UVkrelV5VFlnT0RuaUlsdCtkVnF6V1JrU2h0U1R6SEk3TSt2V1VJZE41?=
 =?utf-8?B?b0MzWXV5MEptdFM3Q1ZIMmNDTWk2d0tLSHhBTlVDcDloRFAya21PTTN2aTBh?=
 =?utf-8?B?S09uYWwxcWhtb005dmcxeGNya0xxY0tXbXFaQ2ZtNklBclQzazRHQTVkYzJU?=
 =?utf-8?B?WFVuQVRndTI3bXdOTzZPMnNWSU5QalBkUDBZTEwxN2NIRDV0Unk1SFpGUzUz?=
 =?utf-8?B?Z2tQT2xWODdZa1M2ZE1JWXBZVnZoVGxFZ1JYYjRCUnB3WXdWVlRlK2UrVzVI?=
 =?utf-8?B?UVV5ZXljU2xEWjdXNDd1eHNGUDFSZWwvNXZncDFGVU9vbXlFdFVTYVJsbC9P?=
 =?utf-8?B?UzA3S21BOW9IR0RnWmZoc1NJdEpZMWV0RStOcW5Vd3BYYTdveGFYajVxMTFr?=
 =?utf-8?B?cmRXU05ZTC9tdDBIWE1HR2t1VDk3eUNUc3AyODlSN2VmeXlXN05manhudGhB?=
 =?utf-8?B?dFk3dVFnTkI1YjdKZUNVaFZ0VUs2TmIzaUhOSGtqME4xSFI0b2c4M2F0Qloz?=
 =?utf-8?B?eUlNN21IOXBZc2hKcld3b3h3N0c2MUd1WTF4dWxJME9NcXNkVmdZTHU2Tzh1?=
 =?utf-8?B?dlpSZHgxdG5vWGJoWDAweDNXME54NFlRYTFkaDlGQkp1ck9XS3dmcC93V0FC?=
 =?utf-8?B?blB1Y2ltWkJyS2RQRUVWU1NLR3kwNW91UkRDbzQ0ZUJTblZNbGh4VXpLVmhr?=
 =?utf-8?B?anQzQ1NJZjJtTWFDdy9Fb3JUQkdua0ZUOVJmbU5JV2RTMHA4N0Y0TEhZa200?=
 =?utf-8?B?L1BlQVJtREV2OFRuVU9DMzF4SFV1cmo0d3FSZzlXUU5XUU51T2xTYnhKbnNx?=
 =?utf-8?B?T3J0SWFPVmQ4aDdMa1pNQVdsR2pwdU96bWoyVUVFSVE1Zm9CUGVEU2VscUFF?=
 =?utf-8?B?NktnR1llelNQdmQrQTJ2SmdRVjRuUUdpUFhJZEszYyt4a0RTM3h4RDNZTjBZ?=
 =?utf-8?B?bEVPSjVYa0ZqUm0xSHZGKzRBYTlOOUJzVWIrdWNvVUJyVE5Kd0ljcnVlUFhR?=
 =?utf-8?B?MU5PMlgwSU13azFSbkNEd3hkbWM1RjRydlZrWjdzampoSXBid0RrYW5IeHU4?=
 =?utf-8?Q?BgDbDyfg6U/ZKWXqqXjJSMAa3?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51a1f368-0467-4380-9fb0-08dd1da772b7
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9550.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 07:58:37.9616
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hd7RBuzizHfo41xop17O4lIaAsl0MgEGeQP5rvCDzH+2ge79xoV8AjPdJeRJHOh0fhP/m68ZO6cKzvOrXviERA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10361

Wait DMA hardware complete cleanup work by checking HRS bit before
disabling the channel to make sure trail data is already written to
memory.

Fixes: 72f5801a4e2b7 ("dmaengine: fsl-edma: integrate v3 support")
Signed-off-by: Larisa Grigore <larisa.grigore@oss.nxp.com>
---
 drivers/dma/fsl-edma-common.c | 9 +++++++++
 drivers/dma/fsl-edma-common.h | 4 ++++
 2 files changed, 13 insertions(+)

diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
index 62d51b269e54..d364514f21be 100644
--- a/drivers/dma/fsl-edma-common.c
+++ b/drivers/dma/fsl-edma-common.c
@@ -9,6 +9,7 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/dma-mapping.h>
+#include <linux/iopoll.h>
 #include <linux/pm_runtime.h>
 #include <linux/pm_domain.h>
 
@@ -127,11 +128,19 @@ static void fsl_edma_enable_request(struct fsl_edma_chan *fsl_chan)
 
 static void fsl_edma3_disable_request(struct fsl_edma_chan *fsl_chan)
 {
+	struct fsl_edma_engine *fsl_edma = fsl_chan->edma;
+	struct edma_regs *regs = &fsl_chan->edma->regs;
 	u32 val = edma_readl_chreg(fsl_chan, ch_csr);
+	u32 ch = fsl_chan->vchan.chan.chan_id;
 	u32 flags;
 
 	flags = fsl_edma_drvflags(fsl_chan);
 
+	/* Make sure there is no hardware request in progress. */
+	read_poll_timeout(edma_readl, val, !(val & EDMA_V3_MP_HRS_CH(ch)),
+			  EDMA_USEC_POLL, EDMA_USEC_TIMEOUT, false, fsl_edma,
+			  regs->v3.hrs);
+
 	if (flags & FSL_EDMA_DRV_HAS_CHMUX)
 		edma_writel(fsl_chan->edma, 0, fsl_chan->mux_addr);
 
diff --git a/drivers/dma/fsl-edma-common.h b/drivers/dma/fsl-edma-common.h
index 63e908fc3575..ed210bd71681 100644
--- a/drivers/dma/fsl-edma-common.h
+++ b/drivers/dma/fsl-edma-common.h
@@ -70,6 +70,10 @@
 #define EDMA_V3_CH_CSR_ACTIVE      BIT(31)
 #define EDMA_V3_CH_ES_ERR          BIT(31)
 #define EDMA_V3_MP_ES_VLD          BIT(31)
+#define EDMA_V3_MP_HRS_CH(ch)      BIT(ch)
+
+#define EDMA_USEC_POLL		10
+#define EDMA_USEC_TIMEOUT	10000
 
 enum fsl_edma_pm_state {
 	RUNNING = 0,
-- 
2.47.0


