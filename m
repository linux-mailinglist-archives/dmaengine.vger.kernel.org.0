Return-Path: <dmaengine+bounces-3979-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 015379F2B51
	for <lists+dmaengine@lfdr.de>; Mon, 16 Dec 2024 09:01:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF089188619C
	for <lists+dmaengine@lfdr.de>; Mon, 16 Dec 2024 08:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA9B8201260;
	Mon, 16 Dec 2024 07:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Cl91czg+"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2070.outbound.protection.outlook.com [40.107.20.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A522C1FF7C5;
	Mon, 16 Dec 2024 07:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734335929; cv=fail; b=Qz3v++E8oFkmlJ07UMbLj/ECxGYV0WxXGwWAQalbOhou/wL1hCSilcqmODFcgeH1GUMDW/RjNXC3UsYWdg4VIJmwf8cbDRXM8GidA8Mpxv73RJnoMSmYzakZvEpMNRan93Q1K75Nuiq3eRk10w9bCnhhTrPuEYhWv00vDTYEqNE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734335929; c=relaxed/simple;
	bh=3u1I9mecfrM1ZthBTezjocM9AwW1fNpwLEyC92SYc6M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Loi0e1iTTVh376G5RZanOzxYTca1BTvHo35KSqW8VJ8khNiryZVVNSLBVDSGVZuYUYzhjYFbTrw+wk+ILbsnE1KH2f4AjVFxk7W+vtMb2mi6lnv1BGUoVHkvnlVScBx3gpWl/Mf/B78zB+OYgApy0VAUVKY6hcGPogHkaWTqDuY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Cl91czg+; arc=fail smtp.client-ip=40.107.20.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=soqoVDl/pqO7o8uJR/cgaieGJ99gg3bL5o3St9mqunB6pi4TCSwdVcE5gNVafE3OgKFIRJPE38L/afjheLZuS30H/hB+1uUqvbp+i7HeN+jf/TIgAA5V+I7Zcv2/MqcgzQyC4+yqRG8Rxc1Sd9PBqENrWVOpgcFrZhB+baCQDzt3/JrKXzXDpbNncLS2OV3PieSXb4hgdK94+S08SaxYqPhS+JFUFYphxBNdyL6wbIvTiUJf5w4YkepNIYgm6yT7uOhwdtzLBUPqKJD/FfAOACEaNstNuvRUSUt36PKu/dbaYsfitdW/wJ4MVU8q2tNDFmrsuxuc6WJfG4y7JYAggg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CG4S+uU44FO8P3eYVZXQjKfoUG/2vfbNF4ZdtMEfnok=;
 b=WP51Cy84GV+I7EPCPTGT6F0VrExebk4qd7M0mlWM3Z4Y6HkRJqqr7vlxawCrWMLBBkQeN9abOwPdsiAGX7V8s+NQNjkm+jpuUVPciK/TgCOHvKFL4MjFa+8qohI5t2d+D9n2VsDwvgI8sfQ91tDXsA6Bw71dtxGm9ZvON367ln0IIVd94a7wWw3TvZs3H3PZn0s/FAJ1va83pV72/3SOJfv1G8W27yghoTdLQIjsa/pMUT+ZYIo8HvnES01CSAQOtn69Qh0PZMzgLqYonyXmuzg2gHylU9XB3dPyvQ7Jrfnk0PonV8bBJimGYAmc45eJYY+7JWK6JcuAxduz+F8gzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CG4S+uU44FO8P3eYVZXQjKfoUG/2vfbNF4ZdtMEfnok=;
 b=Cl91czg+0ok2boNLYpcuwM6gCJXJBPw1HM2WTrKqXRCEFeD5ZvD/ihy3QYH8602Lv6oEpVxqQnlvapuviJ1mvwBKPfu+vrmbjgeByV1mBYoLfB1uLxnzSpsDsmzWSWdWK7LI2EtVcyF4syo0LdDmnd+5SH9BYFghpw2S0NMG/7uH66fzK/c1rZfzmpzYzs0QLkQnxOUpJa5vmll1Zgv3oicus325X3DzRb+M1NjuHSF8xhLK3QvAtcbyUIMvNZiqaHqEJ7poARR/u4yRsMyaR+0Jolv9RVCN0eekU8OlCwGWEQ6mYAOTRyESX7MvA1+roqhOXlzCRZ0t9jKiHUO3Kw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AS4PR04MB9550.eurprd04.prod.outlook.com (2603:10a6:20b:4f9::17)
 by DU4PR04MB10361.eurprd04.prod.outlook.com (2603:10a6:10:55d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Mon, 16 Dec
 2024 07:58:39 +0000
Received: from AS4PR04MB9550.eurprd04.prod.outlook.com
 ([fe80::e28d:10f8:289:baf7]) by AS4PR04MB9550.eurprd04.prod.outlook.com
 ([fe80::e28d:10f8:289:baf7%6]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 07:58:39 +0000
From: Larisa Grigore <larisa.grigore@oss.nxp.com>
To: Frank.Li@nxp.com
Cc: dmaengine@vger.kernel.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	s32@nxp.com,
	Christophe Lizzi <clizzi@redhat.com>,
	Alberto Ruiz <aruizrui@redhat.com>,
	Enric Balletbo <eballetb@redhat.com>,
	Larisa Grigore <larisa.grigore@oss.nxp.com>,
	Alexandru-Catalin Ionita <alexandru-catalin.ionita@nxp.com>
Subject: [PATCH 8/8] dmaengine: fsl-edma: read/write multiple registers in cyclic transactions
Date: Mon, 16 Dec 2024 09:58:18 +0200
Message-ID: <20241216075819.2066772-9-larisa.grigore@oss.nxp.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241216075819.2066772-1-larisa.grigore@oss.nxp.com>
References: <20241216075819.2066772-1-larisa.grigore@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR02CA0160.eurprd02.prod.outlook.com
 (2603:10a6:20b:28d::27) To AS4PR04MB9550.eurprd04.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 8416422e-ce29-47cc-8396-08dd1da773ab
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MllnNmxmZGFKQXE4WklPTXVGYkVieUJBMmFKNXdpZWZHYW1DTDVuVnMrYzJE?=
 =?utf-8?B?NnBIR081SHR6R2dGLzlvd0ttQzJIM3NYVytkeElYbDhvaFBEbkh3TFg2TFJo?=
 =?utf-8?B?U3VyN1hzYldITFJkNm56T1lvOUM0dHNDaUtvTnhwQ0U5UjF6aVJGRkdlSlRE?=
 =?utf-8?B?MGVuNzB6VHZWb1lWMGdhOXFFWWoyY3dYd0ZSMzBQbTZjVFZtTEZ6ZW9leXp0?=
 =?utf-8?B?VVRvNmdWZDN3Ylk5UzlCVi9jdi9QYUhraVJmelZablI2NXY4aDF3dGVXaXpw?=
 =?utf-8?B?Z3plQmN1aGVOREIrQWw1TENVcWlCenlsSUVUYjFXWTFGay84dERJZkhTT1JO?=
 =?utf-8?B?T3pqSXJwNEsxZkg4cWZWWWR2akNCNDdRRktnaXBNNy9ya1FkRE9UTEFscEpl?=
 =?utf-8?B?YkxVTGxpWGNiaFBVUzJaeG8rMkxnUDJxMitNQWl2RFhoOEM4Y0NSUjhaZGtN?=
 =?utf-8?B?b2p6RTMwYlQ1MlA3K21hRGFZdWFRUmhPVG8wSTZpZStCL2l3R1RiSE5RdE93?=
 =?utf-8?B?Z1kyNHRLVjBVcXhJQ2ZCajJpNjd6cEQzdFZPbDBBMGlQZ1k2Y1lESXJBWjlK?=
 =?utf-8?B?dWgrTnE0b3ZhYit6MWN3UC9oRHIzMVJjUHJ3K1RTdEhnY3J5N2plcmNWdXZm?=
 =?utf-8?B?R0lzV3lvTFltSXBTbjdoTHVIMXh0cHU0UjRwakRETm1iQ1dlZFFSaFlSOU12?=
 =?utf-8?B?Vm90MEdwOTJ2NXR6Y3k0Qy9JZUNpTG8wODV4c2lKMnAvMWJRdG9HVTdyNEl5?=
 =?utf-8?B?dm1jV2ZaUEJBMXBhU3h5M3o2eHhTc2w5Q20vbUlMYnBpeTRaeS9tSzhITjJR?=
 =?utf-8?B?RzUvTGlNOFkrZmpDaU4zYjhXc01tWFcvTGJvNVJybGZhWHRJVGtVc3prZnlx?=
 =?utf-8?B?QlY0TzdwaHJidkkrekIvaW9kVlJrd05ERUJaNVdjNys0RW5TTU1EMVhTYUp5?=
 =?utf-8?B?NEt6a3h2OTNrdG5HTkJLUVdKQ0VzeEZ2a2JTVENIeVBUUE92aFN6d2NoZmg0?=
 =?utf-8?B?RG9UdG9heGxYOFU3S1dMYmdZK05xbHJjdFdXMUMzMmUzUmRxMXkvZDgrbk0z?=
 =?utf-8?B?QTg2NGtyd0kyb1I2ci9IclJVdzQ4OEJuN1E1K3N0YktpdG4yUFc0S3lEREdk?=
 =?utf-8?B?djRKTHYwVmdPZGkvTk96WVR4S1VLQ0pWNWZxUmhuRTVSUnJrWCtmNmdYdXdC?=
 =?utf-8?B?S3hRakpXdUNITEFzb2xvWDd5eDMzYWZlWUw3em42bkE3ZGVPeWRXR1dBdXNO?=
 =?utf-8?B?dGlieEtTdUdLS0pnUTViS05Hd2FKVmhuSEwvZ0FwSXNPZlB3clV1dm4wK3pG?=
 =?utf-8?B?S1Q1ZVgydlcxNUh4cVc1bHdZcjUvUGMxWUR0S1RqMXlPRU9uVUpoRHIxZmd2?=
 =?utf-8?B?dVFmNmFZMUVxZldob0E0bXNMZ0paUktoald4MlpGRiswMlBOcmFRVmJyclV3?=
 =?utf-8?B?VmVZSlpabCtXaGFOaGt6aWkrd1BlRU1ZMXRqRkJjV1g5cG1sVmY0TUpDSnJv?=
 =?utf-8?B?VlZWdFg4TGxJZjRTdDhlQzFOQmtsalh6b1hDd3hWUTJBQWp6WjRmUEdUNDkx?=
 =?utf-8?B?dmV5NEtnK3dYcDJXVFdLZVpCYS9zdGUwOTREVmZrUFk3UmhVa3hVNTNveXNm?=
 =?utf-8?B?N2FwUGZPK0VRQ1NtWmZrRjlGRG1kaU5qSE5OVUZ3UXRBMWtVQ1RvbVNrcEhO?=
 =?utf-8?B?cHZBWHFDZFFlY1NkQ0lkczlaR2w1emFOVkFaSUZtWklETjBpaDNOVmNxaDVT?=
 =?utf-8?B?ZVRSd0hmd3dScUczYXVIYXFNLzZnTE1EdDFMY1NYb3dMNFhjbnNoQUw4RlZz?=
 =?utf-8?B?Rit1SWtXYTlyL1NhWm5qZC9XbUZkc2RtUURpVWhHQnZCSlUzSXMzWEc4cm93?=
 =?utf-8?Q?ILeZku4BT8s8L?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9550.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WE05aWhTSXV2TnBna0k2NG94SkVZQWJQbGkzUjBocENQQ0xad2xxb1piUE1q?=
 =?utf-8?B?aHdpc04vSjJkMTd6OGh3MGtsUkNBR0l2OXplNzNsaFEyNWZqVVJ5eVNhbm5J?=
 =?utf-8?B?eUFJV1ljS1pVT1dmalFoZUE0bHFQN2l4MHNnNmdBUHFtd01Rb0UweXJjZjNh?=
 =?utf-8?B?akdCUk0rREJKNG94OWJwNUEwUndtQUFlT3RYbUsveWRuTEJ5VGtPbFNhREx6?=
 =?utf-8?B?czcrNkRJT0F4ZjZ6TVFHdWQvTXllMk9RNlVxNWlmT2hzRUUxZUJjZXFSdXoz?=
 =?utf-8?B?VGxiL0xEOXVBZUV5dnNwY043VXlmUnFqRWx1S3lJRGRWMnZSUzZHVUxhamlo?=
 =?utf-8?B?dU5hMTl3MWRyVXUvcFpYWE5XZU5BRmZVMm9HMVBuK1BKenIzYTZGTkhScGYz?=
 =?utf-8?B?WW1hTjQrdHhjSiswZnhoTSt3OE9YZlowWHJQaE9mT2d0Nm96aFR6L24wRzRC?=
 =?utf-8?B?eXRVa1pwN1JvdktiZFV2SjZlM1kwc1BVRHgyVk52bkk5Skl6VUJtanVtNm9W?=
 =?utf-8?B?Um1Xd1B3SVFSYlNxNFpDWjlzVHdnSnZXajVpRXhXc2FkTjVvaFRrcnNJdWR4?=
 =?utf-8?B?MWFVY1RlZFlPRHNCSWlYTW9LYVl3dmFUa3c1RGplVUxDSXVFZmhXTVNSbkRw?=
 =?utf-8?B?aG43dXNGNVhCMEpXTmNUVitPSGhIZlRGR2hNQUh4QkI1dUk3ODFyTkMwTWdk?=
 =?utf-8?B?T3BNcXI3aXBkQTI2ODBMamVwZ2RublpmS2J2Vks4aFRMTTVYVWNGeVFwUDM1?=
 =?utf-8?B?SUVQR2NDU09CblNMZVZsZkNJNnowTHZpdFQ2aUtrdkI1aUxBVWg5QzdmSHZk?=
 =?utf-8?B?dWo0L2NOWGNYNktGNkNaTHRZdTNXdzFkd3VBT2tDQmhGL0tDbG1QNjQ4UHNN?=
 =?utf-8?B?d214dEhHbjVFTVd5RjJRS0JLa0dwRXpibloxemdqS2FwWUdGRm5vMTNGV092?=
 =?utf-8?B?dkRad3ZIQjFNQ0NoYnM3OGRsZWpWNEtRWGRVRmhWcmRMV2tWc3RqbWpYRUdE?=
 =?utf-8?B?WGxjcU1TaFl2R0JaOFZObmM1MmZ2eTJLcm0vY1lxVXdHMXhTZXRMVFQ4Y0pt?=
 =?utf-8?B?WExyRXlRcUFRbmFSV0R5Z2lIN3R4b3luSVd3cHJBMXlvSklFaExHYnJnTzN5?=
 =?utf-8?B?L3pyZlJPeUhYdjY4RllockpEOEM0eFI3aU9TOUJIM2FiWjBIbEc4RU83ZTNS?=
 =?utf-8?B?dDdHNm9ZdmZoOGtUay85blZZZGhWSnBUSzllZzk0Z2Z3Q2pGek5RdFRyejJB?=
 =?utf-8?B?clJCdU1CNjNxVDNmTURobEtLVjRiWnpmMjltVjZrWnNhRzNxM2czUkt4Ui9U?=
 =?utf-8?B?MDhiZ0daOWJsUzAwMEpMaS8yM3FpOXRxNEpqaVZjZmtmd1FDaDlnSWt6cmlq?=
 =?utf-8?B?ejIrS1lHZzByTUhKbVRVZ2x1VTFIaWFhdlFmSm1yOXRoZnJqODJZazZ4dWxW?=
 =?utf-8?B?M0NpSWlvOEZTMnQyemxpcUowRElWbElLekdvcVZKZDRjdkM5ZVhxZlpQTFZQ?=
 =?utf-8?B?cTFiZVNFNWI1Uyt1MEhmN20rWFAwMmtiYUtQd0QzcVdBOXpPSnVYZ3A1TzZE?=
 =?utf-8?B?eXozMmVEaUR2dVQ3NGxFdlNMN2NrYlpMclRhWmpvQ0RYQk01YnV5YkJ0UTBC?=
 =?utf-8?B?UDdoRUFYVzZvTUt6UUFKUkpraWQ5c2hXbjh2ZmRhTlJTRUFNbTVMRlpUMG9z?=
 =?utf-8?B?VmM1UEZwWDBUTmgzaHhwV09lcXZKNlNYTUNIOUp5SFJvbjg1TTNNTElyTXVV?=
 =?utf-8?B?TnQvT3RSYjRKQ2RrbzltdkJ2ejMzdkF3YmQ1Z1gxdURNY1JNeTVGQmdRTzdT?=
 =?utf-8?B?TmsxSDVhVkp5eHYzZHJPK01EQi9aNFRhUjBBc2JHdmY1cVMzMk9YYTc4clAx?=
 =?utf-8?B?ZkhIVCtnV0lnZ0NBa1oyeEFmVE5YaDFCbEFnM0gzbzhTWXFKTDQzQmNyeWpN?=
 =?utf-8?B?a0x4YndRTDRPQy9tOXBYWDdRU3VVYXRPWFV5Q28vNW9mcWFib1FBeTBhSm0w?=
 =?utf-8?B?SFNNN2J0QlBWL1k4MjlnbDNCVUlwcXFrZC9RMmZwZGVibnVscEdjRXdwWUNu?=
 =?utf-8?B?UzFUQjV0OGFTQ2VYdlNMbTUxb3lUK09kekd6RERIYmdFZTU2NVpubnRBTG8y?=
 =?utf-8?Q?YDEdHvU723PZpK9sCjA+GqA17?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8416422e-ce29-47cc-8396-08dd1da773ab
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9550.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 07:58:39.5223
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oiQLQA3HRIbLPUomOSE9cz2+PBtzqUJ10Y0dgjgYb+gqxe9K0kNbi7akpZLAxJfnYjS5aPgLgnve/OLgv3mMOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10361

Add support for reading multiple registers in DEV_TO_MEM transactions and
for writing multiple registers in MEM_TO_DEV transactions.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
Co-developed-by: Alexandru-Catalin Ionita <alexandru-catalin.ionita@nxp.com>
Signed-off-by: Alexandru-Catalin Ionita <alexandru-catalin.ionita@nxp.com>
Signed-off-by: Larisa Grigore <larisa.grigore@oss.nxp.com>
---
 drivers/dma/fsl-edma-common.c | 36 ++++++++++++++++++++++++++---------
 1 file changed, 27 insertions(+), 9 deletions(-)

diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
index d364514f21be..e70f7aa9bc68 100644
--- a/drivers/dma/fsl-edma-common.c
+++ b/drivers/dma/fsl-edma-common.c
@@ -496,8 +496,8 @@ void fsl_edma_fill_tcd(struct fsl_edma_chan *fsl_chan,
 		       bool disable_req, bool enable_sg)
 {
 	struct dma_slave_config *cfg = &fsl_chan->cfg;
+	u32 burst = 0;
 	u16 csr = 0;
-	u32 burst;
 
 	/*
 	 * eDMA hardware SGs require the TCDs to be stored in little
@@ -512,16 +512,30 @@ void fsl_edma_fill_tcd(struct fsl_edma_chan *fsl_chan,
 
 	fsl_edma_set_tcd_to_le(fsl_chan, tcd, soff, soff);
 
-	if (fsl_chan->is_multi_fifo) {
-		/* set mloff to support multiple fifo */
-		burst = cfg->direction == DMA_DEV_TO_MEM ?
-				cfg->src_maxburst : cfg->dst_maxburst;
-		nbytes |= EDMA_V3_TCD_NBYTES_MLOFF(-(burst * 4));
-		/* enable DMLOE/SMLOE */
-		if (cfg->direction == DMA_MEM_TO_DEV) {
+	/* If we expect to have either multi_fifo or a port window size,
+	 * we will use minor loop offset, meaning bits 29-10 will be used for
+	 * address offset, while bits 9-0 will be used to tell DMA how much
+	 * data to read from addr.
+	 * If we don't have either of those, will use a major loop reading from addr
+	 * nbytes (29bits).
+	 */
+	if (cfg->direction == DMA_MEM_TO_DEV) {
+		if (fsl_chan->is_multi_fifo)
+			burst = cfg->dst_maxburst * 4;
+		if (cfg->dst_port_window_size)
+			burst = cfg->dst_port_window_size * cfg->dst_addr_width;
+		if (burst) {
+			nbytes |= EDMA_V3_TCD_NBYTES_MLOFF(-burst);
 			nbytes |= EDMA_V3_TCD_NBYTES_DMLOE;
 			nbytes &= ~EDMA_V3_TCD_NBYTES_SMLOE;
-		} else {
+		}
+	} else {
+		if (fsl_chan->is_multi_fifo)
+			burst = cfg->src_maxburst * 4;
+		if (cfg->src_port_window_size)
+			burst = cfg->src_port_window_size * cfg->src_addr_width;
+		if (burst) {
+			nbytes |= EDMA_V3_TCD_NBYTES_MLOFF(-burst);
 			nbytes |= EDMA_V3_TCD_NBYTES_SMLOE;
 			nbytes &= ~EDMA_V3_TCD_NBYTES_DMLOE;
 		}
@@ -639,11 +653,15 @@ struct dma_async_tx_descriptor *fsl_edma_prep_dma_cyclic(
 			dst_addr = fsl_chan->dma_dev_addr;
 			soff = fsl_chan->cfg.dst_addr_width;
 			doff = fsl_chan->is_multi_fifo ? 4 : 0;
+			if (fsl_chan->cfg.dst_port_window_size)
+				doff = fsl_chan->cfg.dst_addr_width;
 		} else if (direction == DMA_DEV_TO_MEM) {
 			src_addr = fsl_chan->dma_dev_addr;
 			dst_addr = dma_buf_next;
 			soff = fsl_chan->is_multi_fifo ? 4 : 0;
 			doff = fsl_chan->cfg.src_addr_width;
+			if (fsl_chan->cfg.src_port_window_size)
+				soff = fsl_chan->cfg.src_addr_width;
 		} else {
 			/* DMA_DEV_TO_DEV */
 			src_addr = fsl_chan->cfg.src_addr;
-- 
2.47.0


