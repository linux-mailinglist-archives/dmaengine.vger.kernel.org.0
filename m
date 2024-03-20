Return-Path: <dmaengine+bounces-1455-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13CFC8817FD
	for <lists+dmaengine@lfdr.de>; Wed, 20 Mar 2024 20:40:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 663EFB20D08
	for <lists+dmaengine@lfdr.de>; Wed, 20 Mar 2024 19:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F24085650;
	Wed, 20 Mar 2024 19:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="HqkCYBrz"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2085.outbound.protection.outlook.com [40.107.105.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462C86A348;
	Wed, 20 Mar 2024 19:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710963598; cv=fail; b=oADjbwOvl6f3XK1SAMQLl/awX3QbuPqYIA6tZ8JD5ys1FxGMWB+UFcxWZwy3XJUCIdxZ7kETE/JoR3RQ6wq25Ax+7kKHsnXMZK4tiCOxBkGFc/LU5uQCsiY/6YJof3n9nACT5TYweJqw8UxYWHODZhOAQn09+qmsrPPv6JiBk1Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710963598; c=relaxed/simple;
	bh=nqEZmsoTJgvbC/BiKVxws5nME5nmhJSAj6NYePbtTaM=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=Mieq1LWOgvRBMXuVOViy5Vzv1HQNsqcUeRd3xnus47UwRaTO1ROByN8S1hdlGzSRRRRkmivqAPTQgLKXGspwIIGL0bVt/BDcYpYHXG/WFZFpkdJztGI1JZN9S1xwDGyexHRd6sfHtw7P+fO6QPntxg/+LA3hIgemAJxN4wiuzt8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=HqkCYBrz; arc=fail smtp.client-ip=40.107.105.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TfYVl/psyEADLRqiK4pKcviabRs8eXow0XWUpek2+DcZKGNZ/cZk4HcmEycWizH5yuBwHVBJBj249i0iyRa+iVsWRT+BhaYXDq6rjIfkZQj4cTAeilFbU4mMJ4ktNnYksEY3vy9w0aqZTIHPuVDRYnJhbyl9ugVoLEN6PJ2s/J9J5Cf/aGg7L35hHqy82+4cy2YvTgeQKEndwdv2gbK4S6pSf9e20JR/EQz4uFppwYob6/VcXJKPWF0WEMsEEEZ0K/ZD5FdtfDG+NbY2SIu9pPDs4vev20ZnOuQGIe6uL98kSplwtHMszRavoXupLkEXgOEZ52YNq/tXRCsK7UIPFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XSKelCysyfllOWLixp/XcTtoIo5A+PDC03HkVb61vto=;
 b=j7u1mFsMYQqGdqddOdx4d2nT8P72g5zMd0k3aWvxDM3rxancLiI5b62QAWIM8yDvCxCJIem+Fx8Qaev/R6TNxk0frXeT+kSOpqQk5Uq+dCgzJdaFnbpjwQXWRf6IxRLrzuS8+P647r02+j2eQBAsGsKikFgre5UYtJA6ietnl4fqPN2/L6g3D8M71/K/oVIhaUhTbpGWGTsA2PXYGbBu7lrAD+8uNA6lCrL6i168TBigIIebmpOCQa9jfRcY1ZCjqVQ4a2Fk4hXRHf6GgK/8CGHk3ZRA6/fa272dktRvRXH593AcPTD7KDetXrPyPdb7mIo2qnbmCPZWGI+/cmXUNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XSKelCysyfllOWLixp/XcTtoIo5A+PDC03HkVb61vto=;
 b=HqkCYBrz+xrdkvcJsCLYNjcZ0CO42uvppiPzILvdK2FQKckRm7D2rbeAh/g4DuiVr+xz+a9T7lBdffm5297R4Vx9i9atqgsVRaAlqJuDB1dswRbtgPlPF7Cis5silmRgjjo42XINs1NY9V/4oWfJIRPlKPG/BxVhtAzMvsXT/4I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB9326.eurprd04.prod.outlook.com (2603:10a6:102:2b8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.31; Wed, 20 Mar
 2024 19:39:51 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7386.025; Wed, 20 Mar 2024
 19:39:51 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH 0/4] dmaengine: fsl-dpaa2-qdma: Update DPDMAI to support MC
 firmware 10.1x.x
Date: Wed, 20 Mar 2024 15:39:18 -0400
Message-Id: <20240320-dpaa2-v1-0-eb56e47c94ec@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGY7+2UC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDYyMD3ZSCxEQjXYMUCzPDZCNzU7OUVCWg2oKi1LTMCrA50bG1tQDF9+b
 2VwAAAA==
To: Vinod Koul <vkoul@kernel.org>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1710963589; l=1014;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=nqEZmsoTJgvbC/BiKVxws5nME5nmhJSAj6NYePbtTaM=;
 b=WJpJVybr69XW1VeJ6NmpDCoQpRP9vSx51kv9zWsBoHzmJprmfgQnulL2+2zVXTWgO9XUGqskt
 SxkZRj4Vfe1DAu9o5PQ2Pmh1xVjuMKOv5dsUuzJWDtoSbsczpDfFWNa
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR05CA0058.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::33) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB9326:EE_
X-MS-Office365-Filtering-Correlation-Id: 24b43204-e2d9-485d-a36d-08dc49158278
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4pS0tg5FLMW/dvwMoEf96gJByn7DJioF6ByUb3+V6sfBzHQgx9Se6m3JX1mOdaH4EZt1XpnJG+Pb1dv8fQL3FWf+0BYsIEAork41MPSJH/iRfrxvJj1uSBZqwhoGm52hlW6u4ymklLifaLXaBhUJ/Ph/D/NZla2YU7anl13vtu/yeGyqr33H1kDOeqdNmQllQ74wsycGiiladksD3XrjLBGVC7TjEZ8Md4PJKBRBec7/rkWDJZeKBoiIjO6AM+u1QIYh3ak6JpC4nPSBpQacCHCyl6pm/xY4US6J7Fvx2arshHcnQHPUxGOsF3PFzjpd1Xb/7jAjsraUVcMkNF4eNMF4nU9ouA1s+w1o40QoQfr88e1+cIg4Dmff5k/MB6gEex6/7bzvIYsvkDqAjlmVKRCJBpO/k+QGe1PExzZZf8OQdazgd8eJnga/D44Dar4vO21ArO0nZSn1vIi9Mt4FIwnbPN0vnIhOmc4AeB6VIxifv+rVhUFwzd5g0QrqeO/frhr0XZUct6gL4v93c83ul+G8lmkgoFKnidf3IpuSWS6QlW+kQXgFiOcRDckHW1kTg/qFoWC9MSSPPpIiHEcloqxOKipySRX5pB+jMOkiq3tQ/42+DIHarM6fNzSn6oFxMoQ7WVaRUENiT/aV26rqT8t3l3n9L3H0nmwXRE28/rHn/qvLYZ6cBhv2Ey/G3Ab6WCOTonww4QPs14G1zdzcwQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(1800799015)(376005)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SlJIUWF3ZTJlcFdUZWZZY3VOQmw5NXdibUFmcDlhZ3ZHZExoZmhjL1pBR25k?=
 =?utf-8?B?ODgxOUdTNlkrTDJKUTV2TWE5bUV6a1BldERIMkxWVXVUNGNOeERqZTVtZ1gv?=
 =?utf-8?B?YUxQNVRqZVhzWGNjMlBoSXg2cEhSVk0vb1IzUU94dzdWYW1tbVVMQTE3aTVB?=
 =?utf-8?B?NnVoZU04WEdqaEMvSUgwdlVxcFdBcDhZSS9CTXlNYlczanFRNjh1QmtWNy9H?=
 =?utf-8?B?bklTZzJldnVtbUhYWVZ4azhCSzRCYjBhcEs5SVA4eXN3UlZUT0tNWGg3dTVP?=
 =?utf-8?B?ekJuSE13Q1JseCtvaWVybzRlbWhHSUdpNEZxQXNsNWpnSUF3aEwyRWFVU01F?=
 =?utf-8?B?RnVIalhxalJMWXkweUw5RWZTbnJUc2JMU3BBWEZkYm9pVlVndXE4aVpYa05h?=
 =?utf-8?B?Qm1hbmpVckJqT2RXZDIxRDk4NHh3bllubFNYaU9SM0RDaXFKNW5DVC9RbllI?=
 =?utf-8?B?T0VjVFFVbk5vendWUGZjT25GZkZ5YlJ1N0pnSkJielgwOXgwQThBQjAwaTRW?=
 =?utf-8?B?eXZCaXFCdHJoS0FqcGJuY2ZnMGE3dFozcTZiM3hoREV4YmFiQmxlTW1PWHQv?=
 =?utf-8?B?TWtpQ0RWanZ0MDRBSzhRMTdLc2VEUFRicUt0cDFxaFh6N250ZUxvY00zK0dk?=
 =?utf-8?B?aWpjaEhPcTZEMGxZa2FkTnN5VHQwamo3aytVSWJTOVRJR09LV1JFdTM2VFdS?=
 =?utf-8?B?VDNPdFZzdlBnRWgxS21Camd3WEt2d2tWVlNTc3ZJSkVPWVF1S1NSMTFpS0cv?=
 =?utf-8?B?dnI2RXZ2NUYxVHViMDZmWllXVTQ2UzMwY0lwVDJnTTllZUlTcTJqQ2NZQllK?=
 =?utf-8?B?bGpRb3FoOFFFRmlCTFZ1ZnNyaWRhWkNLSUFHVlArcEtva05VbTczekMzbDFv?=
 =?utf-8?B?L2J5KytncCs2QldKRUZNcDcxcDNndHRUbFF3WWYwYy8rY3M0VGpwZEJmeGtn?=
 =?utf-8?B?MURlVGNkb0hPbUR3WkZacEVKV1FXRkFjU01hSFJoMWRBOU0wOEkzMlVhK292?=
 =?utf-8?B?UVJYeTJHa2NXbWZFK2ZvMmhnbmNLZTIvVks1VlJZYWJUZmVYR3JpVi9IYktw?=
 =?utf-8?B?cG1odzRGK3ZVOWxpVjZhU2FCazA0c2NuSmp0cDF4WFZGc0JsQ3hRd1BLaWJY?=
 =?utf-8?B?dFlhcEhiOWZqVzFidndqSU4xQVorRTYwL3IxeUpTZWR3UDBnQ0Jid1NQcDRs?=
 =?utf-8?B?bkVlVDd6Z2NNUUsvc1NCS3dUOUNqL3BnUStENjFESXlXSVZGUkZpNDVwSnhx?=
 =?utf-8?B?b3lqbUpYam1xZ1VMRkNzSTdYdUxnaU1zeGMvN2k5WHlWRWpYRmtGa0N3Wmxz?=
 =?utf-8?B?cCtkN2JadjYvWUpXVWZka21CejV3cldwVW9ldkNIekEyeVR2UmgwbXZHUk9N?=
 =?utf-8?B?ZEUwY2RVYmxBR1NNR1dlQThiMDNmNWpORHJEb1Z3NTZpQ1hhdFNIUlJoMlcv?=
 =?utf-8?B?SzJUV240aGJoQldTS1VnY0dzbFpOL1dpQmpLWFJ5VnBsbU5QSWZFNWRvZnV0?=
 =?utf-8?B?R3NSSGorWjc0SUZ2RnEvR1ZVdExJMDVpM21tZHJUbHZCcjhDcS9PQlA0K1pS?=
 =?utf-8?B?Zi9vaXdqRy9PdW1WLzYwaTNIYUM3VjdjQWUvZUZONGIreEkrOWN5V0w0QXRh?=
 =?utf-8?B?SDUrZFZkMHpIaHhhTUNTdzBFREdJRzk0ZHdEUUE3cFdLSDNzb2RZS3BmZWtK?=
 =?utf-8?B?RFBpSFFBQ09rQ1VZSGlxeVM0RldLb0NPeFFxVm5ldW5qQ09HN1JSVUp6L0xM?=
 =?utf-8?B?UVladWVXeVdzYklXU0UwYlkwbVRWSjNKTi94V2FhaVRLOE9ucU9KaXNNT21N?=
 =?utf-8?B?bXAyUVZTdytleFVXeFErTzJVQTlYYUJqeldQTHdodll6eW9oSTJONWdmQ0FQ?=
 =?utf-8?B?L1ZnZitKa2RncWZIK0drazhGKzVRSEVmV2hJaW5xNU9qbG9Na09UREFteXRX?=
 =?utf-8?B?VExEcUd6c0pncDl4R2IxT3pUR3R1Q1JiUjVsd1Z4bXU2NmdpT05uUE5mVkNJ?=
 =?utf-8?B?dER1eWthRnRJNk5DYWZpYmg4S1dxTVVQRzhYbDExNkJydHRWNy9CaXQyOFll?=
 =?utf-8?B?aEd6YWxlckNIa3d0MGM0bmt0TDZhQ25EVEJ2ZEhsbFVkSHZHNnEzd2lNVWFl?=
 =?utf-8?Q?8aXU=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24b43204-e2d9-485d-a36d-08dc49158278
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 19:39:51.2759
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K+eSMxgBjcsZrhKR59A7tSUS+tgWAD9Ir+Hgk4A45I78ISQbcL0Q9T8hux1DE4WW21WobRULHiXYIeLQufNKjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9326

First do some clear up. Remove unused macro and function
Then update DPMAI API to support MC firmware 10.1x.x

To: Vinod Koul <vkoul@kernel.org>
Cc: dmaengine@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: imx@lists.linux.dev

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Frank Li (4):
      dmaengine: fsl-dpaa2-qdma: clean up unused macro
      dmaengine: fsl-dpaa2-qdma: Remove unused function dpdmai_create()
      dmaengine: fsl-dpaa2-qdma: Add dpdmai_cmd_open
      dmaengine: fsl-dpaa2-qdma: Update DPDMAI interfaces to version 3

 drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.c |  14 ++--
 drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.h |   5 +-
 drivers/dma/fsl-dpaa2-qdma/dpdmai.c     | 113 +++++++++++++-------------------
 drivers/dma/fsl-dpaa2-qdma/dpdmai.h     |  46 ++++++-------
 4 files changed, 77 insertions(+), 101 deletions(-)
---
base-commit: f4385d26e50bac22f8dba08727e9a32a0ab6b9ea
change-id: 20240320-dpaa2-0d861c2756de

Best regards,
---
Frank Li <Frank.Li@nxp.com>


