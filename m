Return-Path: <dmaengine+bounces-3971-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD039F2B3D
	for <lists+dmaengine@lfdr.de>; Mon, 16 Dec 2024 08:58:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E23A81886092
	for <lists+dmaengine@lfdr.de>; Mon, 16 Dec 2024 07:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FD9B1FF617;
	Mon, 16 Dec 2024 07:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="xmrsX+Zz"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2070.outbound.protection.outlook.com [40.107.20.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F46171BB;
	Mon, 16 Dec 2024 07:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734335912; cv=fail; b=MrzaPJBACjMGnjjeTeV8KclfGuhPWcAy1KF5MsJd2kwT+Ko65kbig3tiKIgrVgGWbz7DcON6gwdjgy0CFPxgnGg4bI2uVnC21EGfzIUmXqwa0EgC0U7qA1ZmmBQAIygNeEWnmEweWzZtf2VI5b1XNeUMxr/w0Tq8BcGzX0esoZQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734335912; c=relaxed/simple;
	bh=C4jFXIJzpLTl7qcUFkvQ8jullgOcGW3GqyIGLoJnEMU=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=QnEOTQm2pX3jxBdvw+4emvS3sRTzQyMILzcobRRjmAu22tRvoCgoMEj0QGRosyzspg9D+Jmj8kzNrdrwg66D2hF4JP5ry7Atl1m56VvayXXA58GKQITQO1OkhK2Ti/Xy+AEk500T0KZwbIHbUowd55SHmlktIlwzp5di+ENdSng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=xmrsX+Zz; arc=fail smtp.client-ip=40.107.20.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ncn0PPkDW5Doc5yvh/KqsEwrCJHRXJNdbigkzT9ErUf2HN3NVjkwLnMgZNj/Waa8TvR2qq3nJ6hYHlQF84nTX5dETWYCjzJBYBstL0xzJm39grT/tA5JgEYaWHcIVvJUJ+9w8LXEufeOAkmY3Ww6x0WYFLZQpPehWyetPl9oS+nkpG+eLgGrLOBa1gnxMJceCjYHtKhTUf3UUn05qHHPQZLonTNfdfMY02PKQa9713loO0BrDMi2EY4acRNjZIClIEyWh9lBMq+wqqa/Ipk3Fbw6GSFjMX3lYg/DQSTMKcjj2KGhJqNwtejVB6MWio3fS8kuEw8fdkg8UwTAmo9BAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jAJwzb+ekeTYhlaP04Whmb52GGRt/OdqPU824IWjyo4=;
 b=wrRhqLrKKWScZWG6breLGIl4dJv6MTsI59Dnm1VEJl0z8ygjRtdcoI2jRX0wAcMF8k9Hf21ZeoZf842/MBOYCNR6E29nbyZ9zlp9RYK5VpjKrbF1veE1Imw9dpObkFReQsT2zqu+n9wj+VLwygDmIaOlbF0M6k9H9d2uM0/vc5m58cp1Aq2Ypgnwk4l+Cpgmm22It34noyhUNCcbzj/292v/9LexsVavvexMdziDlkfHS+AToVWmf/SIWPXus46ZM5w9U5nwEQH3AIyDeM3BIVjp55MyzSZQzCqe8idwsR21bOLEZWRrkwtDoVccbGkZRgfO7snF/5Q7zfQnfPmWQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jAJwzb+ekeTYhlaP04Whmb52GGRt/OdqPU824IWjyo4=;
 b=xmrsX+ZzR7xMI4AA/cIAvoqFUTqOpIWbvuxDB3ynNSTyAjG0tyEv4TP1b826IYinMVTlHTgcKUwfYvBeTL55tcaKj7S6AbvkBA0DxyBIod0B0fZuRtmWFeGg+KFfRje2/AhDqBmJuj44oZ6ouMt6Xr5RZjTgogXD0p0mOnKzDVj+tnyoxYm8rc5IOfUaeNd4VIETqKTO1fj9qT1qyq5enKp2OTJVoR1PfD60p12aS7uV22ClLfC5BG9FXrqQZKpKathIPPxd+nyGGh0GQRYf15fks2aujAm8Fo2ElVjvpRpVHCAwXJ8gQ3oWLJ+J65/a7iQ3flTetszGWmLtRyn+KA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AS4PR04MB9550.eurprd04.prod.outlook.com (2603:10a6:20b:4f9::17)
 by DU4PR04MB10361.eurprd04.prod.outlook.com (2603:10a6:10:55d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Mon, 16 Dec
 2024 07:58:25 +0000
Received: from AS4PR04MB9550.eurprd04.prod.outlook.com
 ([fe80::e28d:10f8:289:baf7]) by AS4PR04MB9550.eurprd04.prod.outlook.com
 ([fe80::e28d:10f8:289:baf7%6]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 07:58:24 +0000
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
Subject: [PATCH 0/8] Add eDMAv3 support for S32G2/S32G3 SoCs
Date: Mon, 16 Dec 2024 09:58:10 +0200
Message-ID: <20241216075819.2066772-1-larisa.grigore@oss.nxp.com>
X-Mailer: git-send-email 2.47.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR04CA0098.eurprd04.prod.outlook.com
 (2603:10a6:208:be::39) To AS4PR04MB9550.eurprd04.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: f5e5d0a5-c6a0-4c40-d279-08dd1da76960
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OFJHeTU4SUhEM3pDV3VtcFMwbXBINVdlL2VEcFJzWldwY09EblBHdm9QSlJY?=
 =?utf-8?B?THd3UzZKSjFNYlF1cHFZVzFqd1puUEZTNjZyU05qblhyK25rZjBCUnh0RlBv?=
 =?utf-8?B?SXd2QklRQk5tb28xbE9sOUZTRmI4Y2lFRE5jWHZpdlBtRnlueFZxdlFTUU5y?=
 =?utf-8?B?ZDhRTFFpR1g4dFJpc3R1aGxzdlB1UlkyRFRVcEhjb3JpTkVYZTdsTmJqREgy?=
 =?utf-8?B?bllrVnVVTWhZTElDdDRZSDBjTVpVTE1KSmNKSGxLMTlpalhQVE1iNWJMK2xB?=
 =?utf-8?B?OWM2azdxRTE0cGtvSktOTHFXNEJ5aHFLU0trTlc1VlVGdktCZW4xWGVzTzhZ?=
 =?utf-8?B?d0V3ZGFreWt3dzVERG1lZTZXcFJFM1dkQ0V5TXZtSjEyR3V0ZG5oSnlCcEkx?=
 =?utf-8?B?VEk0UkRTUlEwazhDYmcrQ1BqT2VnR3dpb1JUdCszbUFSRzU2b0V1R2tXSzRj?=
 =?utf-8?B?S1F3S1pnS1RRMFpHYWt2NHEyN1RuYkVPZ0JVazdDQk9pNHN1SE41RUpKYzJ1?=
 =?utf-8?B?cUZORHJ3a1ZZZm55cDRFNDRNWjBQZklpUWhWTkVDSXFkaVpuaUpXcHN3QVJh?=
 =?utf-8?B?UFZuNjhmbmxqb25oME0xR1dkYVVvTFBhQ0Vham03V0ZJNUtiWXdaZ2lWdXVm?=
 =?utf-8?B?dGFLKy84bFNMckpQSE1FbnBoNjMzc2YvWnAxN3hlV0RLTnpuVDRxTG9xclZn?=
 =?utf-8?B?bG5INmlwWUtnK0ZqT1pqV2o1UlNuM2gzM0RHYjAwUjlzTGh2M3lncVJKc093?=
 =?utf-8?B?TFZLQlhXM3JURktGNDZzcEs5TDMxTVNGdlpzVlIxUko5ZXdkNElQbU5Tb0Rs?=
 =?utf-8?B?R3F6elpJMUVsMUhRdXQzbVZTVEd6OTdxY0kvaGdRTVZndG05MXpTcXp6azZV?=
 =?utf-8?B?d091R2lnN0Zkak84NTRIZC84emVsejViNEkyWEpUUUJvZzJsSzY2MUFIQzVG?=
 =?utf-8?B?SHpIV29iM3NaK21Sc3ZXRkRycFc0clFaUmFvQ2I3UVNhdVJtY1F2bWtuN2ZO?=
 =?utf-8?B?T3dTSkxwQ2U5cWxMVkZFTThDajg0a2VsbFJ1ZlBTOCtXQm1xTEhTb0FleVlC?=
 =?utf-8?B?N0FsVzNIRGFhWWZmVUlCdTRHeE5ibHZQejkzc2RRK3AxREM0NU9hWHgzTzdC?=
 =?utf-8?B?dGxQaXUvR2R4Qnc5VGNUdTZkZXhJYU5jTHZ0c0E4QVZ3Mm8wd0lRU25uWGF6?=
 =?utf-8?B?SVhwU3d2RzJSZmQyZlhSSWhsWkZhSm5qdDdRcGkrdjh2VjIxcTQyUUJoTExx?=
 =?utf-8?B?TkVDNkRTSjBYd2V4dldqOHFMWXFnUGlwRkJyMkhGOVRYTVRnMGtCTFVhUXhE?=
 =?utf-8?B?dlRlSnVyUm1VYThFMVB0aDlVdnZlOURaNWNIcUZ4NnNyMVFsWlZZNUJ4aVRZ?=
 =?utf-8?B?UkpmMDV2RVV5a0pKQ3pvRWFLbmZQTDYvMmhDVHZ5aVVNdlhla3JHb21zOFM0?=
 =?utf-8?B?VXI0ZVU3bHI5YzlmS3BmRk54RkR5b3l2S1JXcXJwQ0pKUnpDcE5BQWM4bm1H?=
 =?utf-8?B?TjZhU0JobnNiWnY2MUNQNjBaRWVrSFVSMlBrazFQc2NCbFRBOWZxZ1ZPWXlO?=
 =?utf-8?B?SERuYzkrWGJHTmI3YVhtdkNEa3haTEVVNWt5QnlHOFFLbENRL3NoWnRyUkw2?=
 =?utf-8?B?ejRxUWJIS3k2bmIrWnNkSzRqWHEzQkdtQVBXYmYrK0Z1dm9CckFxSjhzcS8y?=
 =?utf-8?B?VTFGQnZzaUhyWnNEcHl3dFFBeTBUTHAxVmlVMlhWR0VyNjhQcmVEdjc2NldG?=
 =?utf-8?B?eEU0d2lqOHNjNXdkcUNHanNPMGtpL3IvSkZjUWhaUlVVQ09aRGY0LzZjMmJ1?=
 =?utf-8?B?RkxkSUJaWEJmeHhOMHFaV3JJakNVWFhFRWx6dWFsbW5mRVZYN3FRbEUrMTY3?=
 =?utf-8?Q?2kN/u/XHuSzdG?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9550.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K1lyb0pGRFp2SEF0V3E0Y3JpQVJ5eXgzYkVBbS9aTjU1TzVDTzQ4cHlqWTZh?=
 =?utf-8?B?MjBBcGpEaGdDTENaUVhoa2RyQkxseDV3L0xWWEpxT05zM3ZqeThueXVoRVBO?=
 =?utf-8?B?aFpvcjJ1cHNsNGhaTXRWRFRjVnZOL0N2UUlUWXZ4WEp1K2p6OG5qMGV4SVZ5?=
 =?utf-8?B?c2dMazFSL1JhWWtUNHE0KytSd0lCbXN0VDlta0dlTDZ2bzlKU0dYZ21jazZZ?=
 =?utf-8?B?VlJOaWdpSVBla04xc0VWUnAwbS81bjFQTnpkVk9pa2YxQjVzeEM3ZkJ0V3k3?=
 =?utf-8?B?Tmcwb0x5ajNMcklmeTZYMGQrQytKcjZGTWlSSnhEa2xzelVwYkg0QmZrRVo0?=
 =?utf-8?B?NnFnR0NCOEsvcFNtRFoyT0FEODVuNHJIS0FEM2V0WXpXTEFETFdMWHZoaGtj?=
 =?utf-8?B?OWZEWFVjeDAzMXlkUlhMblV6cVhQS282WCtudWhvQjRvdHRielVudmlDK3FE?=
 =?utf-8?B?Q0M2WUFBdmVRRkdIdTdQWGd5ZFBqQ0twQjBLSDlWZ0hoc1JXcTNWK0FMVC8y?=
 =?utf-8?B?bzJ2N3N2NVJEZ1Q1NUhFR2Q5Rm9DaldPRzRxZ2xwbmFLbWZXRVlnRjRiSE5l?=
 =?utf-8?B?RjVaNnJjSHhKZnd6MXBxa2hOeTN5ZDZxNHlxU3NzM0dMSlkwNU1sZk1jTXVT?=
 =?utf-8?B?b2pVSXVNSW1sZmVHK3BoQktuUzl2MmdIbUlON0xhZ0VZOUd4RHZBbEtjSmpp?=
 =?utf-8?B?N3dRclU0ZHhzcHVuVVJ1eTRUQTFFd2tWTG9xTityN2tyNEkxMVdzWFBzNHor?=
 =?utf-8?B?Ky92WUlzR3g1U09aYjR6RUNhdnF6VXUyQ0s3ZHZ6eHAxU1hwSE91WitCK1Bu?=
 =?utf-8?B?RkdoelY3K01zWXo4c2p0SGNrV0hZTndZbGRNaWtVVk0zZzdOWWhMbU0wM29W?=
 =?utf-8?B?SDEwSlZ4SFFtYnhQUnd1anlmS1prMU1mdERUcmhRTzR0TVlrZmxZTDJ5NkZm?=
 =?utf-8?B?QXp4TEhKdEtGeWd3RWMyS2lqQ0wwbXlKeXVsWXFPZmFkR3R2RXU4YmZneTVx?=
 =?utf-8?B?ZTFBcE9OSWlHaEtsQ01SVVVNUzhaMXl2UXBxWEhYODFxcklXVUtnWURHL3lt?=
 =?utf-8?B?cXVPd2UrelIzUm1NVkVLZzROK0N2WS9CWDFQUXlieVQvK1BiZGYyRGV0Ny96?=
 =?utf-8?B?NHU4WU51dnFSNWxVSFBlczZzakR6S3JIVFRQbTlvVmhTMml6eDZ4aWxqSGFP?=
 =?utf-8?B?QXpRQU92U2w2Znl5TlQ5R1pNdFg0NE1EOUJFWis1b3N5Zkl6ck04S2pKTXdY?=
 =?utf-8?B?c1Y5OW1MSlNTbzRDT3VlQXN1R0hzTzVXRE4wT2hTNkUwdlhFR29XQzJMc2g4?=
 =?utf-8?B?WW5QNk1ENDRWWjc0NDE1endsNWxlNmJTZWJKYkwrSWV6bTVBeXdoV25LeTlF?=
 =?utf-8?B?RmJielJGQTg1eGNmaWpZZTFDRUFTZmtJWlZMb3FwbTRGekh0cm5UTXc4ZUlR?=
 =?utf-8?B?MW4vZnluU1NKK3NVUTNoSUhPdFRHVzNINlRVSmV1UE1oSm8rdm9vblJ6b29y?=
 =?utf-8?B?RG1EYSsxU2YrdDRUbEk2THRKSlpQMlpadWN5Ukl3MGcyWlBKY0daWXBwK3Ur?=
 =?utf-8?B?NFFOZkFacGhGTVJTaXExenRxNC9PL050WlFSNk5rTm53enExZStJdElOeXQ1?=
 =?utf-8?B?VVg3WGF2U2ExbVVTV2cxdTFIOWVRWUFKbDEzQ0hqUCtpZjFlNFQ1L1FmTGJP?=
 =?utf-8?B?ZGVuUVEyVjJaSS8rYlFtMG45djJlY3VtQUFIZ1YydkpESG90akFRbHVyVjVI?=
 =?utf-8?B?YlJwSFJpS29DemtKZ21aUzIxUit3WE1xSG4wYTZDSTVNeXBFVksrUi9FTUls?=
 =?utf-8?B?Vk5wYlBmQkUxZ0syUmw4RzlXOG1wOC9xSXJQY2xsaUZ0QmtmelVKSWpwT0t6?=
 =?utf-8?B?czE5cG01K0tEZnI4QXFUY29YeTRpMmtLYWxOcWJiQlBuQ3lTOEY1UXk4eWx1?=
 =?utf-8?B?Y0RLTENlaWdDSy93QzBKNTBkQnlTSlNsWDNSRmhiTExZMWNzSDc1WDZ4QlRh?=
 =?utf-8?B?WUlySHJxZlhSRUlkRmZ4ZGM1RHU3WU53Y2lSNjBMZjJKU2VRUE42cnZmTFBn?=
 =?utf-8?B?UVowSFE1RjhtdjVGU0twVUJVd1NwTjRvZUQ1d0VqdkFTMUNzUS81V1BXUVFv?=
 =?utf-8?Q?T7v4UE7RwDoLmWw76WcA433lN?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5e5d0a5-c6a0-4c40-d279-08dd1da76960
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9550.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 07:58:24.5306
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KRBxGPjCstb5ZQUlZIaGkankUJMAhRGGg/2Ywlgt4LhcwtA9fj1cnN2IKGP6HB8M3hzjVr37PVKpuEnLJ0K9qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10361

S32G2 and S32G3 SoCs share the eDMAv3 module with i.MX SoCs, with some hardware
integration particularities.

S32G2/S32G3 includes two system eDMA instances based on v3 version, each of
them integrated with 2 DMAMUX blocks.
Another particularity of these SoCs is that the interrupts are shared between
channels as follows:
- DMA Channels 0-15 share the 'tx-0-15' interrupt
- DMA Channels 16-31 share the 'tx-16-31' interrupt
- all channels share the 'err' interrupt

Larisa Grigore (8):
  dmaengine: fsl-edma: select of_dma_xlate based on the dmamuxs presence
  dmaengine: fsl-edma: remove FSL_EDMA_DRV_SPLIT_REG check when parsing
    muxbase
  dmaengine: fsl-edma: move eDMAv2 related registers to a new structure
    ’edma2_regs’
  dmaengine: fsl-edma: add eDMAv3 registers to edma_regs
  dt-bindings: dma: fsl-edma: add nxp,s32g2-edma compatible string
  dmaengine: fsl-edma: add support for S32G based platforms
  dmaengine: fsl-edma: wait until no hardware request is in progress
  dmaengine: fsl-edma: read/write multiple registers in cyclic
    transactions

 .../devicetree/bindings/dma/fsl,edma.yaml     |  34 +++++
 drivers/dma/fsl-edma-common.c                 | 112 +++++++++-----
 drivers/dma/fsl-edma-common.h                 |  26 +++-
 drivers/dma/fsl-edma-main.c                   | 137 ++++++++++++++++--
 4 files changed, 257 insertions(+), 52 deletions(-)

-- 
2.47.0


