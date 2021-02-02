Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A5EB30B673
	for <lists+dmaengine@lfdr.de>; Tue,  2 Feb 2021 05:26:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbhBBEZj (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 1 Feb 2021 23:25:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231569AbhBBEZi (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 1 Feb 2021 23:25:38 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CC57C06174A
        for <dmaengine@vger.kernel.org>; Mon,  1 Feb 2021 20:24:58 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id j11so330349wmi.3
        for <dmaengine@vger.kernel.org>; Mon, 01 Feb 2021 20:24:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:sender:from:mime-version:content-transfer-encoding
         :content-description:subject:to:date:reply-to;
        bh=PrILWatQiBB/YexVPvDZsH566iBzGTKnf23zrhwD0wk=;
        b=XlZuq/HTZ6O804yKGQU3dA+4ZUdB5yP9W4Zu3pmwpkeCn0XWtAfec0vGnUf2/XzQIS
         3zBx5xFuxBfW/qBsJ98K5apgLwbpIYnnp4GCWaC4AP9OCW60rwKqGEDsSxlUORMQpaWU
         4dwPXe2NegnY/WJtG5GwWJbQn8opeS4oSJol7ab2lSgpc0TJzyPAT6a7WO1W3xtYBvmv
         PDEhAwD5xBSlgMR4zWl5HPD4mBCX47yLom/KQjwodojAxaLOPIpzJDHLGvuG1534YKlo
         3PXpdZVOYfbRGrHoIFpWMGjLJOlulyT6Lwks0kXkgVzrgHaM72Qo2n7w5n3hGMZQdZ3h
         a5RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:sender:from:mime-version
         :content-transfer-encoding:content-description:subject:to:date
         :reply-to;
        bh=PrILWatQiBB/YexVPvDZsH566iBzGTKnf23zrhwD0wk=;
        b=YIljg5uP4IG+jVSixwrL+Q4ghPl/3HRB7Clz3P+825cX9NUmu0JQj/kxTCBiiVMNNj
         C4I+lrKPSpKj/TQ0l8JoK+sywejyU+bELcbmqr2Pt9VF/W0MoVD9WdOmu56f5Su0AfHO
         3efhb36+TW/uQdaGCu5Jf3udi2rdqUF+CaEDbyo7yB+q1xLDuhgyt/AsG87JuZsH82To
         H+n595ITsTg9I6yei2W+FNrh4Cm7sKG1Hid7ic4a2NrZMmdKhCd45NsbciOkfPuRRCUw
         rlTXxuXi9L9oZ2jwib92y0xjLcPNH7sb/ATW8JPYVIc8Sn2C+rMqkAaXQy4OJJlUTAzA
         tDzw==
X-Gm-Message-State: AOAM5315QjqTyvaw2RgFaLFPJii15gJWcDU0xN+n8HAfOQdgJE2J/UI6
        InldOtTKxeHUSKCK6Ba4Yt1aT+DwtCd6uw==
X-Google-Smtp-Source: ABdhPJw3VKWWLbu6Ya9CrpRxtsE/FJna48kL1Q8TqJaW2fQwpO0yDWMD5kpt3totWZgNzhIlUZqBIQ==
X-Received: by 2002:a1c:7211:: with SMTP id n17mr1729365wmc.102.1612239897094;
        Mon, 01 Feb 2021 20:24:57 -0800 (PST)
Received: from [192.168.1.8] ([41.83.208.55])
        by smtp.gmail.com with ESMTPSA id u14sm1237173wmq.45.2021.02.01.20.24.52
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 01 Feb 2021 20:24:56 -0800 (PST)
Message-ID: <6018d418.1c69fb81.e8a3b.4d93@mx.google.com>
Sender: skylar anderson <sarr43022@gmail.com>
From:   Skylar Anderson <sgt.skylaranderson200@gmail.com>
X-Google-Original-From: Skylar Anderson
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: si
To:     Recipients <Skylar@vger.kernel.org>
Date:   Tue, 02 Feb 2021 04:24:48 +0000
Reply-To: sgt.skylaranderson200@gmail.com
X-Mailer: cdcaafe51be8cdb99a1c85906066cad3d0e60e273541515a58395093a7c4e1f0eefb01d7fc4e6278706e9fb8c4dad093c3263345202970888b6b4d817f9e998c032e7d59
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

esto es urgente / can we talk this
