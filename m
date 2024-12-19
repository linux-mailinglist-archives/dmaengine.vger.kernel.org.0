Return-Path: <dmaengine+bounces-4036-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7AF89F7854
	for <lists+dmaengine@lfdr.de>; Thu, 19 Dec 2024 10:23:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C72D161AE0
	for <lists+dmaengine@lfdr.de>; Thu, 19 Dec 2024 09:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B67C0224885;
	Thu, 19 Dec 2024 09:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="JazrsmA/"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2052.outbound.protection.outlook.com [40.107.22.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7350C22259B;
	Thu, 19 Dec 2024 09:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734600076; cv=fail; b=pudl/Dd6sgRMUumEDVHAAxLuVSLoUhX6zwifo+RADKneD9z8FBSPUFHaS2UAZ7ZNgN5UF3YvOcb8LqjCIRVM9pzAT7EsPTmkO4vitE1/DVTVHG0dLru1piLrwlAFzEXUKxl8aN4kKGadsp0wwrkNd7i6mc8qmdVsqLaGLr6rEYE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734600076; c=relaxed/simple;
	bh=gd955cPBU4pwf1eVp6/vmCnKqyPWYRTXzE0sft6hoVI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XTqVN/p8fzLGs8mida42uta/CpqrhdP63QWyCD+ibzjD5mwaq/SNwv0XAWHlJEROp8CXiPltYGGhJl38h3CdCTTV4BaI6Gq0bDuw6fU6GvBzq7rWDWXNeTLUMv82gLMlSj2S1Past/9RvRL234DOAkErDtY/Nzq0m6dJMARQkWs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=JazrsmA/; arc=fail smtp.client-ip=40.107.22.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QMfX9LjCg1nhcpOrapEx3Kjy7wO693wEB1GQbUWp/1T9oVuwPxTmMKOT+TNrfDM8x2aoMhBP4FiPurMrDGxPVDX4tY+VxnlGKzgdAoQ5dtKSHs7k4RHK1QdWtX8NMUXbRgPJLD5dMoW52/GlixqMaYmv2/ZmEUV4NlwdqGnlbSEP2r3MbEqWkviLphcO/VLgdT/rCMWjWRjLZSNr9tIW8eLvfCsrYnGVaVBhY5G45nmz8NUf9+CIi8ZZ3UwFOETQL0FskvsjIN6lr+FFk/hJNiUXWFNhChuui+Tw2o8JDL1gTWID8QekD16nWod/7DKaxc9hGoRF4I0kNcFi3JT5Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zo1sX2aLVpwPhp7IbqnPVJV6vECFSMO2MCqFad1pizw=;
 b=XJBRsG2NVbTTQdyVsQ3LELnK4Ykz0xhO5BmfdH0KF8GOfz8XaOaT71qAv5rhnG2gdC2sb3Fw0Bqkzsl4+EeN1BdyGL+hASIR+WpydtHUvjkkuynfkzuMbLzy3faLPNJ/vWAxCbjns3wzT9kuPR6ibtBb39m77kmP4S+xEPcp1m0lM6fYn4YRC1nxwY4ud0o9xomLbFY+r5XRkLrERdZu/GJ1QyoEqyWp2Db9IIc4aEIDsDNflKYLf6iIHQTVjqkkaaayt7D4WnuH2+SqVb3sD19UieJjTHaVuRuJKP6goH+ivkXsFhx0NN3fkqmSzrAiIutLrZ5+iQEe8zcxibJ6eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zo1sX2aLVpwPhp7IbqnPVJV6vECFSMO2MCqFad1pizw=;
 b=JazrsmA/cTk6U7t6CbBIVTu/KCnKkxnS7MEHyncdUJBt/aNMkbQvXmMIeWDSVIux7W3gFGsXapk6A8OshZDx2lpY2E+EDQWEz6/xA9YoO6fXL00XreHzqR8rl8Z+t2+hinhW/AdOnkddrWpiAbUQQ/eSFd49ZDp+7hy6qlqXwq++miYBojUAJq7cMN/IJ4KpKk6fEKG4f2HVW2pIp2DPXLP1MtCFzxf5EllYJAbootwsCN3rkfw5191/SD0UtbbyWG/NXk440RNdI5cE+4YQI4zjGHTxmLOhCXd3r8sDy+S5L3rv5hyVT1mtCkLoAIuv2ROACDMzkUN8QKItLS+q0g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AS4PR04MB9550.eurprd04.prod.outlook.com (2603:10a6:20b:4f9::17)
 by VI1PR04MB9834.eurprd04.prod.outlook.com (2603:10a6:800:1d8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.14; Thu, 19 Dec
 2024 09:21:04 +0000
Received: from AS4PR04MB9550.eurprd04.prod.outlook.com
 ([fe80::e28d:10f8:289:baf7]) by AS4PR04MB9550.eurprd04.prod.outlook.com
 ([fe80::e28d:10f8:289:baf7%6]) with mapi id 15.20.8251.015; Thu, 19 Dec 2024
 09:21:04 +0000
From: Larisa Grigore <larisa.grigore@oss.nxp.com>
To: Frank Li <Frank.Li@nxp.com>,
	Vinod Koul <vkoul@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Peng Fan <peng.fan@nxp.com>
Cc: imx@lists.linux.dev,
	dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	s32@nxp.com,
	Christophe Lizzi <clizzi@redhat.com>,
	Alberto Ruiz <aruizrui@redhat.com>,
	Enric Balletbo <eballetb@redhat.com>,
	Larisa Grigore <larisa.grigore@oss.nxp.com>
Subject: [PATCH v2 6/6] upstream: add eDMAv3 support for S32G2/S32G3 SoCs
Date: Thu, 19 Dec 2024 11:18:46 +0200
Message-ID: <20241219092045.1161182-7-larisa.grigore@oss.nxp.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241219092045.1161182-1-larisa.grigore@oss.nxp.com>
References: <20241219092045.1161182-1-larisa.grigore@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR02CA0213.eurprd02.prod.outlook.com
 (2603:10a6:20b:28f::20) To AS4PR04MB9550.eurprd04.prod.outlook.com
 (2603:10a6:20b:4f9::17)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9550:EE_|VI1PR04MB9834:EE_
X-MS-Office365-Filtering-Correlation-Id: 65c38eee-f127-428e-3a01-08dd200e75f6
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q2NDVjdoNW14d1piRjNvUmY1NnlQNHhjR3duWUFIYS9lZkZrQm1rWWl4MEx1?=
 =?utf-8?B?WjZMRThLS05ZM3VOTXYxVWdyb2FlZ1h1RHQ1cFFRVWx5U3JyMWk0NEtoaERZ?=
 =?utf-8?B?Ti94NVFnZlVBNUJ5TXVDcW1vU0xOVFJvUm96aUdXeHVEWFNicitzQ1VMVDg4?=
 =?utf-8?B?d1dDUTBsY1ZqUitXQW0ySWwvMzJ6UVcvNXNTdktJck9TREk4SUo2eCt3RGJD?=
 =?utf-8?B?TUQ5QytuTkZ2Q0xXMkJUNE13Z1o2bGhZZmNuQjJaNlhCNEswbFk4eWZJS1JQ?=
 =?utf-8?B?OHhKeSt0ZDhYY0h0bWljN0RMNXpFc2NlU3cvOHZpSng2aGNmWFlIMDRRcDQx?=
 =?utf-8?B?dU1XSEw5UXpWZ3RGZ21DYUhBWk94UHNMb2YwZ3ZtUjEveExQUE9jUENkVURu?=
 =?utf-8?B?YVVGbndSNS9HbW5Xb29hdW52UlF0L2JDdjRiczZVSmpjdzIvd0tWN2xPU1RR?=
 =?utf-8?B?cFFtTkNxSUdKRUdtdVp1TWYzYUgxajBhQUZKSGkvamdIQkFlV0RueUY5Vnhj?=
 =?utf-8?B?aFRQSXJHbEdDTUJKdXR2OVNWYnJhZVdIbEN5TEVTTmtpWUVIemhITStwY2FK?=
 =?utf-8?B?V1I4VXl3Z0t5dGNKUzlCd0RzQ0M1RncyaWFFVSt3SklXc0ljSDhOa0dBTW1Y?=
 =?utf-8?B?dDZCVVdGM2V5VW9haENOYjZZY29KSjVoUUwvdnpNT1J2ZVpMK2FWQlVMTWVx?=
 =?utf-8?B?UzZlZmdYNnB5L0h2UjY3cExGUE5kWUZpZGpXQWVJRFBheVoxenJzQ1M5YXZ0?=
 =?utf-8?B?YlRNeGVhUHlsZndLaE1XejhPb0pOUEhDTUw2WTh0VzVIN0RYM1pWVmFIbHNP?=
 =?utf-8?B?UlQ0YVhmQ1l1Q3hTSnZNNVcxRjkxWU9zeFo4T1pnc3p0UnZ4YnVZOVZOM3hp?=
 =?utf-8?B?VytRRUlvQ3ZhTEFyTGRJYkwzTVZlUXZkRGlLYlkzbS9LN3c5RW5xaFpnZDV5?=
 =?utf-8?B?Q0VZVXRURG5IRFFtamlDQk5jb2pRaTlMTHBnQVZRSVdYTXdydWtHZWJ0N0tt?=
 =?utf-8?B?V0ZZZ2dkTlJPQ00wMnpjV0tqMmIxdE9oUTEzZThyWHRhL1JsLy8waGJIeG0v?=
 =?utf-8?B?eVRsdmhvR1gvdEtHeEdsL3h4cGVMclB5cEF1MUh5Ullqa3dvNHVDZ01tUWRN?=
 =?utf-8?B?ajZGQVVhakJlUEtmbitxcWZ6bDhFYnVTNFQ4UkxiMmJ6WUFsN1RGaWkwQnJX?=
 =?utf-8?B?dWVWYUt2d3loV2EyMXFHd0RsbUYyMStwdXg5aWMvWWJadkFDSmZhY0VielhF?=
 =?utf-8?B?S1pBYWdRb2RORXpva0FsWFp5cy9Hd21kU2ZXNlFVbFhGYk41OVZXNjZESmxj?=
 =?utf-8?B?b3E0YmFaUDlMQk1vQ3VxcEc5UUl3eHJsemNob0ZBY3oyaTZiQXZjUFZpRWRw?=
 =?utf-8?B?OUpMTUtNaERjZjJHNzRRQVhNSzg4S1ZkNFJiRUtqUmNGbWVXWkdZaXZnd3pa?=
 =?utf-8?B?UGtHUVZtVGFMUUJSTEVPcmM3bERJQW5lWnFoWVQydkJ2aTdRNWFiRkEreDBu?=
 =?utf-8?B?a3IzN1g5VGRsZGxXaTRXMmVPcWUxSG5vSlU2UDV4RXczaVhEQWU2NzRWdGw3?=
 =?utf-8?B?OTNUalZRMXk2R0tEdG04Z1ZLTFRzRFNmWjYxVi9McGpTcFBCV1d6bXFEK3M2?=
 =?utf-8?B?cGFiR0w3V2xOUTZJTDRGbnFMcWI2MzdHZFRhTTE1NHNXR1BmNDNLcTh4QThV?=
 =?utf-8?B?SUczbGh4eWFIdkRadmpWVnJBS3VVYVVRMnFHeWhUWUNKSnV6VmhWai9RWm5k?=
 =?utf-8?B?d1ZKeVdCWUhtSGdJclYzWERkZkFSWVRsdldENjc0Y1VRTXNwQkhydlcrYW9r?=
 =?utf-8?B?SFFDL2JPVURuc2NFYlhJUGZNTmlaeEJoVXBRVXlBWGJZRXNpWGh6b1A1eTJr?=
 =?utf-8?Q?lSdfu4CqLU/C8?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9550.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eElRVnZTczhjOHRiNXdTRVBHc0doMTdCd1Fody9xTHJJOTI0WW5xZWlrR3Zw?=
 =?utf-8?B?S0dyZmR3U0h1ekxaWVVkTjFQTFdwK1dnNE5JUytyeFVhSFJoL2J6dmJsZ2F2?=
 =?utf-8?B?bjBxL3ovSC9ETVoxeFVWZTFmMldoUVpicmJyOU1rVHhUNEpZeUwyN2NGT1h6?=
 =?utf-8?B?cGdlZVNJQ3hjTzQ0d1dsZGFNZ29DcXNBM0grVkpWNmtWVERlUmw1eExkdGhK?=
 =?utf-8?B?SGRqZEYxakFCbVh1TGpleTNpb0IweWd4QWVsSXNXWUlqK2Uxa0o5QXQySUQy?=
 =?utf-8?B?UUk5V2p0VXlpTTRCMFJReTBFcGx6TDZNcTdVaUF2eWI0WmE1YlY5QVRSaTJu?=
 =?utf-8?B?YXhsS2V5QTlzLzZxOGlrMUFjd2FZK3hMaUwyUGhBRWpOTHpKZTZndjBTNXQv?=
 =?utf-8?B?dGsxWWZPZkhWUzZiN29Fdlo4QW9aRS9QWGt3cFVETDJWQTJ5Uys5T0dSTjBp?=
 =?utf-8?B?bU5NUjZMNlhsMExkU1pjVGFEQnk4ZDhSWkx2TWc3SnVPbnBXdkwxRjF2Sm5I?=
 =?utf-8?B?QjJCUHZmTE5RcHU0VHZscVJ5cnV1bERTbm4vY0FHYm9iTkFoam9ZbWFMNHNj?=
 =?utf-8?B?WW81RG1xSnhjNW93cStRZXZna2tTbWh2bTdtdnBLa2tCTi8wdmpNWDQvZmJr?=
 =?utf-8?B?MExob1owY1BJS3VFQm9FV3J4NERvR0lDamZ2SUhZcUpKRlVYRjVvNlRGS0JT?=
 =?utf-8?B?eldnWjdyQWtiZ0dIcXR4ZldmMUMxODE5TGgvdTcxZGh3dzBGcTdOdkJBWGY1?=
 =?utf-8?B?QVVyRUN3NGd5OXNidVMxSHBoVHovYTE5dXNUK2QyVFFuQzl5WHRGRUJXYVJ6?=
 =?utf-8?B?eG9naHNKR2xoZjFHSmsraVJZdTQyd1ovcUVsNkFOOGJ3M3hzZEQzNmthbDZt?=
 =?utf-8?B?eTU5RmF5S0hGcXdyZUtFUFNtOE1lUDI5dEFEMHY3cE1Ec3EzWm5xdU5lN0dS?=
 =?utf-8?B?OXhuVGxHS2V0MFZ2Y1E4Nm1YUTl5NlZyaWsweHNBZncxL09NUHhQcExOZjlQ?=
 =?utf-8?B?ZHcrK3QrSHZRb1d1cTJHNkV1ZlAwbjBGcmxhcGZVY2h5WkQ5d1kzNXBXeVMz?=
 =?utf-8?B?cVpLaHRlR3ExdllOMk83T3IwbjdGcUtuSmF4VVVJT2RwL2EwVGhHZmoreG01?=
 =?utf-8?B?T3JuTmppWmJxOVoxdGJyZFhFR2FPZE43Q09wdlRBZktPcFppTkpJejdiSlpa?=
 =?utf-8?B?WnlPMDJ3TVd3UFpMY0JOaFVqdzZlakJlekdIWlZ3K3RqRFdjWUdqc2pvL2Fs?=
 =?utf-8?B?VmNvNzN5WERsYWJBR1BLWjFPSFFVUC9WbzY3QlhWZnA4cC9WWWpTbG50LzBC?=
 =?utf-8?B?SFVNUS92L1NWTTRpVEJPTTdtMXZOQVd3YjRJZU40NEhnTEZBY29jRGxCM3hl?=
 =?utf-8?B?TWpJbnpFY004RlZaRld1dGdjSjFBTU5CSDQ1OWlNbSs0L0pEdEtnTW1Sd09N?=
 =?utf-8?B?bHlmMVptNTdRejFUakFVeGtucHdNenRGVmFGREUxQXBpKy83ZWFKUFZzSng1?=
 =?utf-8?B?bkthcTBBbnBBa2FYVVd6K0c5Z0o1ZHJHSzRhRThUK0dudkJ2aVVMUGFvdjBW?=
 =?utf-8?B?dzNQQnVGSjQ5UFg4SUFMazZtU1BQY21KTjNmQk9QeUoxL0NmVjA0WVNwb3NR?=
 =?utf-8?B?ZDFRdmQ3YVlkQi9QYjNNNkg5OXYwYnRIVnRQQnhMTkcydzlCaTc0ZnNOUExY?=
 =?utf-8?B?N2xzeTBVYS9iWHNUWTA5N1k0TmNKNTlVdUJ1SHpsTUlYdlNRMUkyL2YzbmJR?=
 =?utf-8?B?TWdLNm1xdEpOSXd4cXV3U0UrMkJHNVczV3h3UlVZVW1tMkJRamloZ3FlNVdL?=
 =?utf-8?B?NUtLVzdlY2k1cWFRK0hEVGNDZUlGb1ZERXlNRHJXeFhHUHRNVmZjQmh6N0VC?=
 =?utf-8?B?NnZZV0kyNXY2REZ6Q0Nra3ZCbXM0RjUzalR6NWM3SlVaLzNrTDcwTjFhK1NK?=
 =?utf-8?B?bWZ4WXFmOTlNTTFJWnFUWHpsc2JOalZ2Z2FVS1h6MFhFNWJKTkt6MnJTWGZi?=
 =?utf-8?B?c2gvZ3JwbTJLL2JNVzJTMjRCWnQrYll0aVh2WlByRXlwOHpxMFlqdDIrd2RP?=
 =?utf-8?B?OUVxSERXaTNZekV4aW9xQ1l6WnJpNEV2dTZ0aWZBQnd1SUljRzlKRmVuVVVF?=
 =?utf-8?Q?5p7pywWTIGq+G07HuxEai4T2q?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65c38eee-f127-428e-3a01-08dd200e75f6
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9550.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2024 09:21:03.9825
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oJrKxyUEX5BwPwupqDOQSYwLBXooh9SXj5sc4rmuyhUsRtl3VNzVnpSYQeZsPpJH47xIODbDM9kwGQZo/+1JmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9834

S32G2 and S32G3 SoCs share the eDMAv3 module with i.MX SoCs, with some
hardware integration particularities.

S32G2/S32G3 includes two system eDMA instances based on v3 version, each of
them integrated with 2 DMAMUX blocks.
Another particularity of these SoCs is that the interrupts are shared
between channels as follows:
- DMA Channels 0-15 share the 'tx-0-15' interrupt
- DMA Channels 16-31 share the 'tx-16-31' interrupt
- all channels share the 'err' interrupt.

The following email addresses will be used to send the patch for review:
TO: Frank Li <Frank.Li@nxp.com>,Vinod Koul <vkoul@kernel.org>,Rob
Herring <robh@kernel.org>,Krzysztof Kozlowski <krzk+dt@kernel.org>,Conor
Dooley <conor+dt@kernel.org>,Peng Fan <peng.fan@nxp.com>
CC: Peng Fan <peng.fan@nxp.com>,Vinod Koul <vkoul@kernel.org>,Frank Li <Frank.Li@nxp.com>,imx@lists.linux.dev,dmaengine@vger.kernel.org,devicetree@vger.kernel.org,linux-kernel@vger.kernel.org, s32@nxp.com, Christophe Lizzi <clizzi@redhat.com>,
Alberto Ruiz <aruizrui@redhat.com>, Enric Balletbo <eballetb@redhat.com>

Signed-off-by: Larisa Grigore <larisa.grigore@oss.nxp.com>
---
 outgoing/description                          |  12 ++
 outgoing/v2-0000-cover-letter.patch           |  42 ++++
 ...-edma-select-of_dma_xlate-based-on-t.patch |  39 ++++
 ...-edma-remove-FSL_EDMA_DRV_SPLIT_REG-.patch |  35 +++
 ...-edma-move-eDMAv2-related-registers-.patch | 199 +++++++++++++++++
 ...-edma-add-eDMAv3-registers-to-edma_r.patch | 104 +++++++++
 ...ma-fsl-edma-add-nxp-s32g2-edma-compa.patch |  83 ++++++++
 ...-edma-add-support-for-S32G-based-pla.patch | 200 ++++++++++++++++++
 ...-edma-wait-until-no-hardware-request.patch |  68 ++++++
 ...-edma-read-write-multiple-registers-.patch |  90 ++++++++
 10 files changed, 872 insertions(+)
 create mode 100644 outgoing/description
 create mode 100644 outgoing/v2-0000-cover-letter.patch
 create mode 100644 outgoing/v2-0001-dmaengine-fsl-edma-select-of_dma_xlate-based-on-t.patch
 create mode 100644 outgoing/v2-0002-dmaengine-fsl-edma-remove-FSL_EDMA_DRV_SPLIT_REG-.patch
 create mode 100644 outgoing/v2-0003-dmaengine-fsl-edma-move-eDMAv2-related-registers-.patch
 create mode 100644 outgoing/v2-0004-dmaengine-fsl-edma-add-eDMAv3-registers-to-edma_r.patch
 create mode 100644 outgoing/v2-0005-dt-bindings-dma-fsl-edma-add-nxp-s32g2-edma-compa.patch
 create mode 100644 outgoing/v2-0006-dmaengine-fsl-edma-add-support-for-S32G-based-pla.patch
 create mode 100644 outgoing/v2-0007-dmaengine-fsl-edma-wait-until-no-hardware-request.patch
 create mode 100644 outgoing/v2-0008-dmaengine-fsl-edma-read-write-multiple-registers-.patch

diff --git a/outgoing/description b/outgoing/description
new file mode 100644
index 000000000000..dcffbc0fa4f7
--- /dev/null
+++ b/outgoing/description
@@ -0,0 +1,12 @@
+Add eDMAv3 support for S32G2/S32G3 SoCs
+
+S32G2 and S32G3 SoCs share the eDMAv3 module with i.MX SoCs, with some hardware
+integration particularities.
+
+S32G2/S32G3 includes two system eDMA instances based on v3 version, each of
+them integrated with 2 DMAMUX blocks.
+Another particularity of these SoCs is that the interrupts are shared between
+channels as follows:
+- DMA Channels 0-15 share the 'tx-0-15' interrupt
+- DMA Channels 16-31 share the 'tx-16-31' interrupt
+- all channels share the 'err' interrupt
diff --git a/outgoing/v2-0000-cover-letter.patch b/outgoing/v2-0000-cover-letter.patch
new file mode 100644
index 000000000000..7450c360744c
--- /dev/null
+++ b/outgoing/v2-0000-cover-letter.patch
@@ -0,0 +1,42 @@
+From e803ee3d1d6a60006f0ebe631de9f78a246b8e42 Mon Sep 17 00:00:00 2001
+From: Larisa Grigore <larisa.grigore@oss.nxp.com>
+Date: Wed, 18 Dec 2024 16:01:08 +0200
+Subject: [PATCH v2 0/8] Add eDMAv3 support for S32G2/S32G3 SoCs
+MIME-Version: 1.0
+Content-Type: text/plain; charset=UTF-8
+Content-Transfer-Encoding: 8bit
+Content-Type: text/plain; charset=UTF-8
+
+S32G2 and S32G3 SoCs share the eDMAv3 module with i.MX SoCs, with some hardware
+integration particularities.
+
+S32G2/S32G3 includes two system eDMA instances based on v3 version, each of
+them integrated with 2 DMAMUX blocks.
+Another particularity of these SoCs is that the interrupts are shared between
+channels as follows:
+- DMA Channels 0-15 share the 'tx-0-15' interrupt
+- DMA Channels 16-31 share the 'tx-16-31' interrupt
+- all channels share the 'err' interrupt
+
+Larisa Grigore (8):
+  dmaengine: fsl-edma: select of_dma_xlate based on the dmamuxs presence
+  dmaengine: fsl-edma: remove FSL_EDMA_DRV_SPLIT_REG check when parsing
+    muxbase
+  dmaengine: fsl-edma: move eDMAv2 related registers to a new structure
+    ’edma2_regs’
+  dmaengine: fsl-edma: add eDMAv3 registers to edma_regs
+  dt-bindings: dma: fsl-edma: add nxp,s32g2-edma compatible string
+  dmaengine: fsl-edma: add support for S32G based platforms
+  dmaengine: fsl-edma: wait until no hardware request is in progress
+  dmaengine: fsl-edma: read/write multiple registers in cyclic
+    transactions
+
+ .../devicetree/bindings/dma/fsl,edma.yaml     |  34 +++++
+ drivers/dma/fsl-edma-common.c                 | 112 +++++++++-----
+ drivers/dma/fsl-edma-common.h                 |  26 +++-
+ drivers/dma/fsl-edma-main.c                   | 137 ++++++++++++++++--
+ 4 files changed, 257 insertions(+), 52 deletions(-)
+
+-- 
+2.47.0
+
diff --git a/outgoing/v2-0001-dmaengine-fsl-edma-select-of_dma_xlate-based-on-t.patch b/outgoing/v2-0001-dmaengine-fsl-edma-select-of_dma_xlate-based-on-t.patch
new file mode 100644
index 000000000000..e006cd3bdc0f
--- /dev/null
+++ b/outgoing/v2-0001-dmaengine-fsl-edma-select-of_dma_xlate-based-on-t.patch
@@ -0,0 +1,39 @@
+From f63c1efcd420fb26c4ddab005a70cac30d27af9e Mon Sep 17 00:00:00 2001
+From: Larisa Grigore <larisa.grigore@oss.nxp.com>
+Date: Thu, 24 Oct 2024 10:29:22 +0300
+Subject: [PATCH v2 1/8] dmaengine: fsl-edma: select of_dma_xlate based on the
+ dmamuxs presence
+Content-Type: text/plain; charset=UTF-8
+
+Select the of_dma_xlate function based on the dmamuxs definition rather
+than the FSL_EDMA_DRV_SPLIT_REG flag, which pertains to the eDMA3
+layout.
+
+This change is a prerequisite for the S32G platforms, which integrate both
+eDMAv3 and DMAMUX.
+
+Existing platforms with FSL_EDMA_DRV_SPLIT_REG will not be impacted, as
+they all have dmamuxs set to zero.
+
+Signed-off-by: Larisa Grigore <larisa.grigore@oss.nxp.com>
+Reviewed-by: Frank Li <Frank.Li@nxp.com>
+---
+ drivers/dma/fsl-edma-main.c | 2 +-
+ 1 file changed, 1 insertion(+), 1 deletion(-)
+
+diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
+index 60de1003193a..2a7d19f51287 100644
+--- a/drivers/dma/fsl-edma-main.c
++++ b/drivers/dma/fsl-edma-main.c
+@@ -646,7 +646,7 @@ static int fsl_edma_probe(struct platform_device *pdev)
+ 	}
+ 
+ 	ret = of_dma_controller_register(np,
+-			drvdata->flags & FSL_EDMA_DRV_SPLIT_REG ? fsl_edma3_xlate : fsl_edma_xlate,
++			drvdata->dmamuxs ? fsl_edma_xlate : fsl_edma3_xlate,
+ 			fsl_edma);
+ 	if (ret) {
+ 		dev_err(&pdev->dev,
+-- 
+2.47.0
+
diff --git a/outgoing/v2-0002-dmaengine-fsl-edma-remove-FSL_EDMA_DRV_SPLIT_REG-.patch b/outgoing/v2-0002-dmaengine-fsl-edma-remove-FSL_EDMA_DRV_SPLIT_REG-.patch
new file mode 100644
index 000000000000..4ef93ee0638e
--- /dev/null
+++ b/outgoing/v2-0002-dmaengine-fsl-edma-remove-FSL_EDMA_DRV_SPLIT_REG-.patch
@@ -0,0 +1,35 @@
+From 29cb164154fcc9e41113d14b13a26116602e00ff Mon Sep 17 00:00:00 2001
+From: Larisa Grigore <larisa.grigore@oss.nxp.com>
+Date: Mon, 25 Nov 2024 15:40:18 +0200
+Subject: [PATCH v2 2/8] dmaengine: fsl-edma: remove FSL_EDMA_DRV_SPLIT_REG
+ check when parsing muxbase
+Content-Type: text/plain; charset=UTF-8
+
+Clean up dead code. dmamuxs is always 0 when FSL_EDMA_DRV_SPLIT_REG set. So
+it is redundant to check FSL_EDMA_DRV_SPLIT_REG again in the for loop
+because it will never enter for loop.
+
+Signed-off-by: Larisa Grigore <larisa.grigore@oss.nxp.com>
+Reviewed-by: Frank Li <Frank.Li@nxp.com>
+---
+ drivers/dma/fsl-edma-main.c | 4 ----
+ 1 file changed, 4 deletions(-)
+
+diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
+index 2a7d19f51287..9873cce00c68 100644
+--- a/drivers/dma/fsl-edma-main.c
++++ b/drivers/dma/fsl-edma-main.c
+@@ -517,10 +517,6 @@ static int fsl_edma_probe(struct platform_device *pdev)
+ 	for (i = 0; i < fsl_edma->drvdata->dmamuxs; i++) {
+ 		char clkname[32];
+ 
+-		/* eDMAv3 mux register move to TCD area if ch_mux exist */
+-		if (drvdata->flags & FSL_EDMA_DRV_SPLIT_REG)
+-			break;
+-
+ 		fsl_edma->muxbase[i] = devm_platform_ioremap_resource(pdev,
+ 								      1 + i);
+ 		if (IS_ERR(fsl_edma->muxbase[i])) {
+-- 
+2.47.0
+
diff --git a/outgoing/v2-0003-dmaengine-fsl-edma-move-eDMAv2-related-registers-.patch b/outgoing/v2-0003-dmaengine-fsl-edma-move-eDMAv2-related-registers-.patch
new file mode 100644
index 000000000000..b76948bbbfb9
--- /dev/null
+++ b/outgoing/v2-0003-dmaengine-fsl-edma-move-eDMAv2-related-registers-.patch
@@ -0,0 +1,199 @@
+From 1f42c35231b1592ffe1843e5c8dd727be0735db5 Mon Sep 17 00:00:00 2001
+From: Larisa Grigore <larisa.grigore@oss.nxp.com>
+Date: Tue, 19 Nov 2024 16:25:49 +0200
+Subject: [PATCH v2 3/8] =?UTF-8?q?dmaengine:=20fsl-edma:=20move=20eDMAv2?=
+ =?UTF-8?q?=20related=20registers=20to=20a=20new=20structure=20=E2=80=99ed?=
+ =?UTF-8?q?ma2=5Fregs=E2=80=99?=
+MIME-Version: 1.0
+Content-Type: text/plain; charset=UTF-8
+Content-Transfer-Encoding: 8bit
+Content-Type: text/plain; charset=UTF-8
+
+Move eDMAv2 related registers to a new structure ’edma2_regs’ to better
+support eDMAv3.
+
+eDMAv3 registers will be added in the next commit.
+
+Signed-off-by: Larisa Grigore <larisa.grigore@oss.nxp.com>
+Reviewed-by: Frank Li <Frank.Li@nxp.com>
+---
+ drivers/dma/fsl-edma-common.c | 52 ++++++++++++++++++-----------------
+ drivers/dma/fsl-edma-common.h | 10 +++++--
+ drivers/dma/fsl-edma-main.c   | 14 ++++++----
+ 3 files changed, 42 insertions(+), 34 deletions(-)
+
+diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
+index b7f15ab96855..b132a88dfdec 100644
+--- a/drivers/dma/fsl-edma-common.c
++++ b/drivers/dma/fsl-edma-common.c
+@@ -108,14 +108,15 @@ static void fsl_edma_enable_request(struct fsl_edma_chan *fsl_chan)
+ 		return fsl_edma3_enable_request(fsl_chan);
+ 
+ 	if (fsl_chan->edma->drvdata->flags & FSL_EDMA_DRV_WRAP_IO) {
+-		edma_writeb(fsl_chan->edma, EDMA_SEEI_SEEI(ch), regs->seei);
+-		edma_writeb(fsl_chan->edma, ch, regs->serq);
++		edma_writeb(fsl_chan->edma, EDMA_SEEI_SEEI(ch),
++			    regs->v2.seei);
++		edma_writeb(fsl_chan->edma, ch, regs->v2.serq);
+ 	} else {
+ 		/* ColdFire is big endian, and accesses natively
+ 		 * big endian I/O peripherals
+ 		 */
+-		iowrite8(EDMA_SEEI_SEEI(ch), regs->seei);
+-		iowrite8(ch, regs->serq);
++		iowrite8(EDMA_SEEI_SEEI(ch), regs->v2.seei);
++		iowrite8(ch, regs->v2.serq);
+ 	}
+ }
+ 
+@@ -142,14 +143,15 @@ void fsl_edma_disable_request(struct fsl_edma_chan *fsl_chan)
+ 		return fsl_edma3_disable_request(fsl_chan);
+ 
+ 	if (fsl_chan->edma->drvdata->flags & FSL_EDMA_DRV_WRAP_IO) {
+-		edma_writeb(fsl_chan->edma, ch, regs->cerq);
+-		edma_writeb(fsl_chan->edma, EDMA_CEEI_CEEI(ch), regs->ceei);
++		edma_writeb(fsl_chan->edma, ch, regs->v2.cerq);
++		edma_writeb(fsl_chan->edma, EDMA_CEEI_CEEI(ch),
++			    regs->v2.ceei);
+ 	} else {
+ 		/* ColdFire is big endian, and accesses natively
+ 		 * big endian I/O peripherals
+ 		 */
+-		iowrite8(ch, regs->cerq);
+-		iowrite8(EDMA_CEEI_CEEI(ch), regs->ceei);
++		iowrite8(ch, regs->v2.cerq);
++		iowrite8(EDMA_CEEI_CEEI(ch), regs->v2.ceei);
+ 	}
+ }
+ 
+@@ -880,25 +882,25 @@ void fsl_edma_setup_regs(struct fsl_edma_engine *edma)
+ 
+ 	edma->regs.cr = edma->membase + EDMA_CR;
+ 	edma->regs.es = edma->membase + EDMA_ES;
+-	edma->regs.erql = edma->membase + EDMA_ERQ;
+-	edma->regs.eeil = edma->membase + EDMA_EEI;
+-
+-	edma->regs.serq = edma->membase + (is64 ? EDMA64_SERQ : EDMA_SERQ);
+-	edma->regs.cerq = edma->membase + (is64 ? EDMA64_CERQ : EDMA_CERQ);
+-	edma->regs.seei = edma->membase + (is64 ? EDMA64_SEEI : EDMA_SEEI);
+-	edma->regs.ceei = edma->membase + (is64 ? EDMA64_CEEI : EDMA_CEEI);
+-	edma->regs.cint = edma->membase + (is64 ? EDMA64_CINT : EDMA_CINT);
+-	edma->regs.cerr = edma->membase + (is64 ? EDMA64_CERR : EDMA_CERR);
+-	edma->regs.ssrt = edma->membase + (is64 ? EDMA64_SSRT : EDMA_SSRT);
+-	edma->regs.cdne = edma->membase + (is64 ? EDMA64_CDNE : EDMA_CDNE);
+-	edma->regs.intl = edma->membase + (is64 ? EDMA64_INTL : EDMA_INTR);
+-	edma->regs.errl = edma->membase + (is64 ? EDMA64_ERRL : EDMA_ERR);
++	edma->regs.v2.erql = edma->membase + EDMA_ERQ;
++	edma->regs.v2.eeil = edma->membase + EDMA_EEI;
++
++	edma->regs.v2.serq = edma->membase + (is64 ? EDMA64_SERQ : EDMA_SERQ);
++	edma->regs.v2.cerq = edma->membase + (is64 ? EDMA64_CERQ : EDMA_CERQ);
++	edma->regs.v2.seei = edma->membase + (is64 ? EDMA64_SEEI : EDMA_SEEI);
++	edma->regs.v2.ceei = edma->membase + (is64 ? EDMA64_CEEI : EDMA_CEEI);
++	edma->regs.v2.cint = edma->membase + (is64 ? EDMA64_CINT : EDMA_CINT);
++	edma->regs.v2.cerr = edma->membase + (is64 ? EDMA64_CERR : EDMA_CERR);
++	edma->regs.v2.ssrt = edma->membase + (is64 ? EDMA64_SSRT : EDMA_SSRT);
++	edma->regs.v2.cdne = edma->membase + (is64 ? EDMA64_CDNE : EDMA_CDNE);
++	edma->regs.v2.intl = edma->membase + (is64 ? EDMA64_INTL : EDMA_INTR);
++	edma->regs.v2.errl = edma->membase + (is64 ? EDMA64_ERRL : EDMA_ERR);
+ 
+ 	if (is64) {
+-		edma->regs.erqh = edma->membase + EDMA64_ERQH;
+-		edma->regs.eeih = edma->membase + EDMA64_EEIH;
+-		edma->regs.errh = edma->membase + EDMA64_ERRH;
+-		edma->regs.inth = edma->membase + EDMA64_INTH;
++		edma->regs.v2.erqh = edma->membase + EDMA64_ERQH;
++		edma->regs.v2.eeih = edma->membase + EDMA64_EEIH;
++		edma->regs.v2.errh = edma->membase + EDMA64_ERRH;
++		edma->regs.v2.inth = edma->membase + EDMA64_INTH;
+ 	}
+ }
+ 
+diff --git a/drivers/dma/fsl-edma-common.h b/drivers/dma/fsl-edma-common.h
+index ce37e1ee9c46..f1362daaa347 100644
+--- a/drivers/dma/fsl-edma-common.h
++++ b/drivers/dma/fsl-edma-common.h
+@@ -120,9 +120,7 @@ struct fsl_edma3_ch_reg {
+ /*
+  * These are iomem pointers, for both v32 and v64.
+  */
+-struct edma_regs {
+-	void __iomem *cr;
+-	void __iomem *es;
++struct edma2_regs {
+ 	void __iomem *erqh;
+ 	void __iomem *erql;	/* aka erq on v32 */
+ 	void __iomem *eeih;
+@@ -141,6 +139,12 @@ struct edma_regs {
+ 	void __iomem *errl;
+ };
+ 
++struct edma_regs {
++	void __iomem *cr;
++	void __iomem *es;
++	struct edma2_regs v2;
++};
++
+ struct fsl_edma_sw_tcd {
+ 	dma_addr_t			ptcd;
+ 	void				*vtcd;
+diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
+index 9873cce00c68..0b89c31bf38c 100644
+--- a/drivers/dma/fsl-edma-main.c
++++ b/drivers/dma/fsl-edma-main.c
+@@ -36,13 +36,14 @@ static irqreturn_t fsl_edma_tx_handler(int irq, void *dev_id)
+ 	unsigned int intr, ch;
+ 	struct edma_regs *regs = &fsl_edma->regs;
+ 
+-	intr = edma_readl(fsl_edma, regs->intl);
++	intr = edma_readl(fsl_edma, regs->v2.intl);
+ 	if (!intr)
+ 		return IRQ_NONE;
+ 
+ 	for (ch = 0; ch < fsl_edma->n_chans; ch++) {
+ 		if (intr & (0x1 << ch)) {
+-			edma_writeb(fsl_edma, EDMA_CINT_CINT(ch), regs->cint);
++			edma_writeb(fsl_edma, EDMA_CINT_CINT(ch),
++				    regs->v2.cint);
+ 			fsl_edma_tx_chan_handler(&fsl_edma->chans[ch]);
+ 		}
+ 	}
+@@ -78,14 +79,15 @@ static irqreturn_t fsl_edma_err_handler(int irq, void *dev_id)
+ 	unsigned int err, ch;
+ 	struct edma_regs *regs = &fsl_edma->regs;
+ 
+-	err = edma_readl(fsl_edma, regs->errl);
++	err = edma_readl(fsl_edma, regs->v2.errl);
+ 	if (!err)
+ 		return IRQ_NONE;
+ 
+ 	for (ch = 0; ch < fsl_edma->n_chans; ch++) {
+ 		if (err & (0x1 << ch)) {
+ 			fsl_edma_disable_request(&fsl_edma->chans[ch]);
+-			edma_writeb(fsl_edma, EDMA_CERR_CERR(ch), regs->cerr);
++			edma_writeb(fsl_edma, EDMA_CERR_CERR(ch),
++				    regs->v2.cerr);
+ 			fsl_edma_err_chan_handler(&fsl_edma->chans[ch]);
+ 		}
+ 	}
+@@ -216,7 +218,7 @@ fsl_edma_irq_init(struct platform_device *pdev, struct fsl_edma_engine *fsl_edma
+ {
+ 	int ret;
+ 
+-	edma_writel(fsl_edma, ~0, fsl_edma->regs.intl);
++	edma_writel(fsl_edma, ~0, fsl_edma->regs.v2.intl);
+ 
+ 	fsl_edma->txirq = platform_get_irq_byname(pdev, "edma-tx");
+ 	if (fsl_edma->txirq < 0)
+@@ -281,7 +283,7 @@ fsl_edma2_irq_init(struct platform_device *pdev,
+ 	int i, ret, irq;
+ 	int count;
+ 
+-	edma_writel(fsl_edma, ~0, fsl_edma->regs.intl);
++	edma_writel(fsl_edma, ~0, fsl_edma->regs.v2.intl);
+ 
+ 	count = platform_irq_count(pdev);
+ 	dev_dbg(&pdev->dev, "%s Found %d interrupts\r\n", __func__, count);
+-- 
+2.47.0
+
diff --git a/outgoing/v2-0004-dmaengine-fsl-edma-add-eDMAv3-registers-to-edma_r.patch b/outgoing/v2-0004-dmaengine-fsl-edma-add-eDMAv3-registers-to-edma_r.patch
new file mode 100644
index 000000000000..bb143c138958
--- /dev/null
+++ b/outgoing/v2-0004-dmaengine-fsl-edma-add-eDMAv3-registers-to-edma_r.patch
@@ -0,0 +1,104 @@
+From a2358ec157b67a5333eeaa4139a35f7b7f255362 Mon Sep 17 00:00:00 2001
+From: Larisa Grigore <larisa.grigore@oss.nxp.com>
+Date: Tue, 19 Nov 2024 16:26:07 +0200
+Subject: [PATCH v2 4/8] dmaengine: fsl-edma: add eDMAv3 registers to edma_regs
+Content-Type: text/plain; charset=UTF-8
+
+Add edma3_regs to match eDMAv3 new register layout for manage page (MP).
+
+Introduce helper function fsl_edma3_setup_regs() to initialize the
+edma_regs for eDMAv3, which pave the road to support S32 chips.
+
+Signed-off-by: Larisa Grigore <larisa.grigore@oss.nxp.com>
+Reviewed-by: Frank Li <Frank.Li@nxp.com>
+---
+ drivers/dma/fsl-edma-common.c | 15 +++++++++++++++
+ drivers/dma/fsl-edma-common.h | 11 ++++++++++-
+ drivers/dma/fsl-edma-main.c   |  8 +++++---
+ 3 files changed, 30 insertions(+), 4 deletions(-)
+
+diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
+index b132a88dfdec..62d51b269e54 100644
+--- a/drivers/dma/fsl-edma-common.c
++++ b/drivers/dma/fsl-edma-common.c
+@@ -44,6 +44,11 @@
+ #define EDMA64_ERRH		0x28
+ #define EDMA64_ERRL		0x2c
+ 
++#define EDMA_V3_MP_CSR		0x00
++#define EDMA_V3_MP_ES		0x04
++#define EDMA_V3_MP_INT		0x08
++#define EDMA_V3_MP_HRS		0x0C
++
+ void fsl_edma_tx_chan_handler(struct fsl_edma_chan *fsl_chan)
+ {
+ 	spin_lock(&fsl_chan->vchan.lock);
+@@ -904,4 +909,14 @@ void fsl_edma_setup_regs(struct fsl_edma_engine *edma)
+ 	}
+ }
+ 
++void fsl_edma3_setup_regs(struct fsl_edma_engine *edma)
++{
++	struct edma_regs *regs = &edma->regs;
++
++	regs->cr = edma->membase + EDMA_V3_MP_CSR;
++	regs->es = edma->membase + EDMA_V3_MP_ES;
++	regs->v3.is = edma->membase + EDMA_V3_MP_INT;
++	regs->v3.hrs = edma->membase + EDMA_V3_MP_HRS;
++}
++
+ MODULE_LICENSE("GPL v2");
+diff --git a/drivers/dma/fsl-edma-common.h b/drivers/dma/fsl-edma-common.h
+index f1362daaa347..52901623d6fc 100644
+--- a/drivers/dma/fsl-edma-common.h
++++ b/drivers/dma/fsl-edma-common.h
+@@ -139,10 +139,18 @@ struct edma2_regs {
+ 	void __iomem *errl;
+ };
+ 
++struct edma3_regs {
++	void __iomem *is;
++	void __iomem *hrs;
++};
++
+ struct edma_regs {
+ 	void __iomem *cr;
+ 	void __iomem *es;
+-	struct edma2_regs v2;
++	union {
++		struct edma2_regs v2;
++		struct edma3_regs v3;
++	};
+ };
+ 
+ struct fsl_edma_sw_tcd {
+@@ -491,5 +499,6 @@ int fsl_edma_alloc_chan_resources(struct dma_chan *chan);
+ void fsl_edma_free_chan_resources(struct dma_chan *chan);
+ void fsl_edma_cleanup_vchan(struct dma_device *dmadev);
+ void fsl_edma_setup_regs(struct fsl_edma_engine *edma);
++void fsl_edma3_setup_regs(struct fsl_edma_engine *edma);
+ 
+ #endif /* _FSL_EDMA_COMMON_H_ */
+diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
+index 0b89c31bf38c..cc1787698b56 100644
+--- a/drivers/dma/fsl-edma-main.c
++++ b/drivers/dma/fsl-edma-main.c
+@@ -495,10 +495,12 @@ static int fsl_edma_probe(struct platform_device *pdev)
+ 	if (IS_ERR(fsl_edma->membase))
+ 		return PTR_ERR(fsl_edma->membase);
+ 
+-	if (!(drvdata->flags & FSL_EDMA_DRV_SPLIT_REG)) {
++	if (!(drvdata->flags & FSL_EDMA_DRV_SPLIT_REG))
+ 		fsl_edma_setup_regs(fsl_edma);
+-		regs = &fsl_edma->regs;
+-	}
++	else
++		fsl_edma3_setup_regs(fsl_edma);
++
++	regs = &fsl_edma->regs;
+ 
+ 	if (drvdata->flags & FSL_EDMA_DRV_HAS_DMACLK) {
+ 		fsl_edma->dmaclk = devm_clk_get_enabled(&pdev->dev, "dma");
+-- 
+2.47.0
+
diff --git a/outgoing/v2-0005-dt-bindings-dma-fsl-edma-add-nxp-s32g2-edma-compa.patch b/outgoing/v2-0005-dt-bindings-dma-fsl-edma-add-nxp-s32g2-edma-compa.patch
new file mode 100644
index 000000000000..529d7c304802
--- /dev/null
+++ b/outgoing/v2-0005-dt-bindings-dma-fsl-edma-add-nxp-s32g2-edma-compa.patch
@@ -0,0 +1,83 @@
+From 8960ba80448c129ed0372778e4d35a2d0be6c455 Mon Sep 17 00:00:00 2001
+From: Larisa Grigore <larisa.grigore@oss.nxp.com>
+Date: Thu, 31 Oct 2024 16:39:17 +0200
+Subject: [PATCH v2 5/8] dt-bindings: dma: fsl-edma: add nxp,s32g2-edma
+ compatible string
+Content-Type: text/plain; charset=UTF-8
+
+Introduce the compatible strings 'nxp,s32g2-edma' and 'nxp,s32g3-edma' to
+enable the support for the eDMAv3 present on S32G2/S32G3 platforms.
+
+The S32G2/S32G3 eDMA architecture features 32 DMA channels. Each of the
+two eDMA instances is integrated with two DMAMUX blocks.
+
+Another particularity of these SoCs is that the interrupts are shared
+between channels in the following way:
+- DMA Channels 0-15 share the 'tx-0-15' interrupt
+- DMA Channels 16-31 share the 'tx-16-31' interrupt
+- all channels share the 'err' interrupt
+
+Signed-off-by: Larisa Grigore <larisa.grigore@oss.nxp.com>
+Reviewed-by: Frank Li <Frank.Li@nxp.com>
+---
+ .../devicetree/bindings/dma/fsl,edma.yaml     | 34 +++++++++++++++++++
+ 1 file changed, 34 insertions(+)
+
+diff --git a/Documentation/devicetree/bindings/dma/fsl,edma.yaml b/Documentation/devicetree/bindings/dma/fsl,edma.yaml
+index d54140f18d34..4f925469533e 100644
+--- a/Documentation/devicetree/bindings/dma/fsl,edma.yaml
++++ b/Documentation/devicetree/bindings/dma/fsl,edma.yaml
+@@ -26,9 +26,13 @@ properties:
+           - fsl,imx93-edma3
+           - fsl,imx93-edma4
+           - fsl,imx95-edma5
++          - nxp,s32g2-edma
+       - items:
+           - const: fsl,ls1028a-edma
+           - const: fsl,vf610-edma
++      - items:
++          - const: nxp,s32g3-edma
++          - const: nxp,s32g2-edma
+ 
+   reg:
+     minItems: 1
+@@ -221,6 +225,36 @@ allOf:
+       properties:
+         power-domains: false
+ 
++  - if:
++      properties:
++        compatible:
++          contains:
++            const: nxp,s32g2-edma
++    then:
++      properties:
++        clocks:
++          minItems: 2
++          maxItems: 2
++        clock-names:
++          items:
++            - const: dmamux0
++            - const: dmamux1
++        interrupts:
++          minItems: 3
++          maxItems: 3
++        interrupt-names:
++          items:
++            - const: tx-0-15
++            - const: tx-16-31
++            - const: err
++        reg:
++          minItems: 3
++          maxItems: 3
++        "#dma-cells":
++          const: 2
++        dma-channels:
++          const: 32
++
+ unevaluatedProperties: false
+ 
+ examples:
+-- 
+2.47.0
+
diff --git a/outgoing/v2-0006-dmaengine-fsl-edma-add-support-for-S32G-based-pla.patch b/outgoing/v2-0006-dmaengine-fsl-edma-add-support-for-S32G-based-pla.patch
new file mode 100644
index 000000000000..8df669589df7
--- /dev/null
+++ b/outgoing/v2-0006-dmaengine-fsl-edma-add-support-for-S32G-based-pla.patch
@@ -0,0 +1,200 @@
+From a6f83bd94f76f21d8ff662f07f4f72e79f71aebf Mon Sep 17 00:00:00 2001
+From: Larisa Grigore <larisa.grigore@oss.nxp.com>
+Date: Thu, 24 Oct 2024 14:16:37 +0300
+Subject: [PATCH v2 6/8] dmaengine: fsl-edma: add support for S32G based
+ platforms
+Content-Type: text/plain; charset=UTF-8
+
+S32G2/S32G3 includes two system eDMA instances based on v3 version, each of
+them integrated with two DMAMUX blocks.
+
+Another particularity of these SoCs is that the interrupts are shared
+between channels as follows:
+- DMA Channels 0-15 share the 'tx-0-15' interrupt
+- DMA Channels 16-31 share the 'tx-16-31' interrupt
+- all channels share the 'err' interrupt
+
+Signed-off-by: Larisa Grigore <larisa.grigore@oss.nxp.com>
+Co-developed-by: Ciprian Marian Costea <ciprianmarian.costea@nxp.com>
+Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@nxp.com>
+Reviewed-by: Frank Li <Frank.Li@nxp.com>
+---
+ drivers/dma/fsl-edma-common.h |   3 +
+ drivers/dma/fsl-edma-main.c   | 109 +++++++++++++++++++++++++++++++++-
+ 2 files changed, 111 insertions(+), 1 deletion(-)
+
+diff --git a/drivers/dma/fsl-edma-common.h b/drivers/dma/fsl-edma-common.h
+index 52901623d6fc..63e908fc3575 100644
+--- a/drivers/dma/fsl-edma-common.h
++++ b/drivers/dma/fsl-edma-common.h
+@@ -68,6 +68,8 @@
+ #define EDMA_V3_CH_CSR_EEI         BIT(2)
+ #define EDMA_V3_CH_CSR_DONE        BIT(30)
+ #define EDMA_V3_CH_CSR_ACTIVE      BIT(31)
++#define EDMA_V3_CH_ES_ERR          BIT(31)
++#define EDMA_V3_MP_ES_VLD          BIT(31)
+ 
+ enum fsl_edma_pm_state {
+ 	RUNNING = 0,
+@@ -252,6 +254,7 @@ struct fsl_edma_engine {
+ 	const struct fsl_edma_drvdata *drvdata;
+ 	u32			n_chans;
+ 	int			txirq;
++	int			txirq_16_31;
+ 	int			errirq;
+ 	bool			big_endian;
+ 	struct edma_regs	regs;
+diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
+index cc1787698b56..27bae3649026 100644
+--- a/drivers/dma/fsl-edma-main.c
++++ b/drivers/dma/fsl-edma-main.c
+@@ -3,10 +3,11 @@
+  * drivers/dma/fsl-edma.c
+  *
+  * Copyright 2013-2014 Freescale Semiconductor, Inc.
++ * Copyright 2024 NXP
+  *
+  * Driver for the Freescale eDMA engine with flexible channel multiplexing
+  * capability for DMA request sources. The eDMA block can be found on some
+- * Vybrid and Layerscape SoCs.
++ * Vybrid, Layerscape and S32G SoCs.
+  */
+ 
+ #include <dt-bindings/dma/fsl-edma.h>
+@@ -73,6 +74,60 @@ static irqreturn_t fsl_edma2_tx_handler(int irq, void *devi_id)
+ 	return fsl_edma_tx_handler(irq, fsl_chan->edma);
+ }
+ 
++static irqreturn_t fsl_edma3_or_tx_handler(int irq, void *dev_id,
++					   u8 start, u8 end)
++{
++	struct fsl_edma_engine *fsl_edma = dev_id;
++	struct fsl_edma_chan *chan;
++	int i;
++
++	end = min(end, fsl_edma->n_chans);
++
++	for (i = start; i < end; i++) {
++		chan = &fsl_edma->chans[i];
++
++		fsl_edma3_tx_handler(irq, chan);
++	}
++
++	return IRQ_HANDLED;
++}
++
++static irqreturn_t fsl_edma3_tx_0_15_handler(int irq, void *dev_id)
++{
++	return fsl_edma3_or_tx_handler(irq, dev_id, 0, 16);
++}
++
++static irqreturn_t fsl_edma3_tx_16_31_handler(int irq, void *dev_id)
++{
++	return fsl_edma3_or_tx_handler(irq, dev_id, 16, 32);
++}
++
++static irqreturn_t fsl_edma3_or_err_handler(int irq, void *dev_id)
++{
++	struct fsl_edma_engine *fsl_edma = dev_id;
++	struct edma_regs *regs = &fsl_edma->regs;
++	unsigned int err, ch, ch_es;
++	struct fsl_edma_chan *chan;
++
++	err = edma_readl(fsl_edma, regs->es);
++	if (!(err & EDMA_V3_MP_ES_VLD))
++		return IRQ_NONE;
++
++	for (ch = 0; ch < fsl_edma->n_chans; ch++) {
++		chan = &fsl_edma->chans[ch];
++
++		ch_es = edma_readl_chreg(chan, ch_es);
++		if (!(ch_es & EDMA_V3_CH_ES_ERR))
++			continue;
++
++		edma_writel_chreg(chan, EDMA_V3_CH_ES_ERR, ch_es);
++		fsl_edma_disable_request(chan);
++		fsl_edma->chans[ch].status = DMA_ERROR;
++	}
++
++	return IRQ_HANDLED;
++}
++
+ static irqreturn_t fsl_edma_err_handler(int irq, void *dev_id)
+ {
+ 	struct fsl_edma_engine *fsl_edma = dev_id;
+@@ -276,6 +331,49 @@ static int fsl_edma3_irq_init(struct platform_device *pdev, struct fsl_edma_engi
+ 	return 0;
+ }
+ 
++static int fsl_edma3_or_irq_init(struct platform_device *pdev,
++				 struct fsl_edma_engine *fsl_edma)
++{
++	int ret;
++
++	fsl_edma->txirq = platform_get_irq_byname(pdev, "tx-0-15");
++	if (fsl_edma->txirq < 0)
++		return fsl_edma->txirq;
++
++	fsl_edma->txirq_16_31 = platform_get_irq_byname(pdev, "tx-16-31");
++	if (fsl_edma->txirq_16_31 < 0)
++		return fsl_edma->txirq_16_31;
++
++	fsl_edma->errirq = platform_get_irq_byname(pdev, "err");
++	if (fsl_edma->errirq < 0)
++		return fsl_edma->errirq;
++
++	ret = devm_request_irq(&pdev->dev, fsl_edma->txirq,
++			       fsl_edma3_tx_0_15_handler, 0, "eDMA tx0_15",
++			       fsl_edma);
++	if (ret)
++		return dev_err_probe(&pdev->dev, ret,
++			       "Can't register eDMA tx0_15 IRQ.\n");
++
++	if (fsl_edma->n_chans > 16) {
++		ret = devm_request_irq(&pdev->dev, fsl_edma->txirq_16_31,
++				       fsl_edma3_tx_16_31_handler, 0,
++				       "eDMA tx16_31", fsl_edma);
++		if (ret)
++			return dev_err_probe(&pdev->dev, ret,
++					"Can't register eDMA tx16_31 IRQ.\n");
++	}
++
++	ret = devm_request_irq(&pdev->dev, fsl_edma->errirq,
++			       fsl_edma3_or_err_handler, 0, "eDMA err",
++			       fsl_edma);
++	if (ret)
++		return dev_err_probe(&pdev->dev, ret,
++				     "Can't register eDMA err IRQ.\n");
++
++	return 0;
++}
++
+ static int
+ fsl_edma2_irq_init(struct platform_device *pdev,
+ 		   struct fsl_edma_engine *fsl_edma)
+@@ -406,6 +504,14 @@ static struct fsl_edma_drvdata imx95_data5 = {
+ 	.setup_irq = fsl_edma3_irq_init,
+ };
+ 
++static const struct fsl_edma_drvdata s32g2_data = {
++	.dmamuxs = DMAMUX_NR,
++	.chreg_space_sz = EDMA_TCD,
++	.chreg_off = 0x4000,
++	.flags = FSL_EDMA_DRV_EDMA3 | FSL_EDMA_DRV_MUX_SWAP,
++	.setup_irq = fsl_edma3_or_irq_init,
++};
++
+ static const struct of_device_id fsl_edma_dt_ids[] = {
+ 	{ .compatible = "fsl,vf610-edma", .data = &vf610_data},
+ 	{ .compatible = "fsl,ls1028a-edma", .data = &ls1028a_data},
+@@ -415,6 +521,7 @@ static const struct of_device_id fsl_edma_dt_ids[] = {
+ 	{ .compatible = "fsl,imx93-edma3", .data = &imx93_data3},
+ 	{ .compatible = "fsl,imx93-edma4", .data = &imx93_data4},
+ 	{ .compatible = "fsl,imx95-edma5", .data = &imx95_data5},
++	{ .compatible = "nxp,s32g2-edma", .data = &s32g2_data},
+ 	{ /* sentinel */ }
+ };
+ MODULE_DEVICE_TABLE(of, fsl_edma_dt_ids);
+-- 
+2.47.0
+
diff --git a/outgoing/v2-0007-dmaengine-fsl-edma-wait-until-no-hardware-request.patch b/outgoing/v2-0007-dmaengine-fsl-edma-wait-until-no-hardware-request.patch
new file mode 100644
index 000000000000..45183b0f7f66
--- /dev/null
+++ b/outgoing/v2-0007-dmaengine-fsl-edma-wait-until-no-hardware-request.patch
@@ -0,0 +1,68 @@
+From a5421ea034f07dac4e31ce83aa7ccdbbb70915a9 Mon Sep 17 00:00:00 2001
+From: Larisa Grigore <larisa.grigore@oss.nxp.com>
+Date: Mon, 6 Nov 2023 13:14:31 +0200
+Subject: [PATCH v2 7/8] dmaengine: fsl-edma: wait until no hardware request is
+ in progress
+Content-Type: text/plain; charset=UTF-8
+
+Wait DMA hardware complete cleanup work by checking HRS bit before
+disabling the channel to make sure trail data is already written to
+memory.
+
+Fixes: 72f5801a4e2b7 ("dmaengine: fsl-edma: integrate v3 support")
+Signed-off-by: Larisa Grigore <larisa.grigore@oss.nxp.com>
+---
+ drivers/dma/fsl-edma-common.c | 9 +++++++++
+ drivers/dma/fsl-edma-common.h | 4 ++++
+ 2 files changed, 13 insertions(+)
+
+diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
+index 62d51b269e54..d364514f21be 100644
+--- a/drivers/dma/fsl-edma-common.c
++++ b/drivers/dma/fsl-edma-common.c
+@@ -9,6 +9,7 @@
+ #include <linux/module.h>
+ #include <linux/slab.h>
+ #include <linux/dma-mapping.h>
++#include <linux/iopoll.h>
+ #include <linux/pm_runtime.h>
+ #include <linux/pm_domain.h>
+ 
+@@ -127,11 +128,19 @@ static void fsl_edma_enable_request(struct fsl_edma_chan *fsl_chan)
+ 
+ static void fsl_edma3_disable_request(struct fsl_edma_chan *fsl_chan)
+ {
++	struct fsl_edma_engine *fsl_edma = fsl_chan->edma;
++	struct edma_regs *regs = &fsl_chan->edma->regs;
+ 	u32 val = edma_readl_chreg(fsl_chan, ch_csr);
++	u32 ch = fsl_chan->vchan.chan.chan_id;
+ 	u32 flags;
+ 
+ 	flags = fsl_edma_drvflags(fsl_chan);
+ 
++	/* Make sure there is no hardware request in progress. */
++	read_poll_timeout(edma_readl, val, !(val & EDMA_V3_MP_HRS_CH(ch)),
++			  EDMA_USEC_POLL, EDMA_USEC_TIMEOUT, false, fsl_edma,
++			  regs->v3.hrs);
++
+ 	if (flags & FSL_EDMA_DRV_HAS_CHMUX)
+ 		edma_writel(fsl_chan->edma, 0, fsl_chan->mux_addr);
+ 
+diff --git a/drivers/dma/fsl-edma-common.h b/drivers/dma/fsl-edma-common.h
+index 63e908fc3575..ed210bd71681 100644
+--- a/drivers/dma/fsl-edma-common.h
++++ b/drivers/dma/fsl-edma-common.h
+@@ -70,6 +70,10 @@
+ #define EDMA_V3_CH_CSR_ACTIVE      BIT(31)
+ #define EDMA_V3_CH_ES_ERR          BIT(31)
+ #define EDMA_V3_MP_ES_VLD          BIT(31)
++#define EDMA_V3_MP_HRS_CH(ch)      BIT(ch)
++
++#define EDMA_USEC_POLL		10
++#define EDMA_USEC_TIMEOUT	10000
+ 
+ enum fsl_edma_pm_state {
+ 	RUNNING = 0,
+-- 
+2.47.0
+
diff --git a/outgoing/v2-0008-dmaengine-fsl-edma-read-write-multiple-registers-.patch b/outgoing/v2-0008-dmaengine-fsl-edma-read-write-multiple-registers-.patch
new file mode 100644
index 000000000000..3fd04bd37253
--- /dev/null
+++ b/outgoing/v2-0008-dmaengine-fsl-edma-read-write-multiple-registers-.patch
@@ -0,0 +1,90 @@
+From e803ee3d1d6a60006f0ebe631de9f78a246b8e42 Mon Sep 17 00:00:00 2001
+From: Larisa Grigore <larisa.grigore@oss.nxp.com>
+Date: Tue, 20 Feb 2024 12:29:09 +0200
+Subject: [PATCH v2 8/8] dmaengine: fsl-edma: read/write multiple registers in
+ cyclic transactions
+Content-Type: text/plain; charset=UTF-8
+
+Add support for reading multiple registers in DEV_TO_MEM transactions and
+for writing multiple registers in MEM_TO_DEV transactions.
+
+Signed-off-by: Frank Li <Frank.Li@nxp.com>
+Co-developed-by: Alexandru-Catalin Ionita <alexandru-catalin.ionita@nxp.com>
+Signed-off-by: Alexandru-Catalin Ionita <alexandru-catalin.ionita@nxp.com>
+Signed-off-by: Larisa Grigore <larisa.grigore@oss.nxp.com>
+---
+ drivers/dma/fsl-edma-common.c | 36 ++++++++++++++++++++++++++---------
+ 1 file changed, 27 insertions(+), 9 deletions(-)
+
+diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
+index d364514f21be..e70f7aa9bc68 100644
+--- a/drivers/dma/fsl-edma-common.c
++++ b/drivers/dma/fsl-edma-common.c
+@@ -496,8 +496,8 @@ void fsl_edma_fill_tcd(struct fsl_edma_chan *fsl_chan,
+ 		       bool disable_req, bool enable_sg)
+ {
+ 	struct dma_slave_config *cfg = &fsl_chan->cfg;
++	u32 burst = 0;
+ 	u16 csr = 0;
+-	u32 burst;
+ 
+ 	/*
+ 	 * eDMA hardware SGs require the TCDs to be stored in little
+@@ -512,16 +512,30 @@ void fsl_edma_fill_tcd(struct fsl_edma_chan *fsl_chan,
+ 
+ 	fsl_edma_set_tcd_to_le(fsl_chan, tcd, soff, soff);
+ 
+-	if (fsl_chan->is_multi_fifo) {
+-		/* set mloff to support multiple fifo */
+-		burst = cfg->direction == DMA_DEV_TO_MEM ?
+-				cfg->src_maxburst : cfg->dst_maxburst;
+-		nbytes |= EDMA_V3_TCD_NBYTES_MLOFF(-(burst * 4));
+-		/* enable DMLOE/SMLOE */
+-		if (cfg->direction == DMA_MEM_TO_DEV) {
++	/* If we expect to have either multi_fifo or a port window size,
++	 * we will use minor loop offset, meaning bits 29-10 will be used for
++	 * address offset, while bits 9-0 will be used to tell DMA how much
++	 * data to read from addr.
++	 * If we don't have either of those, will use a major loop reading from addr
++	 * nbytes (29bits).
++	 */
++	if (cfg->direction == DMA_MEM_TO_DEV) {
++		if (fsl_chan->is_multi_fifo)
++			burst = cfg->dst_maxburst * 4;
++		if (cfg->dst_port_window_size)
++			burst = cfg->dst_port_window_size * cfg->dst_addr_width;
++		if (burst) {
++			nbytes |= EDMA_V3_TCD_NBYTES_MLOFF(-burst);
+ 			nbytes |= EDMA_V3_TCD_NBYTES_DMLOE;
+ 			nbytes &= ~EDMA_V3_TCD_NBYTES_SMLOE;
+-		} else {
++		}
++	} else {
++		if (fsl_chan->is_multi_fifo)
++			burst = cfg->src_maxburst * 4;
++		if (cfg->src_port_window_size)
++			burst = cfg->src_port_window_size * cfg->src_addr_width;
++		if (burst) {
++			nbytes |= EDMA_V3_TCD_NBYTES_MLOFF(-burst);
+ 			nbytes |= EDMA_V3_TCD_NBYTES_SMLOE;
+ 			nbytes &= ~EDMA_V3_TCD_NBYTES_DMLOE;
+ 		}
+@@ -639,11 +653,15 @@ struct dma_async_tx_descriptor *fsl_edma_prep_dma_cyclic(
+ 			dst_addr = fsl_chan->dma_dev_addr;
+ 			soff = fsl_chan->cfg.dst_addr_width;
+ 			doff = fsl_chan->is_multi_fifo ? 4 : 0;
++			if (fsl_chan->cfg.dst_port_window_size)
++				doff = fsl_chan->cfg.dst_addr_width;
+ 		} else if (direction == DMA_DEV_TO_MEM) {
+ 			src_addr = fsl_chan->dma_dev_addr;
+ 			dst_addr = dma_buf_next;
+ 			soff = fsl_chan->is_multi_fifo ? 4 : 0;
+ 			doff = fsl_chan->cfg.src_addr_width;
++			if (fsl_chan->cfg.src_port_window_size)
++				soff = fsl_chan->cfg.src_addr_width;
+ 		} else {
+ 			/* DMA_DEV_TO_DEV */
+ 			src_addr = fsl_chan->cfg.src_addr;
+-- 
+2.47.0
+
-- 
2.47.0


