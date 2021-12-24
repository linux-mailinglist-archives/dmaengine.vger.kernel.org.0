Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5952E47F0DD
	for <lists+dmaengine@lfdr.de>; Fri, 24 Dec 2021 21:06:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353510AbhLXUGZ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 24 Dec 2021 15:06:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353499AbhLXUGZ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 24 Dec 2021 15:06:25 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96277C061401
        for <dmaengine@vger.kernel.org>; Fri, 24 Dec 2021 12:06:24 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id p1-20020a1c7401000000b00345c2d068bdso5247094wmc.3
        for <dmaengine@vger.kernel.org>; Fri, 24 Dec 2021 12:06:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:mime-version:content-transfer-encoding
         :content-description:subject:to:date:reply-to;
        bh=UtoF0r4yG8U/T8UOLxn8dacSd49m7zi2Qvhr7fGOaoo=;
        b=bQeqSEvpoobccviYQfC2c6fwYFxGUXtlwR5xPDt15V57VDQAD5ZyOplCi7Sjq5FIdT
         FAHICGU2w51xYZ8DcKPSW3dg4J9t33cDO6qZTx8zgDKh07Av9gi+ySXL8Vc8Nv1DqFsH
         wWIBlTilUn31UOXJC4yyaiNkpik5NwyN7a57e+zcpW+eWBhoW1EqTs3vaEMH4JC9DI6V
         6U0lXaQxafohoF3BDY8rUyUsse9VRDdS15jwaRdwSgnD+MT6VkxmG7o5jCwvyQf+9o0Y
         h40s36X54fAGJSMMMzsvPWWhDSlbEVeyzZIlqXogo945QPcU+uphiWwrUL5Ia1b30cyV
         8BHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:mime-version
         :content-transfer-encoding:content-description:subject:to:date
         :reply-to;
        bh=UtoF0r4yG8U/T8UOLxn8dacSd49m7zi2Qvhr7fGOaoo=;
        b=AynaXrITQAdNLrkpWf7vT9g21TRmbQVhlmnZYvvG8wP5C2wySrNYHlSjRudY7oh3bW
         raHN+5rOv3gAqDwKOqQU51OGE9QXRhkZiJMWA6kGIHXSEMltqBnfh4eG8wPoHx5V2PyR
         W/72Tj/fpgiDWrvFeLP26bndtUX0JJVsl9OmnOqgxhJ+37Ks2zYRPnxRG9GYxS+BlYve
         pdfg3l8hy2H4UjNOKq+/GjsaqMy3EsgRfw3QlcpZT4pVeDAMsCXmpYvk11ecAK6+fVBi
         Wncq+sSEJInY4P7RsVH0lY6pFMA2rEbS3+8BzGr9H9pfSM57kOolZPXSabJ1FkkwkoDa
         3uPQ==
X-Gm-Message-State: AOAM531dqopOdWg5Qs/tjJ49v1yMzGxTAno4gJxzo254HLlXTaNohukS
        uPMNbjbh/VMu+J0DXmESxAw=
X-Google-Smtp-Source: ABdhPJx9LkTYYNVY0hIXM7OQrDUw54RvtxVTHueSAvOh9MyTUhMckr7bv0BbTUuKDeRZKj+1XB9RJQ==
X-Received: by 2002:a05:600c:19d0:: with SMTP id u16mr5791221wmq.148.1640376383317;
        Fri, 24 Dec 2021 12:06:23 -0800 (PST)
Received: from [192.168.9.102] ([197.211.59.108])
        by smtp.gmail.com with ESMTPSA id r8sm8598345wru.107.2021.12.24.12.06.18
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 24 Dec 2021 12:06:22 -0800 (PST)
Message-ID: <61c6283e.1c69fb81.caf63.7012@mx.google.com>
From:   Margaret Leung KO May-yee <kurtatgloria890@gmail.com>
X-Google-Original-From: Margaret Leung KO May-yee
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: =?utf-8?q?Gesch=C3=A4ftsvorschlag?=
To:     Recipients <Margaret@vger.kernel.org>
Date:   Fri, 24 Dec 2021 21:06:14 +0100
Reply-To: la67737777@gmail.com
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Bin Frau Margaret Leung Ich habe einen Gesch=E4ftsvorschlag f=FCr Sie, erre=
ichen Sie mich unter: la67737777@gmail.com

Margaret Leung
Managing Director of Chong Hing Bank
