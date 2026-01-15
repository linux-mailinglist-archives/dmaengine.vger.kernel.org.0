Return-Path: <dmaengine+bounces-8278-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E963D25A2D
	for <lists+dmaengine@lfdr.de>; Thu, 15 Jan 2026 17:12:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 07C7730AF877
	for <lists+dmaengine@lfdr.de>; Thu, 15 Jan 2026 16:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C72963B8BDA;
	Thu, 15 Jan 2026 16:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="HWGwrmmi"
X-Original-To: dmaengine@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013033.outbound.protection.outlook.com [40.107.159.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00CE3B95FA;
	Thu, 15 Jan 2026 16:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768493242; cv=fail; b=p00KmILeRj7M1Z9jdulTEbYEPiny19F3bd6pDkgb7DpHEKFndescWQijyZ9LRto5TZYaTSgZKHHigLDhlvDoVUJL+mF2sts4j37Z1jAgtJJp3euxJ2zR4sCc617SWgiVaWZCn0MzL4+SeT6S1UvlLyvgJQts5ZEnmbolvu9Dkg4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768493242; c=relaxed/simple;
	bh=A2ZWOxOGcTpGUVJMmA+xQHJkXlKtUKLLccf/8r9r8CI=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=nQnkcrgBBLii6qVPu40tZuBWWEhYaDPDwYRvXevr/0pHOaq7rIw+6FEjVEIU9IL+hGrdIRmUJk5xC16kUijbgUoi/Y7jkkB4AMoqzrYY2FTUtCYh9r8CPkfyvZebSpPDcEcZW/OW+kCyInSm6nAo840IgS5eCk4MkvHUl1KeujI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=HWGwrmmi; arc=fail smtp.client-ip=40.107.159.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QKwuOZSJM6QYDB83QWAAYtyQClPjkKaCbhL+ocm33TNsgAE/sRLfnIu0gmkQGYixpy1I4RonS9Jvf4My9+/dbyWV8CANRrNJ/xG0NbT94WELL+p4TUOjAJ67XIfGHnP4JDWrT/CJ91qQjxWS58FiqJ/UlCt2U6sWA2urBy/nn2cDrOstB5/3ARhXncg00xmkRXwdBxdXsQrUc5iUYFchM046zCQxXBpmzht3oNFtnRgqLvUr/wOo7r47H8GkevJCziU9/nWPrwMBIIU0oq9h5RmVt417OrqEtYBzn0n1j9EpuyE5sJhl7JZ6j+TkQsW2THU5/tS1mrxhnC+d0x9HGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DJU+q78/Lo7qbjtG5Y6CC7xebt9CIz6/7wuGSrfiKW8=;
 b=qJkgdkv2sFguJNpMKSjYcVYKt8yYo8AACrd/uFJugRQ6kL/I/K3p8NVUWDsm9azDKpygAzNyluRySq4doY8RnoaARWYzOaO+/japvOrFA1NKl1MQHndej92s9YttYrey2okSyaX77ZAZdUPteVcEEmD3JT0cgd/Op55hCvfV2g3rP6DeESQlwapvAy2HiAlALl9VdDkf4s632M7F+Ilc3O+JwxPq6OJFKHmgd5LJFij5GJ0IymbOYdK8FaZG9RuGNqv8CuKc7kZab8yq7DLdGrQabZsr/sr1dp/Qu8BJHncYl2rnH733qqIpMhelbgYfi3XFvTX5X3FAT6rUAIC3rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DJU+q78/Lo7qbjtG5Y6CC7xebt9CIz6/7wuGSrfiKW8=;
 b=HWGwrmmiXKLLXmIlIgGHWDNAsV2xKwP9CcXfdB2u5t9PFVKoEVt5yGk2QKMGDAKrBDeZqvN5nuOVURfACsjMbsSL0dhEa+JMYhLKo7Z33jJUMeOEqYjy+GEPxyvIJZKO/JhRbiBKGYSKCfXbKhWbd3uKJFyYGkSW7AGjAJDZwGMfNclMqp3vwn22Oaqd1B5ulpQ17Xe6mpGPa3d3E3IuYutSWYL0QntcUeNEUAFkaP+vob2ozSAlOlkHgT3lSLKjJzPZPuEs+pzvt1g3jwJQIINz0ZlF5FHMB7c2PbIN5DUS6wPhMnswBe2qALsTLLFcLoiMEd0R2VDqw7Fxka6/ng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8948.eurprd04.prod.outlook.com (2603:10a6:20b:42f::17)
 by VI0PR04MB12235.eurprd04.prod.outlook.com (2603:10a6:800:333::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Thu, 15 Jan
 2026 16:07:17 +0000
Received: from AS8PR04MB8948.eurprd04.prod.outlook.com
 ([fe80::843f:752e:60d:3e5e]) by AS8PR04MB8948.eurprd04.prod.outlook.com
 ([fe80::843f:752e:60d:3e5e%4]) with mapi id 15.20.9499.002; Thu, 15 Jan 2026
 16:07:17 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 15 Jan 2026 11:06:43 -0500
Subject: [PATCH v2 04/13] dmaengine: mxs-dma: Use dev_err_probe() to
 simplify code
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260115-mxsdma-module-v2-4-0e1638939d03@nxp.com>
References: <20260115-mxsdma-module-v2-0-0e1638939d03@nxp.com>
In-Reply-To: <20260115-mxsdma-module-v2-0-0e1638939d03@nxp.com>
To: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, 
 Vinod Koul <vkoul@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: dmaengine@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, Shawn Guo <shawn.guo@freescale.com>, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768493221; l=1567;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=A2ZWOxOGcTpGUVJMmA+xQHJkXlKtUKLLccf/8r9r8CI=;
 b=Xsvi4A27+0vQAsWrJEF2DYiJ+ekW3B0Fu+hvh+UI9506BbBxOLCunKukw5Yi0W6w59obuGFDX
 3l1iaku58XRBVyZOZko7HcdXuGPuRY57IFh8ZD1G6DnjFC7HensjEhv
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH7PR03CA0018.namprd03.prod.outlook.com
 (2603:10b6:510:339::15) To AS8PR04MB8948.eurprd04.prod.outlook.com
 (2603:10a6:20b:42f::17)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8948:EE_|VI0PR04MB12235:EE_
X-MS-Office365-Filtering-Correlation-Id: 9880eac6-2e68-4ff1-2969-08de545027f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|376014|52116014|7416014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cDNTclAyYkVjRmxqb0RoVEY3cHNTWDQwNGIzVzdDS0tRcldXc3hlNDdreXJS?=
 =?utf-8?B?blFJZGFsak5CdXVJYU85ZG5lSVhiakpTcEdoeEJEcW85S21JelZNQXV5QThO?=
 =?utf-8?B?bDR1aDdHdzZRSDFKZGdlbU1RMmdNbkw5WVZKdkQ1UlJJK0plZUtuUTA3NmdW?=
 =?utf-8?B?SERaN2ExaXZkM0sxMisrMFhqSTduL0xGcnZkcjBYVHFnZGFnVm5nS0g3NWxC?=
 =?utf-8?B?NjNvNkdNTlFudXYyR0JOclJWdnlXT1NxQ2R4cHVOTzhMTzhiUDE3d3lIN3VH?=
 =?utf-8?B?NmF0bWl0V28yaklEVWI3TFE2TFpJTEMvOG1NcTdYSXFWa0VsbGlmUm5RRjN4?=
 =?utf-8?B?VENNWEY2eklKbzlXL0NIeGQ4TEJuLzNCM3diYldiRE5jS3FKUUYrVlJKb3dB?=
 =?utf-8?B?Qkoxb3UxUFNRc2ovU0o5M0xLZkU2VzZiaGowdkhHNExXSmhYREt1NWNmekpv?=
 =?utf-8?B?akNuQXVJNnJjMkxhZkFhdTRycUFYRGx2UmhmMzlVZTlWZWpLa3FwK0N4djN0?=
 =?utf-8?B?N0dhYnJHTWZrZGtPdTlKdWxTNmR2SytNOExCRVc5Ukl1R2h3cDJjTm10eUdC?=
 =?utf-8?B?RFFiN2wxZnFuUEdiaklQT2Y2OFBsU3ozRUQvYXloN3Q4eisxSE5DcUJ5c1pS?=
 =?utf-8?B?aXYzTHZqUGg4VlpTUGk3eDdtcFcyTUpCL2NWS2tRV1dPVWVvbkFjVndyb21R?=
 =?utf-8?B?VlpsSTc5Ui96TmF2S1pRdEZ4OGlpVEhkT1RBbHRmN0RZSUh4ZGxYVVFOZE9P?=
 =?utf-8?B?YnQ4eTZjNEg3b3Q5QjJOVFJoTlJSeXpJV2w3bmMyUEorWkV3M1FWZUIxUnFF?=
 =?utf-8?B?WU9GVXNPQzE5RGtQZ1M2UFpSMm5IUDRMMmlzbjI5OWZoc1NQcHVCaXVjZlMw?=
 =?utf-8?B?Z3lNRlk0T2xvakdrOGp2K25Bd1M4S2hYV0M4M3lkVlJmUzJ1N1hIRW5EcVhh?=
 =?utf-8?B?bit2dFRVM3NDQmc1NFpWUGFrVitxOElTcE5TbzdESnJyMGlwcGNGd2cxM1dO?=
 =?utf-8?B?VVVua3I5RkdySFA1L0o3cTFTY2VUMnZQRlZBdklQbUZ2YWFhaytlQm9LcXIx?=
 =?utf-8?B?aFNDZDM2bXlTeHIvQ1RlcW9hVlA2MlFrUUxJMEZjVTdNWHVkMU5yWEJOT1JY?=
 =?utf-8?B?eXVlMnl1U3Q5Z21iY0o4NmVlU1ZNYUVDYkNNNXhZNlljNTdCZ2swMmVQOEg3?=
 =?utf-8?B?Y0k1SWl2K1BMTlMvaXkyc2pRYVVtN1JMa0M2WHJPNWNHRmh6Nm14UEhnN2J0?=
 =?utf-8?B?N2dkaXFxTkMrSFk1MDRNTit4c0NDdm50TUdIKzdvY1pORWNiejY0YmNlN00x?=
 =?utf-8?B?N1lHSlhYd3llZTRJeG0yYmZaUlg3Q01CR25qSXBqMys4RjJSK3dUNytsUWZV?=
 =?utf-8?B?VFFyeDI2Y0crdFFINWxKT3BhMmxRbkJjbnJiOUJFdzZFbWE5clpIUU1yOHhp?=
 =?utf-8?B?dXQ2dVphUEc3OS9CZGN6TnlzaGJuTnp3SUVhR2thVHY4RmkzaGM3QS8yNUk5?=
 =?utf-8?B?R1dNMU1Oc3VZSHVEdnpxS25uTFFRTzJkckJxeU52M0FNZ2FPWmVkaFRWUXNU?=
 =?utf-8?B?RVp0VDJOb0dlYkc1MkU4TUowZkhoZy9aNFlKdGNEVjd2MEx6Nmt4cGpJRzl4?=
 =?utf-8?B?OE1IWXhPQXdCTjN5YVhyZ2JodWlBem5tdk8xN3NoNDlKWkZkemF2WUg2TUhD?=
 =?utf-8?B?Nk9QeUNxK0t4TnA0UG1EMmE1ZGZOaEJQd3hMcjhOVjBxSkNIZjNubDg2ZHBv?=
 =?utf-8?B?SDNmdStBZ0ZQWXRCeWMxK1E3RmEwVGVjRmpHRlR6dFkwWXRpb1FjWmZqRGtC?=
 =?utf-8?B?YlMvK3VsSWo2Tkt1UDIyZHBaQ2F6VFJnaHk1ZjNZZis5aEduWlZ6VnduVmZ4?=
 =?utf-8?B?Q3NkUXFxU24xYzROd0RIMVZoVm5FazhDcXpmcU1YTy84c3dWMWl0ajRtdVg2?=
 =?utf-8?B?QzIwOHJrZU8rdktSeEhoZkJZMTQyV0N1b005V0lsNGxoZ0lBWTEzMUVJQlgx?=
 =?utf-8?B?YTVjeWVmR2o3R1UvaFZuWnhURFAyOWl3dFlvUUV5ZHpUK29mOTRYTlhWRE5v?=
 =?utf-8?B?RkliNWZiL21ib2gxVVk2T3orRExRaUo3ZEU3UzdQYkNZQkNNK1I1b1dHSVJ4?=
 =?utf-8?B?STlrYW1Mb0xTK0k1aUxCdVgwdHB1RnBOOS83blMyUjhvRnllNU9aV3BWZEJt?=
 =?utf-8?Q?zv4k8VxlHzuCmF5U3cn/wf0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8948.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(52116014)(7416014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RTJ0bUhuWUdzVUYyQ3M4ZVA1Ujc3QjFDL3NoY3E1MElKYnNqUDJUeUxtYUE4?=
 =?utf-8?B?TS9EaDdDajI1OEpuVGwrdjVlQ2Q3Y09SdUhWM3N2a2VOY1FCNXBrZ2taVXdh?=
 =?utf-8?B?SlFtOG9NWXVOYmNqRG5oTVp1cDJvcEF1WER6aTBLWEFiZlp6NllSTmF5a2dk?=
 =?utf-8?B?V1lqY29XMElhWms1SDFoa0NHMU9keGNXT09QZThmYTVLaXFFV2xJM09MbEta?=
 =?utf-8?B?cEdibTIwSUhCMm5zQTU5OG9NMU1zaUlWVktaUm9YTGt4bDVIU0xTdEt5WGc2?=
 =?utf-8?B?YWlvcUJDNEtjZGQrU1Y2RnVrMmdkM01qaDVweTAvU2Nic1E3UW9PazVsZGU1?=
 =?utf-8?B?ZkhsN2dBbDdGNWEyTWNZaGFYcjB2NEdwemp3bDM1OG9iZlNuWnY4NHF2dlFO?=
 =?utf-8?B?ZG1ERy9nbG1vSGVtZFkvSHVzT0dIV0RKdEF2RG5LbTNsUm9GcWFzcFlRcS9I?=
 =?utf-8?B?RVorTjFlTGlqN1FoOVdrQzlncDNjeWlURnh3akxYTHFBZStTdnpUZHJpNUNl?=
 =?utf-8?B?dTZtNmtWbFZSSjB6Nkh2QVJOeXJHcE1oR1h6NzRScHcwU1pwbVJ4Vnc1UFZZ?=
 =?utf-8?B?WVRrbmlkcERUd1FSd2hhd2h1dUJhTEZpcjdjUVlHK1ltblpGQzZMSnhPVGRG?=
 =?utf-8?B?eS81V1UvVzM2elFSV2N5bnVtMDZ3ZzVlT0RVL2xyekRwenl6aE5TQWZHUFhs?=
 =?utf-8?B?cWJyYTcrOHY3ejhnYWZ2QnBxZHlXUHFGTWpZMTcxZ0N0TW9nWmU1OGZHNGVQ?=
 =?utf-8?B?RjBBTWhmWThlaE43WlBRaVdjdVF2NlQwUjN4eGovbEsrUmVRcXh4emJGWkpZ?=
 =?utf-8?B?U1pnYjFmRWI1RTltMmdVTzhGMkpQcFg4dHRsK2pqdThmd2Z1eVFvazZiT2h0?=
 =?utf-8?B?c0VCbXB6K1Y4TmxoL2t3WkwrSS93MUxBL2Q2bVQveFZ4NE5YcmxZampRcFl1?=
 =?utf-8?B?SzBkNUMxaUViSVNsY0l2eG1UOFg2cHRLVlZZUUJQYW9wMXRLMkpiaDljT2FY?=
 =?utf-8?B?OHBGQW5TZTVva0I1S05hNytCZE5GKzhmZm4rdlFRSkN3TytUL3ovSzZqNWpP?=
 =?utf-8?B?ZDQ2WTdhb1kyOVNSUE1tQkpxMVFqamVOQmxTUmdoWXI4TDFqUlpXd3B3YjVF?=
 =?utf-8?B?Zk1RMk9KbGZISUthMlR0cUs3V0NIcnpOdEd3UzBBa1I2a1NBU2NLcHZPTHlP?=
 =?utf-8?B?aHM3eEtvQUgyNDFLMVQ2VEp1NWFrR29FcUp4R0FoaW5icFdxenZ2RWQwcEZ5?=
 =?utf-8?B?a0VwR2tuNnVyS1c0OU9Xc0VSVFdqd2hCV0hnd1c1aHhVK1VBT3BqOEI5WHha?=
 =?utf-8?B?QS9RR2cxOVpza3d0bkZBeHpBZnpUVHJLRFFOTmRsMzVyNThMbnBxZFpQbXU2?=
 =?utf-8?B?S2pvTjlGeXUrYXh0NGlwTStJd3phb0Y1aHFlZHRVMzlRM0w3SEYvaFREU1Zt?=
 =?utf-8?B?bEJtbDBBMHJWZHdTcmVtakxCUjNGVHNpVDhZRHprS2dKbENtekRqNllqTTBP?=
 =?utf-8?B?YVlybExxNmFWR2xMNWJxTXJXNUdjOUxZb3ZWWXRUNENlWE5laVM1UXEvRlda?=
 =?utf-8?B?VFNKMVY4Qm5TaTFhcGF4dmd2ek8wNjZDZHY4TVNYLy9iVEMrcmF3dllrcERM?=
 =?utf-8?B?NzZ1K3A4SysvajhUZmZ2S0M3RWFiSjYxYWVsQWRQVHpQSDUvVEs3ZE5SU0cr?=
 =?utf-8?B?Z1ExSEFWSTVEVmcyRzU1K0NUTkZMd1pZdjV2WGxIZW1VUGoxcWRMRy91Vmtq?=
 =?utf-8?B?OW5xUVdSd3lpQ21DUHNLY3VyZ1JvWjBheGdUN3FBQ2g1ckJxQ0FoRkVlMjNo?=
 =?utf-8?B?RW9SVkJ5cFNYdEZQMWlWRll4Y0pHWXZQVEtkYTI4SzNVbHh2Y2FGaGN2ZHpa?=
 =?utf-8?B?WkFncWJodGFvYW82ZjdUbnN5TUwvZnRKQm1HTkFMRktiUG5KYmhidExmQ0lI?=
 =?utf-8?B?VjBldWpMQXFGdnRIaG92UjUra1ZoOGJkUkhRUlVjdXVsc01UMWVOZmpVY1BO?=
 =?utf-8?B?WUd2VW5nVzFUVFlkeVZwcnBzeS9tc0gxSEFUSmUzMHRwN2dZWXhZK3QyOEo2?=
 =?utf-8?B?ZWIxOGhPMk9sdzh2Qlk0aWIveXZ2RGY4STZOVFVyNFA1UWwySU5tUmo0a2hS?=
 =?utf-8?B?Z0k4eFhvcERXRWFwZ2xCNisyRis3a1cwVXNzL3RUZmxFZkR0YURqQ0ZRckNt?=
 =?utf-8?B?eVlBbVQvVy9XemhacTY0eVZMMjVWTklHaUlaRkFyaUtkN3VGb21wVU5NUVQz?=
 =?utf-8?B?SnJIdDltcWFkeWJNNHlaektPMHM0djZSME1SaHFuTzZuQTBsSWJhbnduVElh?=
 =?utf-8?B?K1VLbml3emNVcXdCWlhqbHRSK21abnRRelozakNyblJWNkpKTjFLUT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9880eac6-2e68-4ff1-2969-08de545027f0
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8948.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 16:07:17.8487
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yhcAqhsKJF0vq/Umz5iMjn9ImkMW5aAwZV1psCxTaWyyu9sDaw8jzsTH88cPIPRCp2zw6GATbsLM3WQwMTQNhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB12235

Use dev_err_probe() simplify code. No functional change.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/mxs-dma.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/drivers/dma/mxs-dma.c b/drivers/dma/mxs-dma.c
index dbc8747de591cc83e39ef873633418f41b5ea982..c1d4c6690df1af476aeafe77ff7f78bff1e413f1 100644
--- a/drivers/dma/mxs-dma.c
+++ b/drivers/dma/mxs-dma.c
@@ -753,10 +753,8 @@ static int mxs_dma_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	ret = of_property_read_u32(np, "dma-channels", &mxs_dma->nr_channels);
-	if (ret) {
-		dev_err(dev, "failed to read dma-channels\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to read dma-channels\n");
 
 	dma_type = (struct mxs_dma_type *)of_device_get_match_data(dev);
 	mxs_dma->type = dma_type->type;
@@ -816,17 +814,13 @@ static int mxs_dma_probe(struct platform_device *pdev)
 	mxs_dma->dma_device.device_issue_pending = mxs_dma_enable_chan;
 
 	ret = dmaenginem_async_device_register(&mxs_dma->dma_device);
-	if (ret) {
-		dev_err(dev, "unable to register\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "unable to register\n");
 
 	ret = of_dma_controller_register(np, mxs_dma_xlate, mxs_dma);
-	if (ret) {
-		dev_err(dev,
-			"failed to register controller\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "failed to register controller\n");
 
 	dev_info(mxs_dma->dma_device.dev, "initialized\n");
 

-- 
2.34.1


