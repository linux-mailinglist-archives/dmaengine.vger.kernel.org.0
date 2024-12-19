Return-Path: <dmaengine+bounces-4033-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D1B59F7848
	for <lists+dmaengine@lfdr.de>; Thu, 19 Dec 2024 10:23:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1BE71613C2
	for <lists+dmaengine@lfdr.de>; Thu, 19 Dec 2024 09:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2D30223711;
	Thu, 19 Dec 2024 09:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="FBbsCSOT"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2052.outbound.protection.outlook.com [40.107.22.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B5A2236F2;
	Thu, 19 Dec 2024 09:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734600068; cv=fail; b=clNCyd3B0gDhS2dEp8NJtDpirexU8fu7plqgCu9J4RjWjm5EwMSKXGejXveJAdGNxLJ1ry7zQPOFU+xaz30Wynpp5YRjBnTJ/WXQIt/9enN59xa4XKMZPx+FLpG++kr8BA4l5Xe6j4eQ4pYdLx8yWzIbvFAfqrvtZpwKmzQydSI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734600068; c=relaxed/simple;
	bh=WsjL2uE4Orn3phprwnKiCUlkr6URGo8bzo7MVbUmtbo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pX57vH4oLRA/TPwxDxM4GVT2fLqhLbwJ4DXWx11jI2AXAYEGEDIbq23Q5PAnxNhNGiVtEgtG6g/rsAdXckpVHWCCAxc56/ofXjFSLYiiivh9/63QvN9K79IoXoJ5YnKraa4OjfygzAlXcnOcS5wkfPDdttz7+lvQIQv3aRR0HVw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=FBbsCSOT; arc=fail smtp.client-ip=40.107.22.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bRfYF3009lpPW0f+3oGEI760f1/o/u0ox730oMVi0ddKzU5FEVUNsFsSiAXKlQb99xuvWCkOx2OLMV9Rcf4qhRXDITTaRV5aIYgAT3HRYqhRLcdLvm2PV7RL8dgwjjqD7NaMeQPPB3F32b7Qy9Q3EjwUYmje30cjuF/QjGL2IW0K0O923r62iW6ZEO1jMeId39IsqU0dbLtqhbgZ/ZwVec5yOsu54beOulq7McUUr3y8o8MSs8gL6dtI4Z5lovcxDEl4nw+7KzQ9u9EsY+mljMkLa0tHM54IoTsyK/zdEwJc6givxwTaeeuUd5z192y2u5o/IzUzKRLKuYCLZwYOJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UOYniJli5Pkhka8qYxssSA4O6lfU0+qc3aDbK4L90oE=;
 b=octGXhkHP6Yuqz2/KSFGVR3bLOgm/uwLvn1GQUYIN82DvQKLwDjSU+ZVJSHcMONwkcAYXdCefGxvvt329X5nNXONr2PlyJlvLeTlHm2fEWMDbk3RU7EKWdiIR3J60sv74G9CooJDglYcdSB6+BIqyUA+AgI+2FaX+EkKOoDkrFRWbYnr6SY+T7UMK+gp+mHQa9DVXMTb6NSymDv7fcbwLlav8sU6VN9f/jpmcxXTY7mck5KTIkTVfcy3WcLKr5hiqHCkcufkJUTwcQWorNJxEF6jUmG9BwrKg3dIWUDlQr7WHvlSc2zDUqtxT+d0MXLqMN9ibwP4EQ+ozzF/6pV7Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UOYniJli5Pkhka8qYxssSA4O6lfU0+qc3aDbK4L90oE=;
 b=FBbsCSOT61MJxJOoTGcH1Ek0+R93CrolAcD2FRJyGi0EkMzN8xAiev/82nXv5Zj1gkdSqoklhK0YT693gjVJTeysqedgYddoMpwJUuSKKqSuzQi3cDi+EC/6amsK9uC9x1TqrzFPD2KacuTCyFkSGYXypC0bSkZjXfJek6Xo7MzDIqTsB6G5B0VTz8MNj9ZgByhuAhh+g8GECINF7A9qriDJRX1V12Uf6OhwdVUbkKIFsEdSN0G9rltoIou1aO6WeEsaXrgW6DxBYKa8khgBMDfOLJ3K+t2ZWZGGj5XRqkBzN+LPry4vcwOm10Tk6ql4mSl2Eiqo9e7ga8mDlb77Fw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AS4PR04MB9550.eurprd04.prod.outlook.com (2603:10a6:20b:4f9::17)
 by VI1PR04MB9834.eurprd04.prod.outlook.com (2603:10a6:800:1d8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.14; Thu, 19 Dec
 2024 09:20:58 +0000
Received: from AS4PR04MB9550.eurprd04.prod.outlook.com
 ([fe80::e28d:10f8:289:baf7]) by AS4PR04MB9550.eurprd04.prod.outlook.com
 ([fe80::e28d:10f8:289:baf7%6]) with mapi id 15.20.8251.015; Thu, 19 Dec 2024
 09:20:58 +0000
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
Subject: [PATCH v2 3/6] dt-bindings: dma: fsl-edma: add nxp,s32g2-edma compatible string
Date: Thu, 19 Dec 2024 11:18:43 +0200
Message-ID: <20241219092045.1161182-4-larisa.grigore@oss.nxp.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241219092045.1161182-1-larisa.grigore@oss.nxp.com>
References: <20241219092045.1161182-1-larisa.grigore@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR02CA0216.eurprd02.prod.outlook.com
 (2603:10a6:20b:28f::23) To AS4PR04MB9550.eurprd04.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 74fc706e-0118-4015-3f05-08dd200e71fa
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YjIzSVl5RmpGeDRnc1FqWkVEWlBpaE9DVnpIaytoaWFNZFFmSzEyaUtjaHhk?=
 =?utf-8?B?MWpPTXlEbkNSTGdEN3loSUprQ0R4RjNqWnBGWlJRblpDcU1xR2JsYVlrSlhR?=
 =?utf-8?B?YVZmd2UwUTF0Vlg2L1gvQjk2WmplQ2V0SUZyVTRNcERWZXowMTBjMXp5eC9m?=
 =?utf-8?B?V0ZtNWdBdjhMVzZOc01OclR0Ykh3Z3dwU0hqZnFQcWVOUWF2bDl4QTZYU3ZW?=
 =?utf-8?B?WWtjT1Fyamxmczl2SW9kV0dCY29vQlhRNXRIZGZzN0tDSzBrd0l6VXlMVnNO?=
 =?utf-8?B?VWZKZitIcyt0VVk3c2t0SDlrRWcyeDR2UjU3V2syUS9SaHRWMHhqeGJvbXFG?=
 =?utf-8?B?NGQrdFFxeHZmdm9HenBFKzhDM0VseTZmM1E5TFp2c3pNTWxjbkVaUkpuUWRS?=
 =?utf-8?B?eUV2b2lYUUM3MDNiUXBhVW9IbkdnNVNVLzNUcTFIaDlZd2wzRUh6N0kxMW51?=
 =?utf-8?B?MTJYbWRvSHBOalY1KzF0dHdsaXZRZXNRUHlUenlGRUQxalFkSGErcUo4Uzg4?=
 =?utf-8?B?T1lHMis1bVp6TTZxem41eFFSUWpFWXdSbmFXZWltd3ZDcjZ0YzBuN25KaFpT?=
 =?utf-8?B?K0paNzhzYThZQjlTUTlYcXM2bXZhQnFEek1qRDlUOHdsQWhRRFVLeVQ5cit2?=
 =?utf-8?B?T1ZLREJ6UzRQZno2a2hyOWk5Z0VRRFk3c2FER3R4bWJ6UkNQVEpTaDZUbGdN?=
 =?utf-8?B?YVFjeGhGRFhrUzNFMEVvZE1mamZpd3l5enlSZjZQSHozV0o0Um90eFVxQzBL?=
 =?utf-8?B?WkRFMzBjL0hUaFh6bVFOQVFDWFBEN1lHSDJlR2lhdnVxUGVldW5oYnJiNXBl?=
 =?utf-8?B?L3B5Y0J6OHNDRDEwMm1hdXE2QnMwa2VvSml5VElOTjJ3YnVGejJ3UW0yaU1x?=
 =?utf-8?B?Y1ZzYUpPNlFuUnY5TjA0WHVJYXJwTGd0bGk3aUwrRkVPV21QVFFTQzJ2V0pW?=
 =?utf-8?B?VStQcXFRR3JCTHhLU2pwUzVyZVQ2SitleWFRQ0Z1SFJIV1l2RG80ZWU1eGl6?=
 =?utf-8?B?RDJDNThYMFFhUk41dTdScnJZaVlxc1ZWdW1WQ28zeHpSNGpjTDFhUEFkb3pp?=
 =?utf-8?B?MWJ4MENVZ0dEVkZMd2k1bHlSUWZSOEl0djVMazhFdCtjY0ZseWczWTA2TTBF?=
 =?utf-8?B?ejBiZ3doMXhFSERvVjBDWkVXVHdudEZxYjBHMmZQN2FvVm1Pb3ZjN3RkUHda?=
 =?utf-8?B?NUxtcTBacFJvQlQ2RC96N3NrUXZMWFh6RitjYWdzRG42cXNqbVZZeFpUU0RI?=
 =?utf-8?B?RFRBL1IwQ2dxakhCT2lQaEhGQlZKaS9Bc1N3c0ZFelRNeTBHYmx1SGxiTnUz?=
 =?utf-8?B?dkFPd1N4U0YwWFpsM3NwYjNDWUlHRzgxTTBrZ3BObEIvcjlYaDV2azNDaStC?=
 =?utf-8?B?NlhHV1RrUDdoSnVkdUVmMExKYjBNckpTT2JOaGZjaWtyS2VmVW1ubFJrNXZZ?=
 =?utf-8?B?Nm42OGxlaFAvMmorTkV0NW5CNEo2dVZxUnZBajg1UWhDbGE4eUoxdXg0bHlp?=
 =?utf-8?B?dWJ6WkRJa2R6R1IyT1pMUng0T01Ub3BvUjM3bHdnWWs5aDVQYkxaTCtpSmw5?=
 =?utf-8?B?UUdhcjhJVEJqMWVEd1JrUGR6TmhuZlJlSzhkYVprS1QwTlkvY2VSYm9HLzYr?=
 =?utf-8?B?YWZFcy9TQW85bXlRRjRId1kxMzRENERPcVkvS3NvelZGcG4xblpKVjU1QnAx?=
 =?utf-8?B?SVo4SjhSRlI0ZmNDOE1LZDl1YUdJTzQyMm11cXJwUGtTa2VzeVpOMy9ZNjV2?=
 =?utf-8?B?UklkODErUGFaOHdnbkJ5VDBYZVNqNUsyUzJZaml6d1dZR0dFOEtKQzBock5m?=
 =?utf-8?B?azk5QjJiekpLV3dmWFpLR2lNSGwrc0xZeXRVUG1kNWg3WWV2bGdvUXRiK0ts?=
 =?utf-8?Q?VYi6kD6w2Vvd0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9550.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZjZ0RThSL3k1bERZaTJTRVhYZDJibnpkczdQVmp3UnBmSXFIR2oxbk41REhw?=
 =?utf-8?B?VGpLK2ZiN2p1SjZBOVNNZG9RTWIxc0lscnFRdUMxbFBuWUpzNWhvS0ZEWFVK?=
 =?utf-8?B?Tmtuei94QUJNd2VUMlRwNk1tU3A0M1JSMXZJWkJSeWxSdTBkV09ON2lwUExp?=
 =?utf-8?B?QUdxSDNtejlCOU43VzZHMDBXVE1DdFU3bG43b1pYVnVqR3p5NlJYZGltbzRQ?=
 =?utf-8?B?VE5Ca1hEcFJ0czAyMkJtMmZDSEwzVDRIdnd1V08xRHVnOGRuQmk2YTQ0OWVm?=
 =?utf-8?B?NGI4S1VNcUZNUzI2aFg3dVNwanEvbVF6elVkNUZpR29VdDk2bFpYQkV5cCtO?=
 =?utf-8?B?ZVMrVG0vNm5tWTA3bVVGQjIyczNQSnYyOUtXOEVWYkN3UTdCR1N2a3FkSXN2?=
 =?utf-8?B?eUZBY0l4T0FlNU44T0FxK2hpMWhEZDlCYUpWbFJhdWovU3hlUWRiczNaMUVh?=
 =?utf-8?B?dGt2bityWkVWRzNNY01nTGtMK3FWeWNMVy92djRuOW5HdHN4TnBNQ3JtQzF3?=
 =?utf-8?B?NWN3UzdQcWJGaGhpdnkxZEdZR1d3cnJKSVlPNWhuUEpWSlI4OGZSZGNXTytG?=
 =?utf-8?B?eUpwNmtJbzRtZ21nVUFJMkY4OE95Zjh0cWJiTVFtSks3eWc1dnhwYkQ1WFV6?=
 =?utf-8?B?S1ZZc1ozdFQyNnMrN1d3b1BpczV5amVYam9CTnFGOHFBNnBGM3BCV0NPRjkw?=
 =?utf-8?B?cXpPcERpRnhoWEo5TGtoSWNjTkxqV085dHNqVm1NYVplY0t4eU1WWUIxazVI?=
 =?utf-8?B?MDhJN2ZlbGNCNG84U2FHZjY4ZSs0dGs3Z1lodUVtL1FVZlZCaWcwT2lNUGxn?=
 =?utf-8?B?RkdheTMzY0V3VFphNmpxQ1JlYzhkN2x1TGk0c0RVc3NEcVZhOGdld0xnYTlY?=
 =?utf-8?B?QjQ3TXhWR1ZMMVlkSzFXQjdEcHVISHc5bXdXVTE0a0Z3dGYzS0U3bzl1bEVv?=
 =?utf-8?B?cUVRRTRkeVJlSTNBR0R3eTAwbFZkOHhJWVZVUklzejdLOTdZOTVaV1AyY2Nn?=
 =?utf-8?B?U21BVGdSMFRuUE5Yc1ZxQVJ5L0tmMXJVN2JQOEFhRWtUUDZFcW45MGoxeXF2?=
 =?utf-8?B?VldCdW9TT2pvbTQzNDFSN0t0dXN4OCtwYTRXMDgrbXZxYUVJNlF5Q3pQQjZj?=
 =?utf-8?B?SUt6T3JvWGd3M0ViQXVmZEJCOVdzak5mQ2piMHNHVUtJZmI4VS96QmNYRzVr?=
 =?utf-8?B?Y2tsVmM2Snh4U01HQjNWcE5vNENuVm44NGI4MWpNV2RMamdIdXlIWm1ocHBT?=
 =?utf-8?B?WEh3SDRNcmxENnZON0ZSZC8rcVJFZmZyRC82R0JESldSSjhPT0w2SGxNWUtM?=
 =?utf-8?B?enlmbmpFQkxmd1VIaEhwMCtRUDgzYzN4ZDRrV3hoQzg2a1hNekpiTHU4cGhQ?=
 =?utf-8?B?T3VLejl1ejRwN3FDaXBSZUFEc0lsYzhIRmM4RTJ0U3BoU0NGVHlVeUt6R2Rp?=
 =?utf-8?B?Zlg5U2lpVE8va2NxcWhmVTROcHVhdHQ1QW1uVXpOWnpwKzRINitoUTE0WEI2?=
 =?utf-8?B?bUkvSDdtQkJyNWR2L05PazliU0ExdEduWEhIWFBrdzlwOFRUcnc2V1lWUjdF?=
 =?utf-8?B?aW1SSnRMZHQ5d3RGZndiaUxNQ2Vjb1ZFRGxxd3JJeHZ5U3RyNFJlWWgvT3Iw?=
 =?utf-8?B?eXkwTjBzRTdFV2VrT1BlcTdIVlNNQk5ZVjlWMWtNT1Z0anJKbmJ1SmdWc3JJ?=
 =?utf-8?B?RW9YNVFrOWRFRnYwSmcyV1F4RUZuMG1KV00rS2FvSWFXQlduZVppNUVaYmx5?=
 =?utf-8?B?NjUzYjNBd0h6bWdFNlAvZTVJR1p1dk9OZERKTE0rSGV6MEhuM0ZZcjJHbDRK?=
 =?utf-8?B?YTlGTVBoc0FlaDVyRk5hM0Q3eHVUcHRrVjhkR1VhZkVLVGo4enhsa1RSVHRB?=
 =?utf-8?B?T0lyaDc3RzhaWkoyV0FON0VIUVQ0TUV4b2hqZHN3VkM3VDNzVXEwbkt6MUM1?=
 =?utf-8?B?ckdISzJZaUdOTWdUNVQ2aGFseVZXOURPdXN1d0szQnREMjZKeXk4dm1hSi8z?=
 =?utf-8?B?bVQ5Y3p2TjVndUVCYmlCM2JrcTk4eVU2anNvbXpGblZPNS9nZi9Nc3RTWFh0?=
 =?utf-8?B?WVdPdEdveEJsQUlhWm9LazlqSDNJcXowQ3BKdzdKSFFOcW5YSXg4MnFneWxK?=
 =?utf-8?Q?qgDLDTQyZ/2c6a8idbeROKzPU?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74fc706e-0118-4015-3f05-08dd200e71fa
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9550.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2024 09:20:58.2748
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ytloR+1KeQkUlPafCdyGSLEvapYKANTIgg0PQzi4A7cbr3wa6hQEprFNcTNA4GcK97Uv981WS7rq/VsMZQOqxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9834

Introduce the compatible strings 'nxp,s32g2-edma' and 'nxp,s32g3-edma' to
enable the support for the eDMAv3 present on S32G2/S32G3 platforms.

The S32G2/S32G3 eDMA architecture features 32 DMA channels. Each of the
two eDMA instances is integrated with two DMAMUX blocks.

Another particularity of these SoCs is that the interrupts are shared
between channels in the following way:
- DMA Channels 0-15 share the 'tx-0-15' interrupt
- DMA Channels 16-31 share the 'tx-16-31' interrupt
- all channels share the 'err' interrupt

Signed-off-by: Larisa Grigore <larisa.grigore@oss.nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 .../devicetree/bindings/dma/fsl,edma.yaml     | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/fsl,edma.yaml b/Documentation/devicetree/bindings/dma/fsl,edma.yaml
index d54140f18d34..4f925469533e 100644
--- a/Documentation/devicetree/bindings/dma/fsl,edma.yaml
+++ b/Documentation/devicetree/bindings/dma/fsl,edma.yaml
@@ -26,9 +26,13 @@ properties:
           - fsl,imx93-edma3
           - fsl,imx93-edma4
           - fsl,imx95-edma5
+          - nxp,s32g2-edma
       - items:
           - const: fsl,ls1028a-edma
           - const: fsl,vf610-edma
+      - items:
+          - const: nxp,s32g3-edma
+          - const: nxp,s32g2-edma
 
   reg:
     minItems: 1
@@ -221,6 +225,36 @@ allOf:
       properties:
         power-domains: false
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: nxp,s32g2-edma
+    then:
+      properties:
+        clocks:
+          minItems: 2
+          maxItems: 2
+        clock-names:
+          items:
+            - const: dmamux0
+            - const: dmamux1
+        interrupts:
+          minItems: 3
+          maxItems: 3
+        interrupt-names:
+          items:
+            - const: tx-0-15
+            - const: tx-16-31
+            - const: err
+        reg:
+          minItems: 3
+          maxItems: 3
+        "#dma-cells":
+          const: 2
+        dma-channels:
+          const: 32
+
 unevaluatedProperties: false
 
 examples:
-- 
2.47.0


